import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:souq_app/features/products/data/datasource/products_remote_datasource.dart';
import 'package:souq_app/features/products/domain/entity/product_entity.dart';
import 'package:souq_app/features/products/presentation/models/product_filter_state.dart';
import '../../../../core/network/dio_client.dart';
import '../../data/repository/product_repository_impl.dart';
import '../../domain/repository/product_repository.dart';

final dioClientProvider = Provider<DioClient>((ref) => DioClient());

final productsRemoteDataSourceProvider = Provider<ProductsRemoteDataSource>((ref) {
  return ProductsRemoteDataSourceImpl(ref.watch(dioClientProvider));
});

final productRepositoryProvider = Provider<ProductRepository>((ref) {
  return ProductRepositoryImpl(ref.watch(productsRemoteDataSourceProvider));
});

final fetchProductsProvider = FutureProvider<List<ProductEntity>>((ref) async {
  final repository = ref.watch(productRepositoryProvider);
  final result = await repository.getProducts();

  if (result.failure != null) {
    throw Exception(result.failure!.message);
  }
  return result.products ?? [];
});

final fetchCategoriesProvider = FutureProvider<List<String>>((ref) async {
  final repository = ref.watch(productRepositoryProvider);
  final result = await repository.getCategories();

  if (result.failure != null) {
    throw Exception(result.failure!.message);
  }

  return result.categories ?? [];
});

class ProductFilterNotifier extends Notifier<ProductFilterState> {
  @override
  ProductFilterState build() => const ProductFilterState();

  void setSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
  }

  void selectCategory(String? category) {
    if (category == null) {
      state = state.copyWith(clearCategory: true);
    } else if (state.selectedCategory == category) {
      state = state.copyWith(clearCategory: true);
    } else {
      state = state.copyWith(selectedCategory: category);
    }
  }
  void setSortOption(ProductSortOption option) {
    state = state.copyWith(sortOption: option);
  }

  void resetFilters() {
    state = const ProductFilterState();
  }
}

final productFilterNotifierProvider =
    NotifierProvider<ProductFilterNotifier, ProductFilterState>(
  ProductFilterNotifier.new,
);

final filteredProductsProvider = Provider<AsyncValue<List<ProductEntity>>>((ref) {
  final productsAsync = ref.watch(fetchProductsProvider);
  final filter = ref.watch(productFilterNotifierProvider);

  return productsAsync.whenData((products) {
    var result = List<ProductEntity>.from(products);

    if (filter.selectedCategory != null && filter.selectedCategory!.isNotEmpty) {
      result = result
          .where((p) => p.category.toLowerCase() == filter.selectedCategory!.toLowerCase())
          .toList();
    }

    if (filter.searchQuery.trim().isNotEmpty) {
      final query = filter.searchQuery.trim().toLowerCase();
      result = result.where((p) {
        final titleMatch = p.title.toLowerCase().contains(query);
        final descMatch = p.description.toLowerCase().contains(query);
        return titleMatch || descMatch;
      }).toList();
    }

    switch (filter.sortOption) {
      case ProductSortOption.priceLowToHigh:
        result.sort((a, b) => a.price.compareTo(b.price));
        break;
      case ProductSortOption.priceHighToLow:
        result.sort((a, b) => b.price.compareTo(a.price));
        break;
      case ProductSortOption.ratingHighToLow:
        result.sort((a, b) => b.rating.rate.compareTo(a.rating.rate));
        break;
      case ProductSortOption.none:
        break;
    }

    return result;
  });
});

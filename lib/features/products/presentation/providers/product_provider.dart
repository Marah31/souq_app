import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:souq_app/features/products/domain/entity/product_entity.dart';
import 'package:souq_app/features/products/presentation/models/product_filter_state.dart';
import 'package:souq_app/features/products/presentation/providers/products_providers.dart';

final fetchProductsProvider = FutureProvider<List<ProductEntity>>((ref) async {
  final getProducts = ref.watch(getProductsUseCaseProvider);
  final result = await getProducts();

  if (result.failure != null) {
    throw Exception(result.failure!.message);
  }

  return result.products ?? [];
});

final fetchCategoriesProvider = FutureProvider<List<String>>((ref) async {
  final getCategories = ref.watch(getCategoriesUseCaseProvider);
  final result = await getCategories();

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
    state = state.copyWith(selectedCategory: () => category);
  }

  void setSortOption(ProductSortOption sortOption) {
    state = state.copyWith(sortOption: sortOption);
  }

  void resetFilters() {
    state = const ProductFilterState();
  }
}
final productFilterNotifierProvider =
    NotifierProvider<ProductFilterNotifier, ProductFilterState>(
  ProductFilterNotifier.new,
);

final filteredProductsProvider = FutureProvider<List<ProductEntity>>((ref) async {
  final allProducts = await ref.watch(fetchProductsProvider.future);
  final filter = ref.watch(productFilterNotifierProvider);
  final searchProductsUseCase = ref.read(searchProductsUseCaseProvider);

  final searchResult = await searchProductsUseCase(
    query: filter.searchQuery,
    sourceProducts: allProducts,
  );

  List<ProductEntity> list = List.from(searchResult.products ?? []);

  final category = filter.selectedCategory;
  if (category != null && category.trim().isNotEmpty && category.toLowerCase() != 'all') {
    list = list.where((p) => p.category.toLowerCase() == category.toLowerCase()).toList();
  }

  switch (filter.sortOption) {
    case ProductSortOption.priceLowToHigh:
      list.sort((a, b) => a.price.compareTo(b.price));
      break;
    case ProductSortOption.priceHighToLow:
      list.sort((a, b) => b.price.compareTo(a.price));
      break;
    case ProductSortOption.ratingHighToLow:
      list.sort((a, b) => b.rating.rate.compareTo(a.rating.rate));
      break;
    case ProductSortOption.none:
      break;
  }

  return list;
});
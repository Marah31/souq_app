import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:souq_app/features/products/domain/entity/product_entity.dart';
import 'package:souq_app/features/products/presentation/providers/products_providers.dart';

class ProductsState {
  final bool isLoading;
  final List<ProductEntity> products;
  final List<ProductEntity> filteredProducts;
  final String? errorMessage;
  final String selectedCategory;

  const ProductsState({
    this.isLoading = false,
    this.products = const [],
    this.filteredProducts = const [],
    this.errorMessage,
    this.selectedCategory = 'all',
  });

  ProductsState copyWith({
    bool? isLoading,
    List<ProductEntity>? products,
    List<ProductEntity>? filteredProducts,
    String? errorMessage,
    String? selectedCategory,
  }) {
    return ProductsState(
      isLoading: isLoading ?? this.isLoading,
      products: products ?? this.products,
      filteredProducts: filteredProducts ?? this.filteredProducts,
      errorMessage: errorMessage,
      selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }
}

class ProductsNotifier extends Notifier<ProductsState> {
  @override
  ProductsState build() {
    loadProducts();
    return const ProductsState(isLoading: true);
  }

  Future<void> loadProducts() async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    final getProducts = ref.read(getProductsUseCaseProvider);
    final result = await getProducts();

    if (result.failure != null) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: result.failure!.message,
      );
    } else {
      final list = result.products ?? [];
      state = state.copyWith(
        isLoading: false,
        products: list,
        filteredProducts: list,
      );
    }
  }

  Future<void> search(String query) async {
    final searchProducts = ref.read(searchProductsUseCaseProvider);
    final result = await searchProducts(
      query: query,
      sourceProducts: state.products, 
    );

    if (result.failure == null && result.products != null) {
      state = state.copyWith(filteredProducts: result.products!);
    }
  }

  Future<void> filterByCategory(String category) async {
    if (category == 'all') {
      state = state.copyWith(
        selectedCategory: 'all',
        filteredProducts: state.products,
      );
      return;
    }

    state = state.copyWith(isLoading: true, selectedCategory: category);

    final getProductsByCategory = ref.read(getProductsByCategoryUseCaseProvider);
    final result = await getProductsByCategory(category);

    if (result.failure != null) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: result.failure!.message,
      );
    } else {
      state = state.copyWith(
        isLoading: false,
        filteredProducts: result.products ?? [],
      );
    }
  }
}

final productsNotifierProvider = NotifierProvider<ProductsNotifier, ProductsState>(
  ProductsNotifier.new,
);
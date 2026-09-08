enum ProductSortOption {
  none,
  priceLowToHigh,
  priceHighToLow,
  ratingHighToLow,
}
class ProductFilterState {
  final String searchQuery;
  final String? selectedCategory;
  final ProductSortOption sortOption;

  const ProductFilterState({
    this.searchQuery = '',
    this.selectedCategory,
    this.sortOption = ProductSortOption.none,
  });

  ProductFilterState copyWith({
    String? searchQuery,
    String? selectedCategory,
    bool clearCategory = false,
    ProductSortOption? sortOption,
  }) {
    return ProductFilterState(
      searchQuery: searchQuery ?? this.searchQuery,
      selectedCategory: clearCategory ? null : (selectedCategory ?? this.selectedCategory),
      sortOption: sortOption ?? this.sortOption,
    );
  }
}


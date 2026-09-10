import 'package:equatable/equatable.dart';

enum ProductSortOption { none, priceLowToHigh, priceHighToLow, ratingHighToLow }

class ProductFilterState extends Equatable {
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
    String? Function()? selectedCategory, 
    ProductSortOption? sortOption,
  }) {
    return ProductFilterState(
      searchQuery: searchQuery ?? this.searchQuery,
      selectedCategory: selectedCategory != null ? selectedCategory() : this.selectedCategory,
      sortOption: sortOption ?? this.sortOption,
    );
  }

  @override
  List<Object?> get props => [searchQuery, selectedCategory, sortOption];
}
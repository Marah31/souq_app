import 'package:souq_app/core/error/failure.dart';
import 'package:souq_app/features/products/domain/entity/product_entity.dart';
import 'package:souq_app/features/products/domain/repository/product_repository.dart';

class SearchProducts {
  final ProductRepository _repository;

  SearchProducts(this._repository);
  Future<({Failure? failure, List<ProductEntity>? products})> call({
    required String query,
    List<ProductEntity>? sourceProducts,
  }) async {
    final cleanQuery = query.trim().toLowerCase();

    if (cleanQuery.isEmpty) {
      if (sourceProducts != null) {
        return (failure: null, products: sourceProducts);
      }
      return await _repository.getProducts();
    }

    List<ProductEntity> targetList = sourceProducts ?? [];

    if (sourceProducts == null) {
      final result = await _repository.getProducts();
      if (result.failure != null) {
        return (failure: result.failure, products: null);
      }
      targetList = result.products ?? [];
    }

    final filtered = targetList.where((product) {
      final titleMatch = product.title.toLowerCase().contains(cleanQuery);
      final categoryMatch = product.category.toLowerCase().contains(cleanQuery);
      return titleMatch || categoryMatch;
    }).toList();

    return (failure: null, products: filtered);
  }
}
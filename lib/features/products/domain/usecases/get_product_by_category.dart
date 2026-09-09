import 'package:souq_app/core/error/failure.dart';
import 'package:souq_app/features/products/domain/entity/product_entity.dart';
import 'package:souq_app/features/products/domain/repository/product_repository.dart';

class GetProductsByCategory {
  final ProductRepository repository;

  GetProductsByCategory(this.repository);

  Future<({Failure? failure, List<ProductEntity>? products})> call(String category) {
    return repository.getProductsByCategory(category);
  }
}
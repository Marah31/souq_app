import 'package:souq_app/core/error/failure.dart';
import 'package:souq_app/features/products/domain/entity/product_entity.dart';
import 'package:souq_app/features/products/domain/repository/product_repository.dart';

class GetProducts {
  final ProductRepository repository;

  GetProducts(this.repository);

  Future<({Failure? failure, List<ProductEntity>? products})> call() {
    return repository.getProducts();
  }
}
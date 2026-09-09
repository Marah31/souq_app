import 'package:souq_app/core/error/failure.dart';
import 'package:souq_app/features/products/domain/entity/product_entity.dart';
import 'package:souq_app/features/products/domain/repository/product_repository.dart';

class GetProductById {
  final ProductRepository repository;

  GetProductById(this.repository);

  Future<({Failure? failure, ProductEntity? product})> call(int id) {
    return repository.getProductById(id);
  }
}
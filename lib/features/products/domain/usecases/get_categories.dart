import 'package:souq_app/core/error/failure.dart';
import 'package:souq_app/features/products/domain/repository/product_repository.dart';

class GetCategories {
  final ProductRepository repository;

  GetCategories(this.repository);

  Future<({Failure? failure, List<String>? categories})> call() {
    return repository.getCategories();
  }
}
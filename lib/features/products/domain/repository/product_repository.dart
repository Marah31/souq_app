import 'package:souq_app/core/error/failure.dart';
import 'package:souq_app/features/products/domain/entity/product_entity.dart';

abstract class ProductRepository {
  Future<({Failure? failure, List<ProductEntity>? products})> getProducts();
  Future<({Failure? failure, ProductEntity? product})> getProductById(int id);
  Future<({Failure? failure, List<String>? categories})> getCategories();
  Future<({Failure? failure, List<ProductEntity>? products})> getProductsByCategory(String category);
}
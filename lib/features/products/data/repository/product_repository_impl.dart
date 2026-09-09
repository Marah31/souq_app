import 'package:souq_app/core/error/exception.dart';
import 'package:souq_app/core/error/failure.dart';
import 'package:souq_app/features/products/data/datasource/products_remote_datasource.dart';
import 'package:souq_app/features/products/domain/entity/product_entity.dart';
import 'package:souq_app/features/products/domain/repository/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductsRemoteDataSource _remoteDataSource;

  ProductRepositoryImpl(this._remoteDataSource);

  @override
  Future<({Failure? failure, List<ProductEntity>? products})> getProducts() async {
    try {
      final dtos = await _remoteDataSource.getProducts();
      final entities = dtos.map((dto) => dto.toEntity()).toList();
      return (failure: null, products: entities);
    } on NetworkException catch (e) {
      return (failure: NetworkFailure(e.message), products: null);
    } on ServerException catch (e) {
      return (failure: ServerFailure(e.message, statusCode: e.statusCode), products: null);
    } catch (e) {
      return (failure: UnknownFailure(e.toString()), products: null);
    }
  }

  @override
  Future<({Failure? failure, ProductEntity? product})> getProductById(int id) async {
    try {
      final dto = await _remoteDataSource.getProductById(id);
      return (failure: null, product: dto.toEntity());
    } on NetworkException catch (e) {
      return (failure: NetworkFailure(e.message), product: null);
    } on ServerException catch (e) {
      return (failure: ServerFailure(e.message, statusCode: e.statusCode), product: null);
    } catch (e) {
      return (failure: UnknownFailure(e.toString()), product: null);
    }
  }

  @override
  Future<({Failure? failure, List<String>? categories})> getCategories() async {
    try {
      final categories = await _remoteDataSource.getCategories();
      return (failure: null, categories: categories);
    } on NetworkException catch (e) {
      return (failure: NetworkFailure(e.message), categories: null);
    } on ServerException catch (e) {
      return (failure: ServerFailure(e.message, statusCode: e.statusCode), categories: null);
    } catch (e) {
      return (failure: UnknownFailure(e.toString()), categories: null);
    }
  }

  @override
  Future<({Failure? failure, List<ProductEntity>? products})> getProductsByCategory(String category) async {
    try {
      final dtos = await _remoteDataSource.getProductsByCategory(category);
      final entities = dtos.map((dto) => dto.toEntity()).toList();
      return (failure: null, products: entities);
    } on NetworkException catch (e) {
      return (failure: NetworkFailure(e.message), products: null);
    } on ServerException catch (e) {
      return (failure: ServerFailure(e.message, statusCode: e.statusCode), products: null);
    } catch (e) {
      return (failure: UnknownFailure(e.toString()), products: null);
    }
  }
}
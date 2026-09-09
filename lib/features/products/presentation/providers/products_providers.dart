import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:souq_app/core/network/dio_client.dart';
import 'package:souq_app/features/products/data/datasource/products_remote_datasource.dart';
import 'package:souq_app/features/products/data/repository/product_repository_impl.dart';
import 'package:souq_app/features/products/domain/repository/product_repository.dart';
import 'package:souq_app/features/products/domain/usecases/get_categories.dart';
import 'package:souq_app/features/products/domain/usecases/get_product_by_category.dart';
import 'package:souq_app/features/products/domain/usecases/get_product_by_id.dart';
import 'package:souq_app/features/products/domain/usecases/get_products.dart';
import 'package:souq_app/features/products/domain/usecases/search_product.dart';

final dioClientProvider = Provider<DioClient>((ref) => DioClient());

final productsRemoteDataSourceProvider = Provider<ProductsRemoteDataSource>((ref) {
  final client = ref.watch(dioClientProvider);
  return ProductsRemoteDataSourceImpl(client);
});

final productRepositoryProvider = Provider<ProductRepository>((ref) {
  final remoteDataSource = ref.watch(productsRemoteDataSourceProvider);
  return ProductRepositoryImpl(remoteDataSource);
});

final getProductsUseCaseProvider = Provider<GetProducts>((ref) {
  final repository = ref.watch(productRepositoryProvider);
  return GetProducts(repository);
});

final getProductByIdUseCaseProvider = Provider<GetProductById>((ref) {
  final repository = ref.watch(productRepositoryProvider);
  return GetProductById(repository);
});

final getCategoriesUseCaseProvider = Provider<GetCategories>((ref) {
  final repository = ref.watch(productRepositoryProvider);
  return GetCategories(repository);
});

final getProductsByCategoryUseCaseProvider = Provider<GetProductsByCategory>((ref) {
  final repository = ref.watch(productRepositoryProvider);
  return GetProductsByCategory(repository);
});

final searchProductsUseCaseProvider = Provider<SearchProducts>((ref) {
  final repository = ref.watch(productRepositoryProvider);
  return SearchProducts(repository);
});
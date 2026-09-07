import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:souq_app/features/products/data/datasource/products_remote_datasource.dart';
import 'package:souq_app/features/products/domain/entity/product_entity.dart';
import '../../../../core/network/dio_client.dart';
import '../../data/repository/product_repository_impl.dart';
import '../../domain/repository/product_repository.dart';

final dioClientProvider = Provider<DioClient>((ref) => DioClient());

final productsRemoteDataSourceProvider = Provider<ProductsRemoteDataSource>((ref) {
  return ProductsRemoteDataSourceImpl(ref.watch(dioClientProvider));
});

final productRepositoryProvider = Provider<ProductRepository>((ref) {
  return ProductRepositoryImpl(ref.watch(productsRemoteDataSourceProvider));
});

final fetchProductsProvider = FutureProvider<List<ProductEntity>>((ref) async {
  final repository = ref.watch(productRepositoryProvider);
  final result = await repository.getProducts();

  if (result.failure != null) {
    throw Exception(result.failure!.message);
  }
  return result.products ?? [];
});
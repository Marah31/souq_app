import 'package:flutter/material.dart';

import '../../../../core/network/api_constants.dart';
import '../../../../core/network/dio_client.dart';
import '../models/product_dto.dart';

abstract class ProductsRemoteDataSource {
  Future<List<ProductDto>> getProducts();
  Future<ProductDto> getProductById(int id);
  Future<List<String>> getCategories();
  Future<List<ProductDto>> getProductsByCategory(String category);
}

class ProductsRemoteDataSourceImpl implements ProductsRemoteDataSource {
  final DioClient _client;

  ProductsRemoteDataSourceImpl(this._client);

  @override
  Future<List<ProductDto>> getProducts() async {
    final response = await _client.get(ApiConstants.products);
    
    // debugPrint('HTTP Status Code: ${response.statusCode}');
    // debugPrint('Raw Data Type: ${response.data.runtimeType}');
    // debugPrint('Raw Data Content: ${response.data}');

    if (response.data == null || response.data is! List) {
      debugPrint('Warning: response.data was null or not a List');
      return [];
    }

    final data = response.data as List<dynamic>;
    return data
        .whereType<Map<String, dynamic>>()
        .map((json) => ProductDto.fromJson(json))
        .toList();
  }
  @override
  Future<ProductDto> getProductById(int id) async {
    final response = await _client.get(ApiConstants.productDetail(id));
    return ProductDto.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<List<String>> getCategories() async {
    final response = await _client.get(ApiConstants.categories);
    final data = response.data as List<dynamic>;
    return data.map((e) => e.toString()).toList();
  }

  @override
  Future<List<ProductDto>> getProductsByCategory(String category) async {
    final response = await _client.get(ApiConstants.categoryProducts(category));
    final data = response.data as List<dynamic>;
    return data.map((json) => ProductDto.fromJson(json as Map<String, dynamic>)).toList();
  }
}
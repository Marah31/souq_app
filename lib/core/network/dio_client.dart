import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:souq_app/core/error/exception.dart';
import 'api_constants.dart';

 class DioClient {
  final Dio _dio;

  DioClient({Dio? dio})
      : _dio = dio ??
            Dio(
              BaseOptions(
                baseUrl: ApiConstants.baseUrl,
                connectTimeout: ApiConstants.connectTimeout,
                receiveTimeout: ApiConstants.receiveTimeout,
                headers: const {'Content-Type': 'application/json'},
              ),
            ) {
    if (kDebugMode) {
      _dio.interceptors.add(
        LogInterceptor(
          requestHeader: false,
          responseHeader: false,
          requestBody: true,
          responseBody: true,
        ),
      );
    }
  }

  Dio get instance => _dio;

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      return await _dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
    } on DioException catch (e) {
      throw _handleDioException(e);
    } catch (e, stackTrace) {
      debugPrint('Unexpected error in GET request: $e\n$stackTrace');
      throw ServerException(message: 'An unexpected error occurred: ${e.toString()}');
    }
  }

  Exception _handleDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        return const NetworkException(message: 'Network connection timed out or failed.');
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        final statusMessage = e.response?.statusMessage;
        return ServerException(
          message: statusMessage ?? 'Server returned an error ($statusCode)',
          statusCode: statusCode,
        );
      case DioExceptionType.cancel:
        return const ServerException(message: 'Request was cancelled.');
      case DioExceptionType.badCertificate:
        return const NetworkException(message: 'Invalid or untrusted security certificate.');
      case DioExceptionType.unknown:
      default:
        return NetworkException(
          message: e.message ?? 'Network error occurred. Please try again.',
        );
    }
  }
}
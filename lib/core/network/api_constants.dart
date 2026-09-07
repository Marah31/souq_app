class ApiConstants {
  static const String baseUrl = 'https://fakestoreapi.com';
  
  static const String products = '/products';
  static const String categories = '/products/categories';
  static String categoryProducts(String category) => '/products/category/$category';
  static String productDetail(int id) => '/products/$id';

  static const Duration connectTimeout = Duration(seconds: 10);
  static const Duration receiveTimeout = Duration(seconds: 10);
}
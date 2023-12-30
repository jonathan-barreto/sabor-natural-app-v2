class ConstantsUrls {
  static const String awsStorageImage =
      'https://sabor-natural-app.s3.sa-east-1.amazonaws.com/images/';

  static const String _baseUrlApi = 'http://192.168.1.5:8000/api';

  static const String fetchProducts = '$_baseUrlApi/products';

  static const String searchProducts = '$fetchProducts/name/';
}

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ApiService {
  static const String _primaryUrl = 'https://wantapi.com/products.php';
  static const String _fallbackUrl = 'https://fakestoreapi.com/products';

  Future<List<Product>> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse(_primaryUrl)).timeout(
        const Duration(seconds: 4),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        if (data.isNotEmpty) {
          return data.map((item) => Product.fromJson(item)).toList();
        }
      }
    } catch (_) {}

    try {
      final response = await http.get(Uri.parse(_fallbackUrl)).timeout(
        const Duration(seconds: 4),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        if (data.isNotEmpty) {
          return data.map((item) => Product.fromJson(item)).toList();
        }
      }
    } catch (_) {}

    return [];
  }
}

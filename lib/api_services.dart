import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'models.dart';

class ApiService {
  static const String baseUrl = 'https://task.itprojects.web.id/api';

  static const storage = FlutterSecureStorage();

  static Future<bool> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),

      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },

      body: jsonEncode({"username": username, "password": password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      String token = data['data']['token'];

      await storage.write(key: 'token', value: token);

      return true;
    }

    return false;
  }

  static Future<String?> getToken() async {
    return await storage.read(key: 'token');
  }

  static Future<List<ProductModel>> getProducts() async {
    String? token = await getToken();

    if (token == null) {
      return [];
    }

    final response = await http.get(
      Uri.parse('$baseUrl/products'),

      headers: {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      List products = data['data']['products'];

      return products.map((e) => ProductModel.fromJson(e)).toList();
    }

    return [];
  }

  static Future<bool> addProduct(ProductModel product) async {
    String? token = await getToken();

    final response = await http.post(
      Uri.parse('$baseUrl/products'),

      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },

      body: jsonEncode(product.toJson()),
    );

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    }

    return false;
  }

  static Future<bool> submitTugas(
    ProductModel product,
    String githubUrl,
  ) async {
    String? token = await getToken();

    final response = await http.post(
      Uri.parse('$baseUrl/products/submit'),

      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },

      body: jsonEncode({
        "name": product.name,
        "price": product.price,
        "description": product.description,
        "github_url": githubUrl,
      }),
    );

    return response.statusCode == 200;
  }
}

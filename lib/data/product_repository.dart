import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/product.dart';
import 'mock_products.dart';

class ProductRepository {
  Future<List<Product>> getProducts({bool simulateError = false}) async {
    // Simule une latence asynchrone réaliste
    await Future.delayed(const Duration(milliseconds: 400));

    if (simulateError) {
      throw Exception('Erreur de connexion au serveur catalogue.');
    }

    try {
      // Chargement depuis le JSON local mocké (conforme exigence "JSON local ou fake API")
      final jsonString = await rootBundle.loadString('assets/products.json');
      final List<dynamic> jsonList = json.decode(jsonString);
      return jsonList.map((item) => Product.fromJson(item as Map<String, dynamic>)).toList();
    } catch (_) {
      // Fallback sécurisé vers la liste en mémoire si le bundle asset n'est pas dispo (ex: tests unitaires purs)
      return List<Product>.unmodifiable(mockProductList);
    }
  }

  Future<Product?> getProductById(String id) async {
    final products = await getProducts();
    try {
      return products.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }
}

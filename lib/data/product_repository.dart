import '../models/product.dart';
import 'mock_products.dart';

class ProductRepository {
  Future<List<Product>> getProducts({bool simulateError = false}) async {
    // Simule une latence réseau réaliste pour observer les états AsyncValue (loading)
    await Future.delayed(const Duration(milliseconds: 600));

    if (simulateError) {
      throw Exception('Erreur de connexion au serveur catalogue.');
    }

    return List<Product>.unmodifiable(mockProductList);
  }

  Future<Product?> getProductById(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    try {
      return mockProductList.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }
}

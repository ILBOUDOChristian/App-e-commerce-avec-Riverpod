import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/product_repository.dart';
import '../models/product.dart';

/// Provider pour injecter le repository de produits
final productRepositoryProvider = Provider<ProductRepository>((ref) {
  return ProductRepository();
});

/// [Provider 1] FutureProvider pour charger la liste des produits avec AsyncValue
final productsFutureProvider = FutureProvider<List<Product>>((ref) async {
  final repository = ref.watch(productRepositoryProvider);
  return await repository.getProducts();
});

/// FutureProviderFamily pour récupérer un produit spécifique par son ID
final productDetailProvider =
    FutureProvider.family<Product?, String>((ref, productId) async {
  final repository = ref.watch(productRepositoryProvider);
  return await repository.getProductById(productId);
});

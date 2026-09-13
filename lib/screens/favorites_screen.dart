import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product.dart';
import '../providers/favorites_provider.dart';
import '../providers/products_provider.dart';
import '../widgets/async_state_view.dart';
import '../widgets/product_card.dart';
import 'product_detail_screen.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoritesSet = ref.watch(favoritesNotifierProvider);
    final productsAsync = ref.watch(productsFutureProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Mes Favoris (${favoritesSet.length})'),
        actions: [
          if (favoritesSet.isNotEmpty)
            IconButton(
              tooltip: 'Vider les favoris',
              icon: const Icon(Icons.delete_sweep_rounded),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Supprimer tous les favoris ?'),
                    content: const Text(
                      'Êtes-vous sûr de vouloir vider votre liste de favoris ?',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Annuler'),
                      ),
                      FilledButton(
                        onPressed: () {
                          ref
                              .read(favoritesNotifierProvider.notifier)
                              .clearAllFavorites();
                          Navigator.pop(context);
                        },
                        child: const Text('Confirmer'),
                      ),
                    ],
                  ),
                );
              },
            ),
        ],
      ),
      body: AsyncStateView<List<Product>>(
        asyncValue: productsAsync,
        emptyMessage: 'Aucun favori pour le moment.',
        onData: (allProducts) {
          final favoriteProducts = allProducts
              .where((p) => favoritesSet.contains(p.id))
              .toList();

          if (favoriteProducts.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.favorite_border_rounded,
                      size: 90,
                      color: Colors.grey.shade400,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Aucun favori enregistré',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Touchez l\'icône cœur sur les produits pour les retrouver ici à tout moment (ils sont sauvegardés automatiquement).',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.68,
              crossAxisSpacing: 14,
              mainAxisSpacing: 14,
            ),
            itemCount: favoriteProducts.length,
            itemBuilder: (context, index) {
              final product = favoriteProducts[index];
              return ProductCard(
                product: product,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ProductDetailScreen(
                        productId: product.id,
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

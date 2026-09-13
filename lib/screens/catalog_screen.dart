import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/mock_products.dart';
import '../models/product.dart';
import '../models/product_filter.dart';
import '../providers/filter_provider.dart';
import '../providers/filtered_products_provider.dart';
import '../providers/products_provider.dart';
import '../widgets/async_state_view.dart';
import '../widgets/product_card.dart';
import 'product_detail_screen.dart';

class CatalogScreen extends ConsumerWidget {
  const CatalogScreen({super.key});

  void _showSortModal(BuildContext context, WidgetRef ref) {
    final currentSort = ref.read(productFilterProvider).sortOption;

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Text(
                    'Trier par',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.star_outline_rounded),
                  title: const Text('Recommandés'),
                  trailing: currentSort == ProductSortOption.featured
                      ? const Icon(Icons.check, color: Colors.blue)
                      : null,
                  onTap: () {
                    ref
                        .read(productFilterProvider.notifier)
                        .setSortOption(ProductSortOption.featured);
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.arrow_upward_rounded),
                  title: const Text('Prix : croissant'),
                  trailing: currentSort == ProductSortOption.priceAscending
                      ? const Icon(Icons.check, color: Colors.blue)
                      : null,
                  onTap: () {
                    ref
                        .read(productFilterProvider.notifier)
                        .setSortOption(ProductSortOption.priceAscending);
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.arrow_downward_rounded),
                  title: const Text('Prix : décroissant'),
                  trailing: currentSort == ProductSortOption.priceDescending
                      ? const Icon(Icons.check, color: Colors.blue)
                      : null,
                  onTap: () {
                    ref
                        .read(productFilterProvider.notifier)
                        .setSortOption(ProductSortOption.priceDescending);
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.recommend_rounded),
                  title: const Text('Meilleures notes'),
                  trailing: currentSort == ProductSortOption.highestRated
                      ? const Icon(Icons.check, color: Colors.blue)
                      : null,
                  onTap: () {
                    ref
                        .read(productFilterProvider.notifier)
                        .setSortOption(ProductSortOption.highestRated);
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.sort_by_alpha_rounded),
                  title: const Text('Nom alphabétique'),
                  trailing: currentSort == ProductSortOption.nameAlphabetical
                      ? const Icon(Icons.check, color: Colors.blue)
                      : null,
                  onTap: () {
                    ref
                        .read(productFilterProvider.notifier)
                        .setSortOption(ProductSortOption.nameAlphabetical);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filteredAsync = ref.watch(filteredProductsProvider);
    final filter = ref.watch(productFilterProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ShopPulse',
          style: TextStyle(fontWeight: FontWeight.w800, letterSpacing: -0.5),
        ),
        actions: [
          IconButton(
            tooltip: 'Trier les produits',
            icon: const Icon(Icons.tune_rounded),
            onPressed: () => _showSortModal(context, ref),
          ),
        ],
      ),
      body: Column(
        children: [
          // Barre de recherche
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: SearchBar(
              hintText: 'Rechercher un produit, marque...',
              leading: const Icon(Icons.search_rounded),
              trailing: filter.searchQuery.isNotEmpty
                  ? [
                      IconButton(
                        icon: const Icon(Icons.clear_rounded),
                        onPressed: () {
                          ref
                              .read(productFilterProvider.notifier)
                              .setSearchQuery('');
                        },
                      ),
                    ]
                  : null,
              onChanged: (value) {
                ref.read(productFilterProvider.notifier).setSearchQuery(value);
              },
              elevation: const WidgetStatePropertyAll(1),
            ),
          ),
          // Chips des catégories
          SizedBox(
            height: 48,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: mockCategories.length,
              separatorBuilder: (context, index) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final category = mockCategories[index];
                final isSelected = filter.selectedCategory == category;

                return ChoiceChip(
                  label: Text(category),
                  selected: isSelected,
                  onSelected: (selected) {
                    if (selected) {
                      ref
                          .read(productFilterProvider.notifier)
                          .setCategory(category);
                    }
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          // Grille des produits avec AsyncStateView
          Expanded(
            child: AsyncStateView<List<Product>>(
              asyncValue: filteredAsync,
              emptyMessage:
                  'Aucun produit ne correspond à votre recherche ou catégorie.',
              onRetry: () {
                ref.invalidate(productsFutureProvider);
              },
              onData: (products) {
                return RefreshIndicator(
                  onRefresh: () async {
                    ref.invalidate(productsFutureProvider);
                  },
                  child: GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.68,
                      crossAxisSpacing: 14,
                      mainAxisSpacing: 14,
                    ),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
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
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

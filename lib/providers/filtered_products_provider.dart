import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product.dart';
import '../models/product_filter.dart';
import 'filter_provider.dart';
import 'products_provider.dart';

/// [Provider 3] Provider combiné qui filtre et trie la liste des produits
final filteredProductsProvider = Provider<AsyncValue<List<Product>>>((ref) {
  final productsAsync = ref.watch(productsFutureProvider);
  final filter = ref.watch(productFilterProvider);

  return productsAsync.whenData((products) {
    var list = products.where((product) {
      // Filtre catégorie
      final matchesCategory = filter.selectedCategory == 'Tous' ||
          product.category.toLowerCase() == filter.selectedCategory.toLowerCase();

      // Filtre recherche textuelle (titre ou description)
      final query = filter.searchQuery.trim().toLowerCase();
      final matchesSearch = query.isEmpty ||
          product.title.toLowerCase().contains(query) ||
          product.description.toLowerCase().contains(query);

      return matchesCategory && matchesSearch;
    }).toList();

    // Application du tri
    switch (filter.sortOption) {
      case ProductSortOption.priceAscending:
        list.sort((a, b) => a.price.compareTo(b.price));
        break;
      case ProductSortOption.priceDescending:
        list.sort((a, b) => b.price.compareTo(a.price));
        break;
      case ProductSortOption.highestRated:
        list.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      case ProductSortOption.nameAlphabetical:
        list.sort((a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()));
        break;
      case ProductSortOption.featured:
        break;
    }

    return list;
  });
});

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product_filter.dart';

class ProductFilterNotifier extends StateNotifier<ProductFilter> {
  ProductFilterNotifier() : super(const ProductFilter());

  void setSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
  }

  void setCategory(String category) {
    state = state.copyWith(selectedCategory: category);
  }

  void setSortOption(ProductSortOption sortOption) {
    state = state.copyWith(sortOption: sortOption);
  }

  void resetFilters() {
    state = const ProductFilter();
  }
}

/// [Provider 2] StateNotifierProvider pour la gestion des filtres et du tri
final productFilterProvider =
    StateNotifierProvider<ProductFilterNotifier, ProductFilter>((ref) {
  return ProductFilterNotifier();
});

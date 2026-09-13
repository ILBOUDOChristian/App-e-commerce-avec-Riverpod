import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _favoritesStorageKey = 'user_favorite_product_ids';

class FavoritesNotifier extends StateNotifier<Set<String>> {
  FavoritesNotifier() : super(<String>{}) {
    _loadFavoritesFromDisk();
  }

  Future<void> _loadFavoritesFromDisk() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final list = prefs.getStringList(_favoritesStorageKey) ?? [];
      state = list.toSet();
    } catch (_) {
      // Si la persistance échoue au premier lancement, on conserve l'état mémoire
    }
  }

  Future<void> _saveFavoritesToDisk(Set<String> favorites) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(_favoritesStorageKey, favorites.toList());
    } catch (_) {}
  }

  void toggleFavorite(String productId) {
    final updated = Set<String>.from(state);
    if (updated.contains(productId)) {
      updated.remove(productId);
    } else {
      updated.add(productId);
    }
    state = updated;
    _saveFavoritesToDisk(updated);
  }

  bool isFavorite(String productId) {
    return state.contains(productId);
  }

  void clearAllFavorites() {
    state = <String>{};
    _saveFavoritesToDisk(state);
  }
}

/// [Provider 5] StateNotifierProvider pour les favoris avec persistance SharedPreferences
final favoritesNotifierProvider =
    StateNotifierProvider<FavoritesNotifier, Set<String>>((ref) {
  return FavoritesNotifier();
});

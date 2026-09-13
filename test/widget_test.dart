import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ecommerce/models/product.dart';
import 'package:ecommerce/providers/cart_provider.dart';
import 'package:ecommerce/providers/favorites_provider.dart';
import 'package:ecommerce/providers/filter_provider.dart';
import 'package:ecommerce/models/product_filter.dart';
import 'package:ecommerce/providers/filtered_products_provider.dart';

void main() {
  group('CartNotifier tests', () {
    const testProduct = Product(
      id: 'prod_test',
      title: 'Casque Test Pro',
      description: 'Audio premium pour test unitaire',
      price: 50.0,
      category: 'High-Tech',
      imageUrl: 'https://example.com/test.jpg',
      rating: 4.8,
      reviewCount: 120,
    );

    test('Etat initial du panier vide', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final cartState = container.read(cartNotifierProvider);
      expect(cartState.isEmpty, isTrue);
      expect(cartState.totalItemCount, 0);
      expect(cartState.grandTotal, 0.0);
    });

    test('Ajout d un produit au panier et calcul du total avec livraison', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(cartNotifierProvider.notifier);
      notifier.addToCart(testProduct, quantity: 2);

      final cartState = container.read(cartNotifierProvider);
      expect(cartState.isEmpty, isFalse);
      expect(cartState.totalItemCount, 2);
      expect(cartState.subtotal, 100.0);
      expect(cartState.deliveryCost, 4.99);
      expect(cartState.grandTotal, 104.99);
    });

    test('Modification de la quantite et suppression du panier', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(cartNotifierProvider.notifier);
      notifier.addToCart(testProduct, quantity: 1);
      notifier.updateQuantity(testProduct.id, 5);

      var cartState = container.read(cartNotifierProvider);
      expect(cartState.totalItemCount, 5);

      notifier.removeFromCart(testProduct.id);
      cartState = container.read(cartNotifierProvider);
      expect(cartState.isEmpty, isTrue);
    });
  });

  group('ProductFilterNotifier & FilteredProducts tests', () {
    test('Mise a jour de la categorie, recherche et tri', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(productFilterProvider.notifier);
      notifier.setCategory('Mode');
      notifier.setSearchQuery('sneakers');
      notifier.setSortOption(ProductSortOption.priceAscending);

      final filter = container.read(productFilterProvider);
      expect(filter.selectedCategory, 'Mode');
      expect(filter.searchQuery, 'sneakers');
      expect(filter.sortOption, ProductSortOption.priceAscending);
    });

    test('Provider filteredProductsProvider est instanciable', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final asyncValue = container.read(filteredProductsProvider);
      expect(asyncValue, isNotNull);
    });
  });

  group('FavoritesNotifier tests', () {
    test('Toggle favorite ajoute et retire l id', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(favoritesNotifierProvider.notifier);
      expect(notifier.isFavorite('prod_1'), isFalse);

      notifier.toggleFavorite('prod_1');
      expect(notifier.isFavorite('prod_1'), isTrue);

      notifier.toggleFavorite('prod_1');
      expect(notifier.isFavorite('prod_1'), isFalse);
    });
  });
}

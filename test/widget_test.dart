import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ecommerce/models/product.dart';
import 'package:ecommerce/providers/cart_provider.dart';
import 'package:ecommerce/providers/filter_provider.dart';
import 'package:ecommerce/models/product_filter.dart';

void main() {
  group('CartNotifier tests', () {
    const testProduct = Product(
      id: 'p1',
      title: 'Produit Test',
      description: 'Description test',
      price: 25.0,
      category: 'High-Tech',
      imageUrl: 'https://example.com/test.jpg',
      rating: 4.5,
      reviewCount: 10,
    );

    test('Initial cart state is empty', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final cartState = container.read(cartNotifierProvider);
      expect(cartState.isEmpty, isTrue);
      expect(cartState.totalItemCount, 0);
      expect(cartState.grandTotal, 0.0);
    });

    test('Add item to cart increments item count and computes total', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(cartNotifierProvider.notifier);
      notifier.addToCart(testProduct, quantity: 2);

      final cartState = container.read(cartNotifierProvider);
      expect(cartState.isEmpty, isFalse);
      expect(cartState.totalItemCount, 2);
      expect(cartState.subtotal, 50.0);
      // Frais de port appliqués si <= 100€
      expect(cartState.grandTotal, 50.0 + 4.99);
    });

    test('Update quantity and remove from cart', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(cartNotifierProvider.notifier);
      notifier.addToCart(testProduct, quantity: 1);
      notifier.updateQuantity(testProduct.id, 4);

      var cartState = container.read(cartNotifierProvider);
      expect(cartState.totalItemCount, 4);

      notifier.removeFromCart(testProduct.id);
      cartState = container.read(cartNotifierProvider);
      expect(cartState.isEmpty, isTrue);
    });
  });

  group('ProductFilterNotifier tests', () {
    test('Filter updates category and search query', () {
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
  });
}

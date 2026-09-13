import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/cart_provider.dart';
import '../widgets/cart_item_tile.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartState = ref.watch(cartNotifierProvider);
    final theme = Theme.of(context);

    if (cartState.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Mon Panier'),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.shopping_cart_outlined,
                  size: 90,
                  color: Colors.grey.shade400,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Votre panier est vide',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Explorez nos collections et trouvez vos coups de cœur !',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Mon Panier (${cartState.totalItemCount})'),
        actions: [
          IconButton(
            tooltip: 'Vider le panier',
            icon: const Icon(Icons.delete_sweep_rounded),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Vider le panier ?'),
                  content: const Text(
                    'Voulez-vous vraiment retirer tous les articles du panier ?',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Annuler'),
                    ),
                    FilledButton(
                      onPressed: () {
                        ref.read(cartNotifierProvider.notifier).clearCart();
                        Navigator.pop(context);
                      },
                      child: const Text('Vider'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: cartState.items.length,
        itemBuilder: (context, index) {
          final cartItem = cartState.items[index];
          return CartItemTile(
            item: cartItem,
            onQuantityChanged: (newQty) {
              ref
                  .read(cartNotifierProvider.notifier)
                  .updateQuantity(cartItem.product.id, newQty);
            },
            onRemove: () {
              ref
                  .read(cartNotifierProvider.notifier)
                  .removeFromCart(cartItem.product.id);
            },
          );
        },
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: theme.scaffoldBackgroundColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.06),
                blurRadius: 10,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Sous-total',
                    style: TextStyle(color: Colors.grey.shade700),
                  ),
                  Text(
                    '${cartState.subtotal.toStringAsFixed(2)} €',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Frais de livraison',
                    style: TextStyle(color: Colors.grey.shade700),
                  ),
                  Text(
                    cartState.deliveryCost == 0
                        ? 'Offerte'
                        : '${cartState.deliveryCost.toStringAsFixed(2)} €',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: cartState.deliveryCost == 0
                          ? Colors.green
                          : Colors.grey.shade900,
                    ),
                  ),
                ],
              ),
              const Divider(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total TTC',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${cartState.grandTotal.toStringAsFixed(2)} €',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Commande confirmée ! 🎉'),
                        content: Text(
                          'Merci pour votre achat d\'un montant de ${cartState.grandTotal.toStringAsFixed(2)} €.\nVotre colis sera expédié sous 24h.',
                        ),
                        actions: [
                          FilledButton(
                            onPressed: () {
                              ref.read(cartNotifierProvider.notifier).clearCart();
                              Navigator.pop(context);
                            },
                            child: const Text('Super !'),
                          ),
                        ],
                      ),
                    );
                  },
                  icon: const Icon(Icons.check_circle_outline_rounded),
                  label: const Text(
                    'Passer la commande',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

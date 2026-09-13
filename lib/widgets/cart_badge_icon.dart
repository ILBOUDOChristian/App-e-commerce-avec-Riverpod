import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/cart_provider.dart';

class CartBadgeIcon extends ConsumerWidget {
  final VoidCallback onTap;

  const CartBadgeIcon({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final totalCount = ref.watch(
      cartNotifierProvider.select((state) => state.totalItemCount),
    );

    return IconButton(
      tooltip: 'Mon panier ($totalCount)',
      onPressed: onTap,
      icon: Badge(
        isLabelVisible: totalCount > 0,
        backgroundColor: Theme.of(context).colorScheme.error,
        label: AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          transitionBuilder: (child, animation) => ScaleTransition(
            scale: animation,
            child: child,
          ),
          child: Text(
            '$totalCount',
            key: ValueKey<int>(totalCount),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 11,
              color: Colors.white,
            ),
          ),
        ),
        child: const Icon(Icons.shopping_bag_outlined),
      ),
    );
  }
}

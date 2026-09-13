import 'package:flutter/material.dart';

class AnimatedAddToCartButton extends StatefulWidget {
  final VoidCallback onAddToCart;
  final String label;
  final bool isCompact;

  const AnimatedAddToCartButton({
    super.key,
    required this.onAddToCart,
    this.label = 'Ajouter au panier',
    this.isCompact = false,
  });

  @override
  State<AnimatedAddToCartButton> createState() =>
      _AnimatedAddToCartButtonState();
}

class _AnimatedAddToCartButtonState extends State<AnimatedAddToCartButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isSuccess = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
      lowerBound: 0.90,
      upperBound: 1.0,
      value: 1.0,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _triggerAnimation() async {
    await _controller.reverse();
    await _controller.forward();
    widget.onAddToCart();

    if (mounted) {
      setState(() {
        _isSuccess = true;
      });
      await Future.delayed(const Duration(milliseconds: 800));
      if (mounted) {
        setState(() {
          _isSuccess = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (widget.isCompact) {
      return ScaleTransition(
        scale: _controller,
        child: IconButton.filled(
          style: IconButton.styleFrom(
            backgroundColor: _isSuccess ? Colors.green : theme.colorScheme.primary,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: _triggerAnimation,
          icon: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: Icon(
              _isSuccess ? Icons.check_rounded : Icons.add_shopping_cart_rounded,
              key: ValueKey<bool>(_isSuccess),
              size: 20,
            ),
          ),
        ),
      );
    }

    return ScaleTransition(
      scale: _controller,
      child: FilledButton.icon(
        style: FilledButton.styleFrom(
          backgroundColor: _isSuccess ? Colors.green : theme.colorScheme.primary,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        onPressed: _triggerAnimation,
        icon: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: Icon(
            _isSuccess ? Icons.check_circle_rounded : Icons.shopping_bag_outlined,
            key: ValueKey<bool>(_isSuccess),
          ),
        ),
        label: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: Text(
            _isSuccess ? 'Ajouté !' : widget.label,
            key: ValueKey<bool>(_isSuccess),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

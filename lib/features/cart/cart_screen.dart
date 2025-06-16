import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/contants/app_color.dart';
import '../widgets/cart_item_card.dart';
import '../widgets/checkout_card.dart';
import 'cart_view_model.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartViewModel = Provider.of<CartViewModel>(context);
    print('Cart items count: ${cartViewModel.cartItems.length}'); // Debug print

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
        actions: [
          if (cartViewModel.cartItems.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: () => _showClearCartDialog(context),
            ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: cartViewModel.cartItems.isEmpty
                ? _buildEmptyCart(context)
                : _buildCartItems(cartViewModel),
          ),
          if (cartViewModel.cartItems.isNotEmpty)
            CheckoutCard(
              subtotal: cartViewModel.subtotal,
              tax: cartViewModel.tax,
              deliveryFee: cartViewModel.deliveryFee,
              total: cartViewModel.total,
              onCheckoutPressed: () {
                Navigator.pushNamed(context, '/checkout');
              },
            ),
        ],
      ),
    );
  }

  Widget _buildEmptyCart(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.shopping_cart_outlined,
            size: 64,
            color: AppColors.grey,
          ),
          const SizedBox(height: 16),
          const Text(
            'Your cart is empty',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Browse products and add items to your cart',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            ),
            onPressed: () {
              Navigator.pop(context); // Go back to previous screen
            },
            child: const Text(
              'Continue Shopping',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartItems(CartViewModel cartViewModel) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: cartViewModel.cartItems.length,
      itemBuilder: (context, index) {
        final item = cartViewModel.cartItems[index];
        return CartItemCard(
          item: item,
          onQuantityChanged: (newQuantity) {
            cartViewModel.updateQuantity(item.id, newQuantity);
          },
          onRemove: () {
            cartViewModel.removeFromCart(item.id);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Removed ${item.name} from cart'),
                duration: const Duration(seconds: 2),
              ),
            );
          },
        );
      },
    );
  }

  void _showClearCartDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Clear Cart'),
          content: const Text('Are you sure you want to remove all items from your cart?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Provider.of<CartViewModel>(context, listen: false).clearCart();
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Cart cleared'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              child: const Text(
                'Clear',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}
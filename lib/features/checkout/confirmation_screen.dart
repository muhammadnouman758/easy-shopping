import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../cart/cart_view_model.dart';

import '../widgets/thank_you_card.dart';
import '../widgets/tracking_card.dart';
import 'checkout_order.dart';


class ConfirmationScreen extends StatelessWidget {
  final Order order;

  const ConfirmationScreen({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(symbol: '\$');
    final dateFormat = DateFormat('MMMM dd, yyyy');
    final timeFormat = DateFormat('hh:mm a');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Confirmation'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ThankYouCard(order: order),
            const SizedBox(height: 24),
            TrackingCard(order: order),
            const SizedBox(height: 24),
            // OrderSummaryCard(order: order),
            const SizedBox(height: 32),
            _buildActionButtons(context),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              // Navigate to order details
              Navigator.pushNamed(
                context,
                '/order-details',
                arguments: order.id,
              );
            },
            child: const Text('View Order Details'),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () {
              // Clear cart and go home
              Provider.of<CartViewModel>(context, listen: false).clearCart();
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/home',
                    (route) => false,
              );
            },
            child: const Text('Continue Shopping'),
          ),
        ),
      ],
    );
  }
}
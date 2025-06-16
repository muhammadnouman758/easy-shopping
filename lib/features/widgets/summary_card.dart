import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../cart/cart_item_model.dart';
import '../checkout/checkout_order.dart';

class SummaryCard extends StatelessWidget {
  final List<CartItem> items;
  final double subtotal;
  final double tax;
  final double deliveryFee;
  final double total;
  final ShippingAddress? shippingAddress;

  const SummaryCard({
    Key? key,
    required this.items,
    required this.subtotal,
    required this.tax,
    required this.deliveryFee,
    required this.total,
    this.shippingAddress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(symbol: '\$');

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Order Summary',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            if (shippingAddress != null) ...[
              _buildInfoRow('Shipping to:', _formatAddress(shippingAddress!)),
              const Divider(),
            ],
            Column(
              children: items.map((item) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${item.name} (x${item.quantity})',
                        style: const TextStyle(fontSize: 14),
                      ),
                      Text(
                        currencyFormat.format(item.totalPrice),
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            const Divider(),
            _buildPriceRow('Subtotal', subtotal, currencyFormat),
            _buildPriceRow('Tax', tax, currencyFormat),
            _buildPriceRow('Delivery', deliveryFee, currencyFormat),
            const Divider(),
            _buildPriceRow(
              'Total',
              total,
              currencyFormat,
              isBold: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRow(
      String label,
      double amount,
      NumberFormat format, {
        bool isBold = false,
      }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            format.format(amount),
            style: TextStyle(
              fontSize: 16,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  String _formatAddress(ShippingAddress address) {
    return '${address.fullName}\n${address.addressLine1}${address.addressLine2 != null ? '\n${address.addressLine2}' : ''}\n${address.city}, ${address.state} ${address.postalCode}\n${address.country}';
  }
}
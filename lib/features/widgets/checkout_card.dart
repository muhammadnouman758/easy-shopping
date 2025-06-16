import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
class CheckoutCard extends StatelessWidget {
  final double subtotal;
  final double tax;
  final double deliveryFee;
  final double total;
  final VoidCallback onCheckoutPressed;

  const CheckoutCard({
    Key? key,
    required this.subtotal,
    required this.tax,
    required this.deliveryFee,
    required this.total,
    required this.onCheckoutPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currencyFormat = intl.NumberFormat.currency(symbol: '\$');

    return Card(
      margin: const EdgeInsets.all(0),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildPriceRow('Subtotal', subtotal, currencyFormat),
            _buildPriceRow('Tax', tax, currencyFormat),
            _buildPriceRow('Delivery', deliveryFee, currencyFormat),
            const Divider(height: 24),
            _buildPriceRow(
              'Total',
              total,
              currencyFormat,
              isBold: true,
              isLarge: true,
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  // backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: onCheckoutPressed,
                child: const Text(
                  'Checkout',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceRow(
      String label,
      double amount,
      intl.NumberFormat format, {
        bool isBold = false,
        bool isLarge = false,
      }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isLarge ? 18 : 16,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            format.format(amount),
            style: TextStyle(
              fontSize: isLarge ? 18 : 16,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
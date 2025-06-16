import 'package:flutter/material.dart';

import '../checkout/checkout_order.dart';


class TrackingCard extends StatelessWidget {
  final Order order;

  const TrackingCard({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Tracking Information',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildTrackingStep(
              icon: Icons.receipt,
              title: 'Order Placed',
              subtitle: 'Your order has been received',
              isActive: true,
            ),
            _buildDivider(),
            _buildTrackingStep(
              icon: Icons.local_shipping,
              title: 'Processing',
              subtitle: 'We\'re preparing your order',
              isActive: order.status != 'Placed',
            ),
            _buildDivider(),
            _buildTrackingStep(
              icon: Icons.airport_shuttle,
              title: 'Shipped',
              subtitle: 'Your order is on the way',
              isActive: order.status == 'Shipped' || order.status == 'Delivered',
            ),
            _buildDivider(),
            _buildTrackingStep(
              icon: Icons.check_circle,
              title: 'Delivered',
              subtitle: 'Your order has arrived',
              isActive: order.status == 'Delivered',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrackingStep({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool isActive,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          color: isActive ? Colors.green : Colors.grey,
          size: 32,
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isActive ? Colors.black : Colors.grey,
              ),
            ),
            Text(
              subtitle,
              style: TextStyle(
                color: isActive ? Colors.grey : Colors.grey[300],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Divider(height: 1, color: Colors.grey[200]),
    );
  }
}
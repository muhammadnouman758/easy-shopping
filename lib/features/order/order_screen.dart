import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/order_card.dart';
import 'order_detail_screen.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<OrdersViewModel>(context, listen: false).loadOrders();
    });
  }

  @override
  Widget build(BuildContext context) {
    final ordersViewModel = Provider.of<OrdersViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders'),
      ),
      body: ordersViewModel.orders.isEmpty
          ? _buildEmptyState()
          : _buildOrdersList(ordersViewModel),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.receipt_long,
            size: 64,
            color: Colors.grey,
          ),
          const SizedBox(height: 16),
          const Text(
            'No Orders Yet',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Your orders will appear here',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            ),
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/home',
                    (route) => false,
              );
            },
            child: const Text(
              'Start Shopping',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrdersList(OrdersViewModel ordersViewModel) {
    return RefreshIndicator(
      onRefresh: () async {
        await ordersViewModel.loadOrders();
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: ordersViewModel.orders.length,
        itemBuilder: (context, index) {
          final order = ordersViewModel.orders[index];
          return OrderCard(
            order: order,
            onTap: () {
              Navigator.pushNamed(
                context,
                '/order-details',
                arguments: order.id,
              );
            },
          );
        },
      ),
    );
  }
}
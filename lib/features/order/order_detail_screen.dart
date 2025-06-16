import 'package:flutter/material.dart';

import '../cart/cart_item_model.dart';
import '../checkout/checkout_order.dart';


class OrdersViewModel with ChangeNotifier {
  final List<Order> _orders = [];

  List<Order> get orders => _orders;

  Future<void> loadOrders() async {
    // Simulate loading from API
    await Future.delayed(const Duration(seconds: 1));

    // // Demo orders
    // _orders.addAll([
    //   Order(
    //     id: '1001',
    //     date: DateTime.now().subtract(const Duration(days: 2)),
    //     totalAmount: 245.98,
    //     status: 'Delivered',
    //     items: [
    //       CartItem(
    //         id: '1',
    //         productId: '101',
    //         name: 'Wireless Headphones',
    //         imageUrl: 'assets/images/headphones.jpg',
    //         price: 199.99,
    //         selectedColor: 'Black',
    //         selectedSize: 'One Size',
    //         quantity: 1,
    //       ),
    //     ], orderNumber: '',
    //   ),
    //   Order(
    //     id: '1002',
    //     date: DateTime.now().subtract(const Duration(days: 5)),
    //     totalAmount: 89.99,
    //     status: 'Shipped',
    //     items: [
    //       CartItem(
    //         id: '2',
    //         productId: '103',
    //         name: 'Running Shoes',
    //         imageUrl: 'assets/images/shoes.jpg',
    //         price: 89.99,
    //         selectedColor: 'Blue',
    //         selectedSize: 'M',
    //         quantity: 1,
    //       ),
    //     ],
    //   ),
    //   Order(
    //     id: '1003',
    //     date: DateTime.now().subtract(const Duration(days: 10)),
    //     totalAmount: 159.99,
    //     status: 'Completed',
    //     items: [
    //       CartItem(
    //         id: '3',
    //         productId: '102',
    //         name: 'Smart Watch',
    //         imageUrl: 'assets/images/smartwatch.jpg',
    //         price: 159.99,
    //         selectedColor: 'Black',
    //         selectedSize: 'One Size',
    //         quantity: 1,
    //       ),
    //     ],
    //   ),
    // ]);

    notifyListeners();
  }

  Order? getOrderById(String orderId) {
    try {
      return _orders.firstWhere((order) => order.id == orderId);
    } catch (e) {
      return null;
    }
  }
}
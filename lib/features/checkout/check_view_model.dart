import 'package:flutter/material.dart';

import '../cart/cart_item_model.dart';
import 'checkout_order.dart';



class CheckoutViewModel with ChangeNotifier {
  ShippingAddress? _shippingAddress;
  PaymentMethod _selectedPaymentMethod = PaymentMethod.creditCard;
  PaymentCard? _paymentCard;
  bool _isProcessing = false;

  ShippingAddress? get shippingAddress => _shippingAddress;
  PaymentMethod get selectedPaymentMethod => _selectedPaymentMethod;
  PaymentCard? get paymentCard => _paymentCard;
  bool get isProcessing => _isProcessing;

  void updateShippingAddress(ShippingAddress address) {
    _shippingAddress = address;
    notifyListeners();
  }

  void selectPaymentMethod(PaymentMethod method) {
    _selectedPaymentMethod = method;
    notifyListeners();
  }

  void updatePaymentCard(PaymentCard card) {
    _paymentCard = card;
    notifyListeners();
  }

  Future<Order> placeOrder(List<CartItem> items, double total) async {
    if (_shippingAddress == null) {
      throw Exception('Shipping address is required');
    }

    if (_selectedPaymentMethod == PaymentMethod.creditCard && _paymentCard == null) {
      throw Exception('Payment card details are required');
    }

    _isProcessing = true;
    notifyListeners();

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    _isProcessing = false;
    notifyListeners();


    return Order(id: '12', orderNumber: 'show', date: DateTime.now() , subtotal: 120 , shippingCost: 10.0,  tax: 5.0, totalAmount: 130, status: OrderStatus.shipped, items: items, shippingAddress: ShippingAddress(fullName: 'Muhammad Nouman', phoneNumber: '+92872837853', addressLine1: 'street 1', city: 'city 2', state: 'arrived', postalCode:' 32121', country: 'pak'), paymentMethod: PaymentMethod.creditCard);
    //   Order(
    //     id: DateTime.now().millisecondsSinceEpoch.toString(),
    //     date: DateTime.now(),
    //     totalAmount: total,
    //     status: 'Processing',
    //     items: items, orderNumber: '',
    // );
  }
}
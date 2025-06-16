// import '../cart/cart_item_model.dart';
// import '../checkout/checkout_order.dart';
//
//
// class Order {
//   final String id;
//   final String orderNumber; // More user-friendly than just ID
//   final DateTime date;
//   final double subtotal;
//   final double shippingCost;
//   final double tax;
//   final double totalAmount;
//   final String status; // Consider using enum for status
//   final List<CartItem> items;
//   final ShippingAddress shippingAddress;
//   final PaymentMethod paymentMethod;
//   final String? paymentId; // For payment processor reference
//   final String? trackingNumber;
//   final DateTime? estimatedDelivery;
//   final String? notes;
//
//   Order({
//     required this.id,
//     required this.orderNumber,
//     required this.date,
//     required this.subtotal,
//     required this.shippingCost,
//     required this.tax,
//     required this.totalAmount,
//     required this.status,
//     required this.items,
//     required this.shippingAddress,
//     required this.paymentMethod,
//     this.paymentId,
//     this.trackingNumber,
//     this.estimatedDelivery,
//     this.notes,
//   });
//
//   // Helper method to create a map for Firestore/database
//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'orderNumber': orderNumber,
//       'date': date.toIso8601String(),
//       'subtotal': subtotal,
//       'shippingCost': shippingCost,
//       'tax': tax,
//       'totalAmount': totalAmount,
//       'status': status,
//       'items': items.map((item) => item.toMap()).toList(),
//       'shippingAddress': shippingAddress.toMap(),
//       'paymentMethod': paymentMethod.toString(),
//       'paymentId': paymentId,
//       'trackingNumber': trackingNumber,
//       'estimatedDelivery': estimatedDelivery?.toIso8601String(),
//       'notes': notes,
//     };
//   }
//
//   // Factory method to create Order from map (e.g., from Firestore)
//   factory Order.fromMap(Map<String, dynamic> map) {
//     return Order(
//       id: map['id'],
//       orderNumber: map['orderNumber'],
//       date: DateTime.parse(map['date']),
//       subtotal: map['subtotal'],
//       shippingCost: map['shippingCost'],
//       tax: map['tax'],
//       totalAmount: map['totalAmount'],
//       status: map['status'],
//       items: List<CartItem>.from(
//           map['items']?.map((x) => CartItem.fromMap(x)) ?? []),
//       shippingAddress: ShippingAddress.fromMap(map['shippingAddress']),
//       paymentMethod: _parsePaymentMethod(map['paymentMethod']),
//       paymentId: map['paymentId'],
//       trackingNumber: map['trackingNumber'],
//       estimatedDelivery: map['estimatedDelivery'] != null
//           ? DateTime.parse(map['estimatedDelivery'])
//           : null,
//       notes: map['notes'],
//     );
//   }
//
//   static PaymentMethod _parsePaymentMethod(String method) {
//     switch (method) {
//       case 'PaymentMethod.creditCard':
//         return PaymentMethod.creditCard;
//       case 'PaymentMethod.paypal':
//         return PaymentMethod.paypal;
//       case 'PaymentMethod.applePay':
//         return PaymentMethod.applePay;
//       case 'PaymentMethod.googlePay':
//         return PaymentMethod.googlePay;
//       default:
//         return PaymentMethod.creditCard;
//     }
//   }
// }
//
// // Enhanced ShippingAddress model
// class ShippingAddress {
//   final String fullName;
//   final String phoneNumber;
//   final String addressLine1;
//   final String? addressLine2;
//   final String city;
//   final String state;
//   final String postalCode;
//   final String country;
//   final bool isDefault;
//
//   ShippingAddress({
//     required this.fullName,
//     required this.phoneNumber,
//     required this.addressLine1,
//     this.addressLine2,
//     required this.city,
//     required this.state,
//     required this.postalCode,
//     required this.country,
//     this.isDefault = false,
//   });
//
//   Map<String, dynamic> toMap() {
//     return {
//       'fullName': fullName,
//       'phoneNumber': phoneNumber,
//       'addressLine1': addressLine1,
//       'addressLine2': addressLine2,
//       'city': city,
//       'state': state,
//       'postalCode': postalCode,
//       'country': country,
//       'isDefault': isDefault,
//     };
//   }
//
//   factory ShippingAddress.fromMap(Map<String, dynamic> map) {
//     return ShippingAddress(
//       fullName: map['fullName'],
//       phoneNumber: map['phoneNumber'],
//       addressLine1: map['addressLine1'],
//       addressLine2: map['addressLine2'],
//       city: map['city'],
//       state: map['state'],
//       postalCode: map['postalCode'],
//       country: map['country'],
//       isDefault: map['isDefault'] ?? false,
//     );
//   }
//
//   String get formattedAddress {
//     return [
//       addressLine1,
//       if (addressLine2 != null) addressLine2,
//       '$city, $state $postalCode',
//       country
//     ].where((part) => part != null).join('\n');
//   }
// }
//
// // Order status enum for better type safety
// enum OrderStatus {
//   pending('Pending'),
//   processing('Processing'),
//   shipped('Shipped'),
//   delivered('Delivered'),
//   cancelled('Cancelled'),
//   refunded('Refunded');
//
//   final String displayName;
//   const OrderStatus(this.displayName);
// }
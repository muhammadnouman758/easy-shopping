import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tera/core/contants/app_color.dart';
import 'package:tera/features/cart/cart_view_model.dart';

import '../widgets/address_form.dart';
import '../widgets/payment_method_card.dart';
import '../widgets/summary_card.dart';
import 'check_view_model.dart';
import 'checkout_order.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _pageController = PageController();
  int _currentStep = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cartViewModel = Provider.of<CartViewModel>(context);
    final checkoutViewModel = Provider.of<CheckoutViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: Column(
        children: [
          _buildStepper(),
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildShippingPage(checkoutViewModel),
                _buildPaymentPage(checkoutViewModel),
                _buildReviewPage(cartViewModel, checkoutViewModel),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomBar(cartViewModel, checkoutViewModel),
    );
  }

  Widget _buildStepper() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildStep(1, 'Shipping', _currentStep >= 0),
          _buildStep(2, 'Payment', _currentStep >= 1),
          _buildStep(3, 'Review', _currentStep >= 2),
        ],
      ),
    );
  }

  Widget _buildStep(int number, String title, bool isActive) {
    return Column(
      children: [
        CircleAvatar(
          radius: 16,
          backgroundColor: isActive ? AppColors.primary : Colors.grey,
          child: Text(
            number.toString(),
            style: const TextStyle(color: Colors.white),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: TextStyle(
            color: isActive ? AppColors.primary : Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildShippingPage(CheckoutViewModel viewModel) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Text(
            'Shipping Information',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          AddressForm(
            onSave: (address) {
              viewModel.updateShippingAddress(address);
              _goToNextPage();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentPage(CheckoutViewModel viewModel) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Text(
            'Payment Method',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          PaymentMethodCard(
            selectedMethod: viewModel.selectedPaymentMethod,
            onMethodSelected: viewModel.selectPaymentMethod,
            onCardSaved: (card) {
              viewModel.updatePaymentCard(card);
              _goToNextPage();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildReviewPage(
      CartViewModel cartViewModel,
      CheckoutViewModel checkoutViewModel,
      ) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Text(
            'Review Your Order',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          SummaryCard(
            items: cartViewModel.cartItems,
            subtotal: cartViewModel.subtotal,
            tax: cartViewModel.tax,
            deliveryFee: cartViewModel.deliveryFee,
            total: cartViewModel.total,
            shippingAddress: checkoutViewModel.shippingAddress,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar(
      CartViewModel cartViewModel,
      CheckoutViewModel checkoutViewModel,
      ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            if (_currentStep > 0)
              TextButton(
                onPressed: _goToPreviousPage,
                child: const Text('Back'),
              ),
            const Spacer(),
            if (_currentStep < 2)
              ElevatedButton(
                onPressed: _goToNextPage,
                child: const Text('Next'),
              ),
            if (_currentStep == 2)
              ElevatedButton(
                onPressed: () => _placeOrder(cartViewModel, checkoutViewModel),
                child: checkoutViewModel.isProcessing
                    ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
                    : const Text('Place Order'),
              ),
          ],
        ),
      ),
    );
  }

  void _goToNextPage() {
    if (_currentStep < 2) {
      setState(() {
        _currentStep++;
      });
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _goToPreviousPage() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> _placeOrder(
      CartViewModel cartViewModel,
      CheckoutViewModel checkoutViewModel,
      ) async {
    try {
      // Generate a more user-friendly order number
      final orderNumber = 'ORD-${DateTime.now().millisecondsSinceEpoch}';

      final order = Order(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        orderNumber: orderNumber,
        date: DateTime.now(),
        subtotal: cartViewModel.subtotal,
        shippingCost: cartViewModel.deliveryFee,
        tax: cartViewModel.tax,
        totalAmount: cartViewModel.total,
        status: OrderStatus.processing,
        items: cartViewModel.cartItems,
        shippingAddress: checkoutViewModel.shippingAddress!,
        paymentMethod: checkoutViewModel.selectedPaymentMethod,
        paymentId: checkoutViewModel.paymentCard?.cardNumber.substring(
            checkoutViewModel.paymentCard!.cardNumber.length - 4),
        estimatedDelivery: DateTime.now().add(const Duration(days: 3)),
      );

      // Navigate to order confirmation screen
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/order-confirmation',
            (route) => false,
        arguments: order,
      );

      // Clear the cart after successful order
      cartViewModel.clearCart();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
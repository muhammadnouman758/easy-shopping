import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tera/features/product_detail/product_detail_view_model.dart';

import '../../core/contants/app_color.dart';
import '../cart/cart_item_model.dart';
import '../cart/cart_view_model.dart';
import '../products/product_model.dart';
import '../widgets/color_selector.dart';
import '../widgets/image_gallery.dart';
import '../widgets/product_info.dart';
import '../widgets/size_selector.dart';
import '../widgets/variant_selector.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProductDetailViewModel(product: product),
        ),
        ChangeNotifierProvider(
          create: (_) => CartViewModel(),
        ),
      ],
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            _buildAppBar(),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  _buildBody(),
                  _buildAddToCartButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Consumer<ProductDetailViewModel>(
      builder: (context, viewModel, child) {
        return SliverAppBar(
          expandedHeight: 300,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            background: ImageGallery(
              images: viewModel.product.imageUrls,
              currentIndex: viewModel.currentImageIndex,
              onPageChanged: viewModel.updateImageIndex,
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.share),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Share functionality not implemented yet')),
                );
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildBody() {
    return Consumer<ProductDetailViewModel>(
      builder: (context, viewModel, child) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProductInfo(
                name: viewModel.product.name,
                brand: viewModel.product.brand,
                price: viewModel.product.price,
                oldPrice: viewModel.product.oldPrice,
                rating: viewModel.product.rating,
                reviewCount: viewModel.product.reviewCount,
                description: viewModel.product.description,
                isFavorite: viewModel.product.isFavorite,
                onFavoritePressed: viewModel.toggleFavorite,
              ),
              const SizedBox(height: 16),
              ColorSelector(
                colors: viewModel.product.availableColors,
                selectedColor: viewModel.selectedColor,
                onColorSelected: viewModel.selectColor,
              ),
              const SizedBox(height: 16),
              SizeSelector(
                sizes: viewModel.product.availableSizes,
                selectedSize: viewModel.selectedSize,
                onSizeSelected: viewModel.selectSize,
              ),
              const SizedBox(height: 16),
              VariantSelector(
                quantity: viewModel.quantity,
                onIncrease: viewModel.increaseQuantity,
                onDecrease: viewModel.decreaseQuantity,
              ),
              const SizedBox(height: 40),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAddToCartButton() {
    return Consumer<ProductDetailViewModel>(
      builder: (context, viewModel, child) {
        final cartViewModel = Provider.of<CartViewModel>(context, listen: false);
        final bool canAddToCart = viewModel.selectedColor != null && viewModel.selectedSize != null;

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                foregroundColor: canAddToCart ? Colors.white : Colors.grey,
                disabledBackgroundColor: AppColors.primary.withOpacity(0.5),
              ),
              onPressed: canAddToCart
                  ? () {
                cartViewModel.addToCart(
                  CartItem(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    productId: viewModel.product.id,
                    name: viewModel.product.name,
                    imageUrl: viewModel.product.imageUrls.isNotEmpty
                        ? viewModel.product.imageUrls.first
                        : 'https://via.placeholder.com/150',
                    price: viewModel.product.price,
                    selectedColor: viewModel.selectedColor!,
                    selectedSize: viewModel.selectedSize!,
                    quantity: viewModel.quantity,
                  ) as Product,
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${viewModel.product.name} added to cart'),
                  ),
                );
              }
                  : null,
              child: const Text(
                'Add to Cart',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../product_detail/product_detail_screen.dart';
import '../products/product_model.dart';
import '../search/search_view_model.dart';

class SearchResults extends StatelessWidget {
  const SearchResults({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final searchViewModel = Provider.of<SearchViewModel>(context);

    if (searchViewModel.isSearching) {
      return const Center(child: CircularProgressIndicator());
    }

    if (searchViewModel.searchQuery.isEmpty) {
      return Container();
    }

    if (searchViewModel.searchResults.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.search_off, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            Text(
              'No results for "${searchViewModel.searchQuery}"',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            const Text('Try a different search'),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: searchViewModel.searchResults.length,
      itemBuilder: (context, index) {
        final product = searchViewModel.searchResults[index];
        return _buildProductItem(context, product);
      },
    );
  }

  Widget _buildProductItem(BuildContext context, Product product) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            product.imageUrls.first,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(product.name),
        subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailScreen(product: product),
            ),
          );
        },
      ),
    );
  }
}
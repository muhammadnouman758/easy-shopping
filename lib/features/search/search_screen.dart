import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tera/features/search/search_view_model.dart';

import '../home/home_view_model.dart';
import '../widgets/recent_searches.dart';
import '../widgets/search_result.dart';
import '../widgets/search_bar.dart' as search;


class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final homeViewModel = Provider.of<HomeViewModel>(context);
    final searchViewModel = Provider.of<SearchViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Column(
        children: [
          search.SearchBar(
            controller: _searchController,
            onSearch: (query) {
              searchViewModel.searchProducts(query, homeViewModel.products);
            },
            onClear: () {
              _searchController.clear();
              searchViewModel.clearSearch();
            },
            autofocus: true,
          ),
          if (searchViewModel.searchQuery.isEmpty)
            Expanded(
              child: RecentSearches(
                onSearch: (query) {
                  _searchController.text = query;
                  searchViewModel.searchProducts(query, homeViewModel.products);
                },
              ),
            )
          else
            Expanded(
              child: SearchResults(),
            ),
        ],
      ),
    );
  }
}
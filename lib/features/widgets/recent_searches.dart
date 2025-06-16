import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../search/search_view_model.dart';

class RecentSearches extends StatelessWidget {
  final Function(String) onSearch;

  const RecentSearches({Key? key, required this.onSearch}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final searchViewModel = Provider.of<SearchViewModel>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Recent Searches',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (searchViewModel.recentSearches.isNotEmpty)
                TextButton(
                  onPressed: () {
                    searchViewModel.clearRecentSearches();
                  },
                  child: const Text('Clear All'),
                ),
            ],
          ),
        ),
        if (searchViewModel.recentSearches.isEmpty)
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('No recent searches'),
          )
        else
          Column(
            children: searchViewModel.recentSearches.map((search) {
              return ListTile(
                leading: const Icon(Icons.history),
                title: Text(search),
                trailing: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    searchViewModel.removeRecentSearch(search);
                  },
                ),
                onTap: () {
                  onSearch(search);
                },
              );
            }).toList(),
          ),
      ],
    );
  }
}
import 'package:flutter/material.dart';

import '../../core/contants/app_color.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onSearch;
  final VoidCallback onClear;
  final bool autofocus;

  const SearchBar({
    Key? key,
    required this.controller,
    required this.onSearch,
    required this.onClear,
    this.autofocus = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: controller,
        autofocus: autofocus,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.lightGrey,
          prefixIcon: const Icon(Icons.search),
          suffixIcon: controller.text.isNotEmpty
              ? IconButton(
            icon: const Icon(Icons.clear),
            onPressed: onClear,
          )
              : null,
          hintText: 'Search for products...',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 0),
        ),
        onChanged: onSearch,
        onSubmitted: onSearch,
      ),
    );
  }
}
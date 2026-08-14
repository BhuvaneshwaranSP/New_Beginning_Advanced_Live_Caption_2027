import 'package:flutter/material.dart';

class AppSearchField extends StatelessWidget {
  final ValueChanged<String>? onChanged;
  final String hintText;
  const AppSearchField({super.key, this.onChanged, this.hintText = 'Search'});
  @override
  Widget build(BuildContext context) => SearchBar(hintText: hintText, onChanged: onChanged, leading: const Icon(Icons.search));
}

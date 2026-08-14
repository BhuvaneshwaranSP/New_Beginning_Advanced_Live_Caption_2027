import 'package:flutter/material.dart';

class LanguageSelector extends StatelessWidget {
  final String value;
  final List<String> languages;
  final ValueChanged<String?> onChanged;
  const LanguageSelector({super.key, required this.value, required this.languages, required this.onChanged});
  @override
  Widget build(BuildContext context) => DropdownButtonFormField<String>(initialValue: value, items: languages.map((language) => DropdownMenuItem(value: language, child: Text(language))).toList(), onChanged: onChanged, decoration: const InputDecoration(labelText: 'Language'));
}

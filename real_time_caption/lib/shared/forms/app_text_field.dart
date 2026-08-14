import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String label;
  final String? hintText;
  final TextInputType? keyboardType;
  const AppTextField({super.key, this.controller, required this.label, this.hintText, this.keyboardType});
  @override
  Widget build(BuildContext context) => TextField(controller: controller, keyboardType: keyboardType, decoration: InputDecoration(labelText: label, hintText: hintText));
}

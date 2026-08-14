import 'package:flutter/widgets.dart';

abstract final class SemanticsHelpers {
  static Widget label({required String label, required Widget child}) => Semantics(label: label, child: child);
  static Widget button({required String label, required VoidCallback onTap, required Widget child}) => Semantics(button: true, label: label, onTap: onTap, child: child);
}

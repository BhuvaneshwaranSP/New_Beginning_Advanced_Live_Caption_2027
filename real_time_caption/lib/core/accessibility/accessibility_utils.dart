import 'package:flutter/widgets.dart';

abstract final class AccessibilityUtils {
  static double textScale(BuildContext context) => MediaQuery.textScalerOf(context).scale(1);
}

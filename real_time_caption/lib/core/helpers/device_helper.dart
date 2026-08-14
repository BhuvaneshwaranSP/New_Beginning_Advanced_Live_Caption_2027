import 'package:flutter/widgets.dart';

class DeviceHelper {
  const DeviceHelper();
  bool isTablet(BuildContext context) => MediaQuery.sizeOf(context).shortestSide >= 600;
  bool isLandscape(BuildContext context) => MediaQuery.orientationOf(context) == Orientation.landscape;
}

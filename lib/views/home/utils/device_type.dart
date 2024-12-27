import 'package:flutter/material.dart';

enum DeviceType { mobile, tablet, desktop }

DeviceType getDeviceType(BuildContext context) {
  double width = MediaQuery.of(context).size.width;
  if (width < 987) {
    return DeviceType.mobile;
  } else if (width < 1200) {
    return DeviceType.tablet;
  } else {
    return DeviceType.desktop;
  }
}

import 'package:flutter/material.dart';
import 'package:real_time_caption/app/app.dart';

void main() {
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
  };
  runApp(const LinguaLiveApp());
}

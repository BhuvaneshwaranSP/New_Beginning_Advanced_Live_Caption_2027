import 'package:flutter/material.dart';
import 'app/app.dart';

void main() {
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
  };
  runApp(const LinguaLiveApp());
}

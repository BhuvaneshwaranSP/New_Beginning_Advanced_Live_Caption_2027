import 'package:flutter/material.dart';

Future<void> showSuccessDialog(BuildContext context, {required String message}) => showDialog<void>(context: context, builder: (_) => AlertDialog(title: const Text('Success'), content: Text(message), actions: [FilledButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Done'))]));

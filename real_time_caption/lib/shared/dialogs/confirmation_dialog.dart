import 'package:flutter/material.dart';

Future<bool?> showConfirmationDialog(BuildContext context, {required String title, required String message}) => showDialog<bool>(context: context, builder: (_) => AlertDialog(title: Text(title), content: Text(message), actions: [TextButton(onPressed: () => Navigator.of(context).pop(false), child: const Text('Cancel')), FilledButton(onPressed: () => Navigator.of(context).pop(true), child: const Text('Confirm'))]));

import 'package:flutter/material.dart';

Future<String?> showLanguagePicker(BuildContext context, {required List<String> languages}) => showModalBottomSheet<String>(context: context, builder: (_) => SafeArea(child: ListView(shrinkWrap: true, children: languages.map((language) => ListTile(title: Text(language), onTap: () => Navigator.of(context).pop(language))).toList())));

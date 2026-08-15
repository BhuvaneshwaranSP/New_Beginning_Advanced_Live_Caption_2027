import 'package:flutter/material.dart';

class SessionsHeader extends StatelessWidget {
  const SessionsHeader({
    required this.controller,
    super.key,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Sessions',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Temporary multilingual spaces for real conversations.',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            IconButton.filledTonal(
              tooltip: 'Session options',
              onPressed: () {},
              icon: const Icon(Icons.more_horiz_rounded),
            ),
          ],
        ),
        const SizedBox(height: 20),
        SearchBar(
          controller: controller,
          hintText: 'Search sessions, people or languages',
          leading: const Icon(Icons.search_rounded),
          trailing: <Widget>[
            if (controller.text.isNotEmpty)
              IconButton(
                tooltip: 'Clear search',
                onPressed: () {
                  controller.clear();
                },
                icon: const Icon(Icons.clear_rounded),
              ),
          ],
        ),
      ],
    );
  }
}
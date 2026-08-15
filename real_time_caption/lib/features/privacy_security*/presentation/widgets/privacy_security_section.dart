import 'package:flutter/material.dart';

import '../../domain/entities/privacy_security_entity.dart';
import 'privacy_security_tile.dart';

class PrivacySecuritySection extends StatelessWidget {
  const PrivacySecuritySection({
    super.key,
    required this.title,
    required this.items,
    required this.onItemPressed,
    required this.onToggle,
  });

  final String title;
  final List<PrivacySecurityEntity> items;
  final ValueChanged<PrivacySecurityEntity> onItemPressed;
  final void Function(PrivacySecurityEntity item, bool value) onToggle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(4, 8, 4, 8),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
        ),
        Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              for (var index = 0; index < items.length; index++) ...[
                PrivacySecurityTile(
                  item: items[index],
                  onPressed: () => onItemPressed(items[index]),
                  onChanged: items[index].enabled == null
                      ? null
                      : (value) => onToggle(items[index], value),
                ),
                if (index < items.length - 1)
                  const Divider(height: 1, indent: 72),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
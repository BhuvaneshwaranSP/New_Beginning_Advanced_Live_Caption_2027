import 'package:flutter/material.dart';

import '../../domain/entities/privacy_security_entity.dart';

class PrivacySecurityTile extends StatelessWidget {
  const PrivacySecurityTile({
    super.key,
    required this.item,
    required this.onPressed,
    this.onChanged,
  });

  final PrivacySecurityEntity item;
  final VoidCallback onPressed;
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final destructive = item.isDestructive;

    return Semantics(
      button: true,
      label: '${item.title}. ${item.description}',
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 6,
        ),
        minVerticalPadding: 10,
        leading: CircleAvatar(
          backgroundColor: destructive
              ? colorScheme.errorContainer
              : colorScheme.secondaryContainer,
          foregroundColor:
              destructive ? colorScheme.error : colorScheme.onSecondaryContainer,
          child: Icon(item.icon),
        ),
        title: Text(
          item.title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: destructive ? colorScheme.error : null,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(item.description),
        ),
        trailing: _buildTrailing(context),
        onTap: onPressed,
      ),
    );
  }

  Widget _buildTrailing(BuildContext context) {
    if (item.enabled != null && onChanged != null) {
      return Switch(
        value: item.enabled!,
        onChanged: onChanged,
      );
    }

    if (item.valueLabel != null) {
      return Flexible(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Text(
                item.valueLabel!,
                textAlign: TextAlign.end,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
            const SizedBox(width: 4),
            const Icon(Icons.chevron_right),
          ],
        ),
      );
    }

    return const Icon(Icons.chevron_right);
  }
}
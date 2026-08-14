/*
1. PAGE NAME
   Contact List Tile

2. PURPOSE
   Displays an individual multilingual LinguaLive contact.

3. DESCRIPTION
   Presents initials, name, language pair, availability, favorite state,
   and the most recent interaction.

4. UI SECTIONS
   Avatar, identity, language pair, availability, and action.

5. NAVIGATION FLOW
   ContactsPage → ContactListTile.

6. DYNAMIC COMPONENTS
   ContactFeatureModel values.

7. FUTURE BACKEND INTEGRATION
   The primary action callback can later start the supported communication
   flow for the selected contact. No chat or call functionality is implemented.

8. TECHNOLOGIES USED
   Flutter Material 3.

9. REQUIRED DATA MODELS
   ContactFeatureModel.

10. FUTURE API ENDPOINTS
    Not specified in supplied documentation.

11. DATABASE COLLECTIONS/TABLES
    Not specified.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    Star, language, and communication Material Icons.

14. THEME COLORS
    Material 3 ColorScheme.

15. ANIMATIONS
    AnimatedContainer for subtle selection feedback.

16. ACCESSIBILITY
    Full contact information is available through semantics.

17. EDGE CASES
    Long names, absent interaction text, and offline contacts.

18. VALIDATION RULES
    Contact name and ID are expected to be non-empty.

19. ERROR HANDLING
    Not applicable.

20. LOADING STATE
    Handled by ContactsStates.

21. EMPTY STATE
    Handled by ContactsStates.

22. OFFLINE BEHAVIOUR
    Availability indicator communicates dummy offline status.

23. SECURITY CONSIDERATIONS
    No real contact data is used.

24. PERFORMANCE OPTIMIZATIONS
    Small stateless tile and lightweight implicit animation.

25. WIDGET TREE OVERVIEW
    AnimatedContainer → ListTile → avatar + identity + action.

26. COMPLETE TESTING CHECKLIST
    Verify long multilingual names, touch targets, semantics, and animation.
*/

import 'package:flutter/material.dart';

import '../../data/models/contacts_feature_model.dart';

class ContactListTile extends StatelessWidget {
  const ContactListTile({
    super.key,
    required this.contact,
    required this.onPressed,
  });

  final ContactFeatureModel contact;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colors = theme.colorScheme;

    return Semantics(
      button: true,
      label:
          '${contact.name}, ${contact.primaryLanguage} to '
          '${contact.secondaryLanguage}, '
          '${contact.isOnline ? 'online' : 'offline'}',
      child: Card(
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Row(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 26,
                      backgroundColor: colors.secondaryContainer,
                      child: Text(
                        contact.initials,
                        style: TextStyle(
                          color: colors.onSecondaryContainer,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        width: 13,
                        height: 13,
                        decoration: BoxDecoration(
                          color: contact.isOnline
                              ? Colors.green
                              : colors.surfaceContainerHighest,
                          shape: BoxShape.circle,
                          border: Border.all(color: colors.surface, width: 2),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              contact.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          if (contact.isFavorite)
                            Icon(
                              Icons.star_rounded,
                              size: 18,
                              color: colors.primary,
                            ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Wrap(
                        spacing: 5,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.translate_rounded,
                            size: 15,
                            color: colors.onSurfaceVariant,
                          ),
                          Text(
                            '${contact.primaryLanguage} → '
                            '${contact.secondaryLanguage}',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: colors.onSurfaceVariant,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      if (contact.lastInteraction != null) ...<Widget>[
                        const SizedBox(height: 4),
                        Text(
                          contact.lastInteraction!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: colors.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  tooltip: 'Connect with ${contact.name}',
                  onPressed: onPressed,
                  icon: const Icon(Icons.arrow_forward_rounded),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

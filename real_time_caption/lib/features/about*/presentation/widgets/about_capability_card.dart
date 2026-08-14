/*
1. PAGE NAME
   About Capability Card

2. PURPOSE
   Displays one documented LinguaLive capability.

3. DESCRIPTION
   Reusable Material 3 presentation widget for the About page.

4. UI SECTIONS
   Capability icon, title, and description.

5. NAVIGATION FLOW
   About page → capability card.

6. DYNAMIC COMPONENTS
   Capability title and description.

7. FUTURE BACKEND INTEGRATION
   The widget consumes the domain entity supplied by the presentation
   layer; future data integration belongs upstream rather than here.

8. TECHNOLOGIES USED
   Flutter Material 3.

9. REQUIRED DATA MODELS
   AboutCapabilityEntity.

10. FUTURE API ENDPOINTS
    None.

11. DATABASE COLLECTIONS/TABLES
    None.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    Icons.auto_awesome_outlined.

14. THEME COLORS
    Material 3 ColorScheme.

15. ANIMATIONS
    Lightweight InkWell interaction feedback supplied by Material.

16. ACCESSIBILITY
    Semantic button/card labeling through meaningful visible text.

17. EDGE CASES
    Long titles and descriptions.

18. VALIDATION RULES
    Text must remain readable when font scaling is increased.

19. ERROR HANDLING
    Not applicable.

20. LOADING STATE
    Not applicable.

21. EMPTY STATE
    Not applicable for an individual card.

22. OFFLINE BEHAVIOUR
    Fully local.

23. SECURITY CONSIDERATIONS
    No sensitive information.

24. PERFORMANCE OPTIMIZATIONS
    Small stateless widget with const-compatible structure.

25. WIDGET TREE OVERVIEW
    Card → ListTile → icon + title + description.

26. COMPLETE TESTING CHECKLIST
    Long text wrapping, dark mode, large text, screen reader,
    tablet width, and touch target.
*/

import 'package:flutter/material.dart';

import '../../domain/entities/about_feature_entity.dart';

class AboutCapabilityCard extends StatelessWidget {
  final AboutCapabilityEntity capability;

  const AboutCapabilityCard({super.key, required this.capability});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Semantics(
              label: '${capability.title} capability',
              child: CircleAvatar(
                radius: 22,
                backgroundColor: colorScheme.secondaryContainer,
                child: Icon(
                  Icons.auto_awesome_outlined,
                  color: colorScheme.onSecondaryContainer,
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    capability.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    capability.description,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                      height: 1.45,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

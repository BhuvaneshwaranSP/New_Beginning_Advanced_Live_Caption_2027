/*
1. PAGE NAME
   About Technology Tile

2. PURPOSE
   Presents one technology documented for the LinguaLive communication
   processing pipeline.

3. DESCRIPTION
   Compact reusable Material 3 tile for technology name and role.

4. UI SECTIONS
   Technology icon, technology name, and role.

5. NAVIGATION FLOW
   About page → technology tile.

6. DYNAMIC COMPONENTS
   Technology name and role.

7. FUTURE BACKEND INTEGRATION
   The widget remains presentation-only; future metadata retrieval belongs
   to the data/domain layers.

8. TECHNOLOGIES USED
   Flutter Material 3.

9. REQUIRED DATA MODELS
   AboutTechnologyEntity.

10. FUTURE API ENDPOINTS
    None.

11. DATABASE COLLECTIONS/TABLES
    None.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    Icons.memory_outlined.

14. THEME COLORS
    Material 3 ColorScheme.

15. ANIMATIONS
    Material touch feedback only.

16. ACCESSIBILITY
    Visible text provides the semantic information.

17. EDGE CASES
    Very long model names and roles.

18. VALIDATION RULES
    Text must wrap rather than overflow.

19. ERROR HANDLING
    Not applicable.

20. LOADING STATE
    Not applicable.

21. EMPTY STATE
    Not applicable.

22. OFFLINE BEHAVIOUR
    Local presentation.

23. SECURITY CONSIDERATIONS
    No private information.

24. PERFORMANCE OPTIMIZATIONS
    Stateless lightweight widget.

25. WIDGET TREE OVERVIEW
    ListTile → leading icon + title + subtitle.

26. COMPLETE TESTING CHECKLIST
    Long technology names, large text, dark mode, accessibility,
    tablet width, and scrolling.
*/

import 'package:flutter/material.dart';

import '../../domain/entities/about_feature_entity.dart';

class AboutTechnologyTile extends StatelessWidget {
  final AboutTechnologyEntity technology;

  const AboutTechnologyTile({super.key, required this.technology});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      leading: CircleAvatar(
        backgroundColor: colorScheme.surfaceContainerHighest,
        child: Icon(Icons.memory_outlined, color: colorScheme.onSurfaceVariant),
      ),
      title: Text(
        technology.name,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 3),
        child: Text(
          technology.role,
          style: TextStyle(color: colorScheme.onSurfaceVariant),
        ),
      ),
    );
  }
}

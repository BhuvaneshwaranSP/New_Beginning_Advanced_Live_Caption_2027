/*
1. PAGE NAME
   Accessibility Dummy Data

2. PURPOSE
   Provides realistic local accessibility data for UI development.

3. DESCRIPTION
   Contains only local dummy data. No persistence, networking, or backend
   functionality is implemented.

4. UI SECTIONS
   Text size, caption size, high contrast, reduced motion, screen reader,
   spoken output, visual alerts, haptic feedback, and communication preferences.

5. NAVIGATION FLOW
   Dummy data → mock data source → controller → AccessibilityPage.

6. DYNAMIC COMPONENTS
   Switches, sliders, and communication preference selections.

7. FUTURE BACKEND INTEGRATION
   A future preference service can replace this local data source.

8. TECHNOLOGIES USED
   Dart and Flutter Material Icons.

9. REQUIRED DATA MODELS
   AccessibilitySettingModel and CommunicationPreferenceModel.

10. FUTURE API ENDPOINTS
    None specified.

11. DATABASE COLLECTIONS/TABLES
    None specified.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    Material Icons.

14. THEME COLORS
    None.

15. ANIMATIONS
    None.

16. ACCESSIBILITY
    All settings have readable titles and descriptions.

17. EDGE CASES
    Scale values remain within the controller's supported range.

18. VALIDATION RULES
    Slider values are bounded between 0.85 and 1.35.

19. ERROR HANDLING
    Not required for static local data.

20. LOADING STATE
    Not required for static local data.

21. EMPTY STATE
    Supported by the presentation layer.

22. OFFLINE BEHAVIOUR
    Fully functional because all data is local.

23. SECURITY CONSIDERATIONS
    No sensitive information is included.

24. PERFORMANCE OPTIMIZATIONS
    Uses const immutable collections.

25. WIDGET TREE OVERVIEW
    Dummy models → data source → controller → widgets.

26. COMPLETE TESTING CHECKLIST
    Verify every setting renders its icon and description correctly.
*/

import 'package:flutter/material.dart';

import '../models/accessibility_feature_model.dart';

const List<AccessibilitySettingModel>
accessibilitySettings = <AccessibilitySettingModel>[
  AccessibilitySettingModel(
    id: 'text_size',
    title: 'Text size',
    description: 'Make interface text easier to read.',
    icon: Icons.format_size,
    enabled: true,
    value: 1.0,
    valueLabel: 'Default',
  ),
  AccessibilitySettingModel(
    id: 'caption_size',
    title: 'Caption size',
    description: 'Adjust the size of live captions.',
    icon: Icons.closed_caption_outlined,
    enabled: true,
    value: 1.0,
    valueLabel: 'Default',
  ),
  AccessibilitySettingModel(
    id: 'high_contrast',
    title: 'High contrast',
    description: 'Increase visual separation between content and background.',
    icon: Icons.contrast,
    enabled: false,
  ),
  AccessibilitySettingModel(
    id: 'reduced_motion',
    title: 'Reduced motion',
    description: 'Use simpler transitions and movement.',
    icon: Icons.motion_photos_off_outlined,
    enabled: false,
  ),
  AccessibilitySettingModel(
    id: 'screen_reader',
    title: 'Screen reader support',
    description: 'Keep controls clearly labelled for screen readers.',
    icon: Icons.accessibility_new,
    enabled: true,
  ),
  AccessibilitySettingModel(
    id: 'spoken_output',
    title: 'Spoken output',
    description: 'Prefer optional spoken output for translated content.',
    icon: Icons.record_voice_over_outlined,
    enabled: true,
  ),
  AccessibilitySettingModel(
    id: 'visual_alerts',
    title: 'Visual alerts',
    description: 'Show visible indicators for important communication events.',
    icon: Icons.notifications_active_outlined,
    enabled: true,
  ),
  AccessibilitySettingModel(
    id: 'haptic_feedback',
    title: 'Haptic feedback',
    description: 'Use touch feedback for supported interactions.',
    icon: Icons.vibration_outlined,
    enabled: true,
  ),
];

const List<CommunicationPreferenceModel> communicationPreferences =
    <CommunicationPreferenceModel>[
      CommunicationPreferenceModel(
        id: 'captions',
        title: 'Captions',
        description: 'Show spoken communication as readable text.',
        icon: Icons.closed_caption_outlined,
        selected: true,
      ),
      CommunicationPreferenceModel(
        id: 'translation',
        title: 'Translation',
        description: 'Show translated communication alongside the original.',
        icon: Icons.translate_outlined,
        selected: true,
      ),
      CommunicationPreferenceModel(
        id: 'spoken_translation',
        title: 'Spoken translation',
        description: 'Allow translated text to be presented as spoken output.',
        icon: Icons.volume_up_outlined,
        selected: false,
      ),
    ];

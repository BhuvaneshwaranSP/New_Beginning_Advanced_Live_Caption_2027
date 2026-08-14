/*
1. PAGE NAME
   Downloads Dummy Data

2. PURPOSE
   Provides realistic local-only data for the Downloads screen.

3. DESCRIPTION
   Contains multilingual examples representing resources that may be available
   for offline multilingual communication.

4. UI SECTIONS
   Download list and summary.

5. NAVIGATION FLOW
   Dummy data → mock data source → controller → Downloads page.

6. DYNAMIC COMPONENTS
   Language pairs, file types, statuses, sizes, and progress.

7. FUTURE BACKEND INTEGRATION
   Future: replace this static source with the project's intended download
   metadata source while preserving the same presentation contract.

8. TECHNOLOGIES USED
   Dart.

9. REQUIRED DATA MODELS
   DownloadsFeatureModel.

10. FUTURE API ENDPOINTS
    Not specified by the supplied project documentation.

11. DATABASE COLLECTIONS/TABLES
    Not specified by the supplied project documentation.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    None.

14. THEME COLORS
    None.

15. ANIMATIONS
    None.

16. ACCESSIBILITY
    Multilingual text is intentionally included for testing.

17. EDGE CASES
    Includes completed, downloading, paused, and failed examples.

18. VALIDATION RULES
    Values are controlled dummy values.

19. ERROR HANDLING
    Failed dummy item demonstrates the UI error state.

20. LOADING STATE
    Downloading dummy item demonstrates progress.

21. EMPTY STATE
    Produced by filtering or controller state.

22. OFFLINE BEHAVIOUR
    Completed offline resources are marked explicitly.

23. SECURITY CONSIDERATIONS
    No real files are referenced.

24. PERFORMANCE OPTIMIZATIONS
    Small immutable constant list.

25. WIDGET TREE OVERVIEW
    Dummy list → Model → Card.

26. COMPLETE TESTING CHECKLIST
    Test all statuses and multilingual strings.
*/

import '../models/downloads_feature_model.dart';

const List<DownloadsFeatureModel> downloadsDummyData = [
  DownloadsFeatureModel(
    id: 'dl-001',
    title: 'English → தமிழ் Language Pack',
    sourceLanguage: 'English',
    targetLanguage: 'தமிழ்',
    type: DownloadItemType.languagePack,
    sizeLabel: '84 MB',
    updatedLabel: 'Updated today',
    status: DownloadItemStatus.completed,
    progress: 1,
    isAvailableOffline: true,
  ),
  DownloadsFeatureModel(
    id: 'dl-002',
    title: 'हिन्दी → English Conversation',
    sourceLanguage: 'हिन्दी',
    targetLanguage: 'English',
    type: DownloadItemType.conversation,
    sizeLabel: '12 MB',
    updatedLabel: 'Updated yesterday',
    status: DownloadItemStatus.completed,
    progress: 1,
    isAvailableOffline: true,
  ),
  DownloadsFeatureModel(
    id: 'dl-003',
    title: 'తెలుగు → മലയാളം Transcript',
    sourceLanguage: 'తెలుగు',
    targetLanguage: 'മലയാളം',
    type: DownloadItemType.transcript,
    sizeLabel: '4.8 MB',
    updatedLabel: 'Updated 2 days ago',
    status: DownloadItemStatus.downloading,
    progress: 0.68,
    isAvailableOffline: false,
  ),
  DownloadsFeatureModel(
    id: 'dl-004',
    title: 'Tamil → Hindi Meeting Audio',
    sourceLanguage: 'தமிழ்',
    targetLanguage: 'हिन्दी',
    type: DownloadItemType.audio,
    sizeLabel: '31 MB',
    updatedLabel: 'Updated 4 days ago',
    status: DownloadItemStatus.paused,
    progress: 0.42,
    isAvailableOffline: false,
  ),
  DownloadsFeatureModel(
    id: 'dl-005',
    title: 'English → తెలుగు Language Pack',
    sourceLanguage: 'English',
    targetLanguage: 'తెలుగు',
    type: DownloadItemType.languagePack,
    sizeLabel: '91 MB',
    updatedLabel: 'Updated 1 week ago',
    status: DownloadItemStatus.failed,
    progress: 0.21,
    isAvailableOffline: false,
  ),
];

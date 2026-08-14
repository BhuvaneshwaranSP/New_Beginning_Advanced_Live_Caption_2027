/*
1. PAGE NAME
   Mock Transcription Data Source

2. PURPOSE
   Provides local transcription data for UI development.

3. DESCRIPTION
   Simulates the data boundary without networking, APIs, databases,
   speech recognition, or streaming services.

4. UI SECTIONS
   Feeds the transcript list.

5. NAVIGATION FLOW
   Mock data source → Controller → Presentation.

6. DYNAMIC COMPONENTS
   Local transcription segments.

7. FUTURE BACKEND INTEGRATION
   A future streaming ASR data source belongs here because this layer
   supplies transcription records to the presentation controller.

8. TECHNOLOGIES USED
   Pure Dart.

9. REQUIRED DATA MODELS
   TranscriptionModel.

10. FUTURE API ENDPOINTS
    To be defined during backend implementation.

11. DATABASE COLLECTIONS/TABLES
    None during UI-only development.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    None.

14. THEME COLORS
    Not applicable.

15. ANIMATIONS
    None.

16. ACCESSIBILITY
    Not applicable.

17. EDGE CASES
    Empty local result.

18. VALIDATION RULES
    No external validation.

19. ERROR HANDLING
    No remote failures.

20. LOADING STATE
    Simulated by the controller.

21. EMPTY STATE
    Supported by returning an empty list.

22. OFFLINE BEHAVIOUR
    Local data remains available without network access.

23. SECURITY CONSIDERATIONS
    No real transcript data is used.

24. PERFORMANCE OPTIMIZATIONS
    Synchronous local access.

25. WIDGET TREE OVERVIEW
    Not applicable.

26. COMPLETE TESTING CHECKLIST
    Verify successful and empty local data responses.
*/

import '../dummy/transcription_dummy_data.dart';
import '../models/transcription_model.dart';

class MockTranscriptionDataSource {
  const MockTranscriptionDataSource();

  List<TranscriptionModel> loadTranscriptions() {
    return transcriptionDummyData;
  }
}

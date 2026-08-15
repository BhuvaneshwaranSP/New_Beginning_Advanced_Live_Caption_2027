import 'package:go_router/go_router.dart';
import 'package:real_time_caption/features/about*/presentation/pages/about_page.dart';
import 'package:real_time_caption/features/ai_models*/presentation/pages/ai_models_page.dart';
import 'package:real_time_caption/features/analytics*/presentation/pages/analytics_page.dart';
import 'package:real_time_caption/features/calls*/presentation/pages/calls_page.dart';
import 'package:real_time_caption/features/chat*/presentation/pages/chat_page.dart';
import 'package:real_time_caption/features/contacts*/presentation/pages/contacts_page.dart';
import 'package:real_time_caption/features/conversations*/presentation/pages/conversations_page.dart';
import 'package:real_time_caption/features/downloads*/presentation/pages/downloads_page.dart';
import 'package:real_time_caption/features/feedback*/presentation/pages/feedback_page.dart';
import 'package:real_time_caption/features/help_center*/presentation/pages/help_center_page.dart';
import 'package:real_time_caption/features/history*/presentation/pages/history_page.dart';
import 'package:real_time_caption/features/home*/presentation/pages/home_page.dart';
import 'package:real_time_caption/features/notifications*/presentation/pages/notifications_page.dart';
import 'package:real_time_caption/features/profile*/presentation/pages/profile_page.dart';
import 'package:real_time_caption/features/settings*/presentation/pages/settings_page.dart';
import 'package:real_time_caption/features/subscription*/presentation/pages/subscription_page.dart';
import 'package:real_time_caption/features/transcription*/presentation/pages/transcription_page.dart';
import 'package:real_time_caption/features/translation*/presentation/pages/translation_page.dart';
import 'package:real_time_caption/features/voice_clone*/presentation/pages/voice_clone_page.dart';
import 'routes.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.home,

  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return MainNavigationPage(child: child);
      },
      routes: <RouteBase>[
        GoRoute(
          path: AppRoutes.home,
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: AppRoutes.chat,
          builder: (context, state) => const ChatPage(),
        ),
        GoRoute(
          path: AppRoutes.history,
          builder: (context, state) => const HistoryPage(),
        ),
        GoRoute(
          path: AppRoutes.profile,
          builder: (context, state) => const ProfilePage(),
        ),
      ],
    ),

    // Main
    GoRoute(path: AppRoutes.home, builder: (_, _) => const HomePage()),

    // Communication
    GoRoute(path: AppRoutes.chat, builder: (_, _) => const ChatPage()),
    GoRoute(path: AppRoutes.calls, builder: (_, _) => const CallsPage()),
    GoRoute(
      path: AppRoutes.conversations,
      builder: (_, _) => const ConversationsPage(),
    ),
    GoRoute(path: AppRoutes.contacts, builder: (_, _) => const ContactsPage()),

    // Speech / AI
    GoRoute(
      path: AppRoutes.translation,
      builder: (_, _) => const TranslationPage(),
    ),
    GoRoute(
      path: AppRoutes.transcription,
      builder: (_, _) => const TranscriptionPage(),
    ),
    GoRoute(
      path: AppRoutes.voiceClone,
      builder: (_, _) => const VoiceClonePage(),
    ),
    GoRoute(path: AppRoutes.aiModels, builder: (_, _) => const AiModelsPage()),

    // User
    GoRoute(path: AppRoutes.profile, builder: (_, _) => const ProfilePage()),
    GoRoute(path: AppRoutes.settings, builder: (_, _) => const SettingsPage()),
    GoRoute(
      path: AppRoutes.notifications,
      builder: (_, _) => const NotificationsPage(),
    ),

    // History / Data
    GoRoute(path: AppRoutes.history, builder: (_, _) => const HistoryPage()),
    GoRoute(
      path: AppRoutes.downloads,
      builder: (_, _) => const DownloadsPage(),
    ),
    GoRoute(
      path: AppRoutes.analytics,
      builder: (_, _) => const AnalyticsPage(),
    ),

    // Subscription
    GoRoute(
      path: AppRoutes.subscription,
      builder: (_, _) => const SubscriptionPage(),
    ),

    // Support
    GoRoute(path: AppRoutes.feedback, builder: (_, _) => const FeedbackPage()),
    GoRoute(
      path: AppRoutes.helpCenter,
      builder: (_, _) => const HelpCenterPage(),
    ),
    GoRoute(path: AppRoutes.about, builder: (_, _) => const AboutPage()),
  ],
);

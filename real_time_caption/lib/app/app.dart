import 'package:flutter/material.dart';
import 'localization/app_localizations.dart';
import 'localization/supported_locales.dart';
import 'router.dart';
import 'theme/app_theme.dart';

class LinguaLiveApp extends StatelessWidget {
  const LinguaLiveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'LinguaLive',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      routerConfig: appRouter,
      locale: const Locale('en'),
      supportedLocales: SupportedLocales.values,
      localizationsDelegates: const [AppLocalizations.delegate],
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
        child: child ?? const SizedBox.shrink(),
      ),
    );
  }
}

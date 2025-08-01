import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import './app/auth/presentation/controllers/auth_controller.dart'; // Authentication provider
import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n.dart';
import 'providers/locale_providers.dart';

import 'core/services/navigation_service.dart'; // Import NavigationService
import 'package:donate2save/app/routes/app_routes.dart';
import 'core/theme/app_theme.dart';

void main() async {
  // Ensures Flutter framework is initialized before running the app
  WidgetsFlutterBinding.ensureInitialized();

  // Initializes Firebase for the app
  await Firebase.initializeApp();

  // Request permissions

  // Runs the app
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthController()), // Provides auth state
        ChangeNotifierProvider(create: (_) => LocaleProvider()), // Provides locale state
      ],
      child: const MyApp(),
    ),
  );
}

// Root widget of the application
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Donate2Save',
      theme: AppTheme.custom,
      navigatorKey: NavigationService.navigatorKey,
      routes: AppRoutes.all,

      // Localization
      locale: Provider.of<LocaleProvider>(context).locale,
      supportedLocales: S.delegate.supportedLocales,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale?.languageCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
    );
  }
}
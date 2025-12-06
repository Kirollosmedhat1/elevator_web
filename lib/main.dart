import 'package:elevatorweb/routs/app_routs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:elevatorweb/app_translations.dart';
import 'package:elevatorweb/services/supabase_service.dart';
import 'package:elevatorweb/config/supabase_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Supabase
  try {
    await SupabaseService.initialize(
      supabaseUrl: SupabaseConfig.supabaseUrl,
      supabaseAnonKey: SupabaseConfig.supabaseAnonKey,
    );
  } catch (e) {
    debugPrint('Error initializing Supabase: $e');
    // App will still run, but Supabase features won't work
  }

  runApp(ElevatorApp());
}

class ElevatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Beams Elevators',
      initialRoute: '/tabbar',
      getPages: AppRoutes.routes,
      debugShowCheckedModeBanner: false,
      supportedLocales: const [Locale('en'), Locale('ar')],
      locale: const Locale('ar'), // Default to Arabic, can be changed
      localizationsDelegates: const [
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
      translations: AppTranslations(),
    );
  }
}

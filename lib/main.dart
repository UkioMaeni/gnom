import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gnom/core/app_localization.dart';
import 'package:gnom/pages/language_page/language_page.dart';
import 'package:gnom/pages/start_page/start_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);

  runApp(
    EasyLocalization(
      supportedLocales:const [
        AppLocalization.ruLocale,
        AppLocalization.enLocale,
      ],
      path: AppLocalization.translationsPath,
      saveLocale: true,
      fallbackLocale: AppLocalization.enLocale,
      startLocale: AppLocalization.ruLocale,
      child: const MyApp()
      )
    );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GNOM',
       
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        indicatorColor: Colors.white,
        useMaterial3: true,
      ),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      initialRoute: "/start",
      routes: {
        "/start":(context) => const StartPage(),
        "/language":(context) => const LanguagePage()
      },
    );
  }
}


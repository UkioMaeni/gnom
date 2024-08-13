import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gnom/core/app_localization.dart';
import 'package:gnom/core/localization/localization_bloc.dart';
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
final notificationSettings = await FirebaseMessaging.instance.requestPermission(provisional: true);


  runApp(
    BlocProvider(create: (context) => LocalizationBloc(), child: const MyApp())
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
      initialRoute: "/start",
      routes: {
        "/start":(context) => const StartPage(),
        "/language":(context) => const LanguagePage(initial: true,)
      },
    );
  }
}


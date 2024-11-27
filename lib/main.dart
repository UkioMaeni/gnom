import 'package:device_info_plus/device_info_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gnom/UIKit/permision_modal.dart';
import 'package:gnom/core/app_localization.dart';
import 'package:gnom/core/localization/localization_bloc.dart';
import 'package:gnom/pages/language_page/language_page.dart';
import 'package:gnom/pages/start_page/start_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:permission_handler/permission_handler.dart';
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

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  

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
      builder: (context, child) {
        return child??SizedBox.shrink();
      },
      routes: {
        "/start":(context) => const StartPage(),
        "/language":(context) => const LanguagePage(initial: true,)
      },
    );
  }
}

class InherittedApp extends StatefulWidget {
  final Widget child;
  const InherittedApp({super.key,required this.child});

  @override
  State<InherittedApp> createState() => _InherittedAppState();
}

class _InherittedAppState extends State<InherittedApp> with WidgetsBindingObserver  {


  AppLifecycleState? _notification; 

  bool requested=false;


  void requiredPermissons()async{
      if(requested){
        return;
      }
        requested=true;
        final deviceInfo = await DeviceInfoPlugin().androidInfo;
        final version = deviceInfo.version.sdkInt;
        PermissionStatus  status;
        if(version>=33){
            status= await Permission.manageExternalStorage.status;
        }else{
           status= await Permission.storage.status;
        }
        
        if(status.isDenied){
          await showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return Dialog(

                backgroundColor: Colors.transparent,
                child: MediaQuery(
                  data: MediaQueryData(),
                  child: PermisionModal()
                ),
              );
            },
          );
        }
        requested=false;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {
      _notification = state;
      print(_notification);
      print("////////////////////azazaza");
      if(_notification==AppLifecycleState.resumed&&!requested){
        requiredPermissons();
      }
    });
  }

  @override
  void initState() {
    
    super.initState();
    requiredPermissons();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
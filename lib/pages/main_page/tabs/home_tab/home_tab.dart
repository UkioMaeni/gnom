import 'package:flutter/material.dart';
import 'package:gnom/pages/main_page/tabs/home_tab/pages/home_init_page.dart';
import 'package:gnom/pages/main_page/tabs/home_tab/pages/home_studies_page.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab>  {

  @override
  Widget build(BuildContext context) {
    return  Navigator(
        initialRoute: "/init",
        onGenerateRoute: (settings) {
          if(settings.name=="/init"){
            return MaterialPageRoute(builder: (context) => const HOMEInitPage());
          }else if(settings.name=="/studies"){
            return MaterialPageRoute(builder: (context) => const HOMEStudiesPage());
          }
          return MaterialPageRoute(builder: (context) => const Placeholder());
        },
      
    );
  }





  

}
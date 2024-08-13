
import 'package:flutter/material.dart';
import 'package:gnom/pages/main_page/tabs/home_tab/pages/home_init_page.dart';
import 'package:gnom/pages/main_page/tabs/home_tab/pages/home_scince_page.dart';
import 'package:gnom/pages/main_page/tabs/home_tab/pages/home_studies_page.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab>  {


  String route= "/init";
  void updateRoute(String newRoute){
    setState(() {
      route=newRoute;
    });
  }
  @override
  Widget build(BuildContext context) {
    
    if(route=="/init"){
      return  HOMEInitPage(update:updateRoute);
    }else if(route=="/studies"){
      return  HOMEStudiesPage(update:updateRoute);
    }else if(route=="/scince"){
      return  HOMEScincePage(update:updateRoute);
    }
    return const Placeholder();
  }





  

}
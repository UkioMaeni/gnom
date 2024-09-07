import 'package:device_info_plus/device_info_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gnom/UIKit/UIChevron.dart';
import 'package:gnom/UIKit/permision_modal.dart';
import 'package:gnom/core/app_localization.dart';
import 'package:gnom/core/localization/custom_localization.dart';
import 'package:gnom/core/localization/localization_bloc.dart';
import 'package:gnom/pages/main_page/main_page.dart';
import 'package:gnom/repositories/locale_storage.dart';
import 'package:infinite_pageview/infinite_pageview.dart';
import 'package:permission_handler/permission_handler.dart';
class LanguagePage extends StatefulWidget {
  final bool initial;
  const LanguagePage({super.key,required this.initial});

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {

  late final PageController _pageController;
  late InfiniteScrollController _infiniteScrollController;
  bool loadLang=true;
  late Locale locale;
  checkLanguage()async{
    final currentLocale= await localeStorage.appLanguage;
    if(currentLocale!=null){
      locale=currentLocale;
    }else{
      locale=Locale("en","US");
    }
    int initPage=1;
    int initOffset=0;
    if(locale.languageCode=="ru"){
      initPage=0;
      initOffset=0;
    }else if(locale.languageCode=="en"){
      initPage=1;
      initOffset=250;
    }else if(locale.languageCode=="ar"){
      initPage=2;
      initOffset=500;
    }
    _pageController=PageController(initialPage: initPage);
    _infiniteScrollController=InfiniteScrollController(initialScrollOffset: initOffset.toDouble());
    page=initPage;
    setState(() {
      loadLang=false;
    });
    
  }

  @override
  void initState() {
    
    checkLanguage();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void leftClick(){
   // if(page<=0) return;
    //_pageController.animateToPage(page-1, duration: const Duration(milliseconds: 200), curve: Curves.linear);
    _infiniteScrollController.animateTo(_infiniteScrollController.offset-250, duration: Duration(milliseconds: 200), curve: Curves.linear);
    page=(page-1)%3;
    setState(() {
      
    });

  }
  void rightClick(){
    _infiniteScrollController.animateTo(_infiniteScrollController.offset+250, duration: Duration(milliseconds: 200), curve: Curves.linear);
    page=(page+1)%3;
    setState(() {
      
    });
    print(_infiniteScrollController.offset);
   // _pageController.animateToPage(page%3+1, duration: const Duration(milliseconds: 200), curve: Curves.linear);
  }

 late int page;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/jpg/app_bg.jpg"),
                  fit: BoxFit.cover
                )
              ),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Builder(
                  builder: (context) {
                    if(loadLang){
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return Column(
                      children: [
                        const SizedBox(height: 80,),
                        SizedBox(
                          height: 90,
                          child: Text(
                            AppLocalization.getLocaleDescription(AppLocalization.listlocations[page]),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.w800,
                              fontFamily: "NoirPro",
                              height: 1,
                              letterSpacing: 1,
                              color: Color.fromRGBO(254, 222,181, 1)
                              ),
                          ),
                        ),
                        const SizedBox(height: 100,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            UIChevron(
                              type: EChevronType.left,
                              onClick: leftClick,
                            ),
                            SizedBox(
                              width: 250,
                              height: 60,
                              child: InfinitePageView(
                                controller: _infiniteScrollController,
                                physics: NeverScrollableScrollPhysics(),

                                itemBuilder: (context, index) {
                                  int correctIndex=index%3;
                                  if(correctIndex<0){
                                    page=((correctIndex*correctIndex)/(-correctIndex)).toInt();
                                  }
                                  page=correctIndex;
                                  
                                  final locale=AppLocalization.listlocations[correctIndex];
                                  print(index);
                                  return Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                              AppLocalization.getLocaleName(locale),
                                              textAlign: TextAlign.center,
                                              
                                              style: const TextStyle(
                                                fontSize: 40,
                                                fontWeight: FontWeight.w800,
                                                fontFamily: "NoirPro",
                                                height: 1,
                                                letterSpacing: 1,
                                                color: Colors.white
                                                ),
                                            ),
                                  );
                                },
                              ),
                              // child:PageView.builder(
                              //   controller: _pageController,
                              //   scrollDirection: Axis.horizontal,
                              //   onPageChanged: (value) {
                              //     setState(() {
                              //       page=value;
                              //     });
                              //   },
                                
                              //   //itemCount: AppLocalization.localeCount(),
                              //   itemBuilder: (context, index) {
                              //     print(index);
                              //     int correctIndex=index%3;
                              //     final locale=AppLocalization.listlocations[correctIndex];
                              //     //AppLocalization.currentLocale=AppLocalization.listlocations[index];
                              //     return Text(
                              //               AppLocalization.getLocaleName(locale),
                              //               textAlign: TextAlign.center,
                              //               style: const TextStyle(
                              //                 fontSize: 40,
                              //                 fontWeight: FontWeight.w800,
                              //                 fontFamily: "NoirPro",
                              //                 height: 1,
                              //                 letterSpacing: 1,
                              //                 color: Colors.white
                              //                 ),
                              //             );
                              //   },
                              // ) 
                            ),
                            UIChevron(
                              type: EChevronType.right,
                              onClick: rightClick,
                            ),
                          ],
                        ),
                        const Expanded(child: SizedBox.shrink()),
                        setLanguageButton(),
                        const SizedBox(height: 80,)
                      ],
                    );
                  }
                ),
              ),
            ),
    );
  }
Widget setLanguageButton(){
  return GestureDetector(
    onTap: () async{
      print(AppLocalization.currentLocale.toString());
       
       Locale newLocale= AppLocalization.listlocations[page%3];
       await localeStorage.saveAppLanguage(newLocale.toString());
       if(newLocale.languageCode=="ru"){
        context.read<LocalizationBloc>().add(LocalizationSetLocaleEvent(locale:RuLocale() ));
       }else if(newLocale.languageCode=="en"){
        context.read<LocalizationBloc>().add(LocalizationSetLocaleEvent(locale:EnLocale() ));
       }else if(newLocale.languageCode=="ar"){
        context.read<LocalizationBloc>().add(LocalizationSetLocaleEvent(locale: ArLocale()));
       }else{
        context.read<LocalizationBloc>().add(LocalizationSetLocaleEvent(locale: EnLocale()));
       }
       
       if(widget.initial){
        final deviceInfo = await DeviceInfoPlugin().androidInfo;
        final version = deviceInfo.version.sdkInt;
        PermissionStatus  status;
        if(version>=33){
          await Permission.manageExternalStorage.request();
            status= await Permission.manageExternalStorage.status;
        }else{
          await Permission.storage.request();
           status= await Permission.storage.status;
        }
        
        if(status.isDenied){
          await showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return Dialog(

                backgroundColor: Colors.transparent,
                child: PermisionModal(),
              );
            },
          );
        }
        if(version>=33){
            status= await Permission.manageExternalStorage.status;
        }else{
           status= await Permission.storage.status;
        }
        if(status.isDenied){
          return;
        }
        Navigator.push(context, MaterialPageRoute(builder: (context) => const MainPage(),));
       }else{
        Navigator.pop(context);
       }
      
    },
    child: SizedBox(
      width: 140,
      height: 46,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: const Color.fromRGBO(199, 117, 117, 0.322),
          borderRadius: BorderRadius.circular(17)
        ),
        child: Align(
          alignment: Alignment.center,
          child: Text(
                    AppLocalization.getLocaleButtonStart(AppLocalization.listlocations[page%3]),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                      fontFamily: "NoirPro",
                      height: 1,
                      letterSpacing: 1,
                      color: Color.fromRGBO(254, 222,181, 1)
                      ),
                  ),
        ),
      ),
    ),
  );
}

}


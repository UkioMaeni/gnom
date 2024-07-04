import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gnom/UIKit/UIChevron.dart';
import 'package:gnom/core/app_localization.dart';
import 'package:gnom/pages/main_page/main_page.dart';
import 'package:gnom/repositories/locale_storage.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {

  late final PageController _pageController;
  @override
  void initState() {
    _pageController=PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void leftClick(){
    if(page<=0) return;
    _pageController.animateToPage(page-1, duration: const Duration(milliseconds: 200), curve: Curves.linear);

  }
  void rightClick(){
    if(page>=AppLocalization.localeCount()-1) return;
    _pageController.animateToPage(page+1, duration: const Duration(milliseconds: 200), curve: Curves.linear);
  }

  int page=0;

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
                child: Column(
                  children: [
                    SizedBox(height: 20,),
                    GestureDetector(
                      onTap: ()=>Navigator.pop(context),
                      child: Row(
                        children: [
                          SizedBox(width: 20,),
                          Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)
                            ),
                            child: Icon(Icons.arrow_back)
                          ),
                          SizedBox(width: 10,),
                          Text(
                            "Настройки",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w400,
                              fontFamily: "NoirPro",
                              height: 1,
                              color: Colors.white
                              ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 200,
                    ),
                    settingItem(
                      icon: SvgPicture.asset("assets/svg/setting_user.svg",color: Color.fromRGBO(254, 222,181, 1),),
                      title: "Смена пользователя",
                      onTap: () {
                        
                      },
                    ),
                    SizedBox(height: 30,),
                    settingItem(
                      icon: SvgPicture.asset("assets/svg/setting_sub.svg",color: Color.fromRGBO(254, 222,181, 1),),
                      title: "Подписки",
                      onTap: () {
                        
                      },
                    ),
                    SizedBox(height: 30,),
                    settingItem(
                      icon: SvgPicture.asset("assets/svg/setting_lang.svg",color: Color.fromRGBO(254, 222,181, 1),),
                      title: "Смена языка",
                      onTap: () {
                        
                      },
                    ),
                    SizedBox(height: 30,),
                    settingItem(
                      icon: SvgPicture.asset("assets/svg/setting_sup.svg",color: Color.fromRGBO(254, 222,181, 1),),
                      title: "Чат с поддержкой",
                      onTap: () {
                        
                      },
                    ),
                    SizedBox(height: 50,),
                    GestureDetector(
                              onTap: () {
                                //Navigator.push(context, MaterialPageRoute(builder: (context) => AuthPage(),));
                              },
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 45,
                                    width: 45,
                                    child: SvgPicture.asset("assets/svg/exit.svg",color: Color.fromRGBO(254, 222,181, 1),)
                                  ),
                                  Text(
                                    " Выйти",
                                    style: TextStyle(
                                      fontFamily: "NoirPro",
                                      color: Colors.white,
                                      height: 1,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 25
                                    ),
                                ),
                                
                                ],
                              ),
                            ),
                  ],
                ),
              ),
            ),
    );
  }

Widget settingItem({ required Widget icon,required String title,required Function() onTap}){
  return GestureDetector(
    onTap: onTap,
    child: Row(
      children: [
        SizedBox(width: 20,),
        SizedBox(height: 40,width: 40, child: icon),
        SizedBox(width: 10,),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w400,
            fontFamily: "NoirPro",
            height: 1,
            color: Colors.white
            ),
        ),
      ],
    ),
  );
}


Widget setLanguageButton(){
  return GestureDetector(
    onTap: () async{
      print(AppLocalization.currentLocale.toString());
       await localeStorage.saveAppLanguage(AppLocalization.currentLocale.toString());
      Navigator.push(context, MaterialPageRoute(builder: (context) => const MainPage(),));
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
                    AppLocalization.getLocaleButtonStart(AppLocalization.listlocations[page]),
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


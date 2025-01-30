import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gnom/UIKit/UIChevron.dart';
import 'package:gnom/core/app_localization.dart';
import 'package:gnom/core/localization/localization_bloc.dart';
import 'package:gnom/core/tools/string_tool.dart';
import 'package:gnom/pages/chat_support_page/chat_support_page.dart';
import 'package:gnom/pages/language_page/language_page.dart';
import 'package:gnom/pages/main_page/main_page.dart';
import 'package:gnom/pages/start_page/start_page.dart';
import 'package:gnom/repositories/locale_storage.dart';
import 'package:gnom/repositories/token_repo.dart';
import 'package:gnom/store/user_store.dart';

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


   void toLangPage(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => LanguagePage(initial: false,),));
  }

  int page=0;

  viewDeleteAccountWarning(){
  showDialog(
    context: context,
    useSafeArea: false,
    builder: (context) {
      return Dialog(
        elevation: 100,
        insetPadding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        child: DeleteAccountWarningDialog()
      );
    },
    ); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/png/app_bg.png"),
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
                          Builder(
                            builder: (context) {
                               final state = (context.watch<LocalizationBloc>().state as LocalizationLocaleState);
                              return Text(
                                StringTools.firstUpperOfString(state.locale.settings),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "NoirPro",
                                  height: 1,
                                  color: Colors.white
                                  ),
                              );
                            }
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 200,
                    ),
                    // settingItem(
                    //   icon: SvgPicture.asset("assets/svg/setting_user.svg",color: Color.fromRGBO(254, 222,181, 1),),
                    //   title: "Смена пользователя",
                    //   onTap: () {
                        
                    //   },
                    // ),
                    //SizedBox(height: 30,),
                    Builder(
                      builder: (context) {
                        
                        final state = (context.watch<LocalizationBloc>().state as LocalizationLocaleState);
                        
                        return settingItem(
                          icon: SvgPicture.asset("assets/svg/setting_sub.svg",color: Color.fromRGBO(254, 222,181, 1),),
                          title:state.locale.subscriptions ,
                          onTap: () {
                            
                          },
                        );
                      }
                    ),
                    SizedBox(height: 30,),
                    Builder(
                      builder: (context) {
                        final state = (context.watch<LocalizationBloc>().state as LocalizationLocaleState);
                        return settingItem(
                          icon: SvgPicture.asset("assets/svg/setting_lang.svg",color: Color.fromRGBO(254, 222,181, 1),),
                          title: state.locale.language,
                          onTap: toLangPage,
                        );
                      }
                    ),
                    SizedBox(height: 30,),
                    Builder(
                      builder: (context) {
                        final state = (context.watch<LocalizationBloc>().state as LocalizationLocaleState);
                        return settingItem(
                          icon: SvgPicture.asset("assets/svg/setting_sup.svg",color: Color.fromRGBO(254, 222,181, 1),),
                          title: state.locale.chatSupport,
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ChatSupportPage(title: "Поддержка"),));
                          },
                        );
                      }
                    ),
                    SizedBox(height: 50,),
                    GestureDetector(
                              onTap: () {
                                localeStorage.saveRefreshUserToken("");
                                tokenRepo.accessUserToken="";
                                userStore.role="guest";
                                userStore.selectedIndex=4;
                                Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage(),));
                                
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
                                  Builder(
                                    builder: (context) {
                                      final state = (context.watch<LocalizationBloc>().state as LocalizationLocaleState);
                                      return Text(
                                        " "+StringTools.firstUpperOfString(state.locale.logOut),
                                        style: TextStyle(
                                          fontFamily: "NoirPro",
                                          color: Colors.white,
                                          height: 1,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 25
                                        ),
                                      );
                                    }
                                  ),
                                
                                ],
                              ),
                            ),
                            Expanded(child: SizedBox.shrink()),
                            GestureDetector(
                              onTap: () {
                                viewDeleteAccountWarning();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                   border: Border(
                                    bottom: BorderSide(
                                      color: Color.fromRGBO(254, 222,181, 1)
                                    )
                                   )
                                ),
                                child:Builder(
                                  builder: (context) {
                                    final state = (context.watch<LocalizationBloc>().state as LocalizationLocaleState);
                                    return Text(
                                              " "+StringTools.firstUpperOfString(state.locale.deleteAccount),
                                              style: TextStyle(
                                                fontFamily: "NoirPro",
                                                color: Color.fromRGBO(254, 222,181, 1),
                                                height: 1.4,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 25
                                              ),
                                            );
                                  }
                                )
                              ),
                            ),
                            SizedBox(height: 50,)
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
          StringTools.firstUpperOfString(title),
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



class DeleteAccountWarningDialog extends StatefulWidget {
  const DeleteAccountWarningDialog({super.key});

  @override
  State<DeleteAccountWarningDialog> createState() => _DeleteAccountWarningDialogState();
}

class _DeleteAccountWarningDialogState extends State<DeleteAccountWarningDialog> {


  bool deleting=false;
  bool succesDelete=false;
  deleteAccount()async{
    if(deleting)return;
    setState(() {
      deleting=true;
      
    });
    await Future.delayed(Duration(seconds: 2));
    if(mounted){
      setState(() {
        succesDelete=true;
      });
    }
    resetData();
  }
  resetData()async{
    await Future.delayed(Duration(seconds: 2));
    await localeStorage.saveRefreshUserToken("");
    tokenRepo.accessUserToken="";
    // userStore.role="guest";
    // userStore.selectedIndex=1;
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => StartPage(),),(route) => false,);
  }
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !deleting,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color.fromARGB(170, 0, 0, 0),
            
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Center(
              child: Builder(
                builder: (context) {
                  if(succesDelete){
                    return Text(
                      StringTools.firstUpperOfString("OK"),
                      style: TextStyle(
                        color: Color.fromRGBO(254, 222,181, 1),
                        fontFamily: "NoirPro",
                        fontSize: 30,
                        height: 1,
                        fontWeight: FontWeight.w500
                      ),
                    );
                  }
                  if(deleting){
                    return CircularProgressIndicator();
                  }
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Builder(
                        builder: (context) {
                          final state = (context.watch<LocalizationBloc>().state as LocalizationLocaleState);
                          return Text(
                                    " "+StringTools.firstUpperOfString(state.locale.deleteAccountWarning),
                                    style: TextStyle(
                                      fontFamily: "NoirPro",
                                      color: Color.fromRGBO(254, 222,181, 1),
                                      height: 1,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18
                                    ),
                                  );
                        }
                      ),
                      SizedBox(height: 40,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: deleteAccount,
                            child: Container(
                              width: 120,
                              height: 40,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 93, 81, 81),
                                borderRadius: BorderRadius.circular(5)
                              ),
                              //padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Builder(
                                builder: (context) {
                                  final state = (context.watch<LocalizationBloc>().state as LocalizationLocaleState);
                                  return Text(
                                      StringTools.firstUpperOfString(state.locale.delete),
                                      style: TextStyle(
                                        color: Color.fromRGBO(254, 222,181, 1),
                                        fontFamily: "NoirPro",
                                        fontSize: 25,
                                        height: 1,
                                        fontWeight: FontWeight.w500
                                      ),
                                    );
                                }
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              width: 120,
                              height: 40,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 93, 81, 81),
                                borderRadius: BorderRadius.circular(5)
                              ),
                              //padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Builder(
                                builder: (context) {
                                  final state = (context.watch<LocalizationBloc>().state as LocalizationLocaleState);
                                  return Text(
                                      StringTools.firstUpperOfString(state.locale.cancel),
                                      style: TextStyle(
                                        color: Color.fromRGBO(254, 222,181, 1),
                                        fontFamily: "NoirPro",
                                        fontSize: 25,
                                        height: 1,
                                        fontWeight: FontWeight.w500
                                      ),
                                    );
                                }
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  );
                }
              ),
            ),
          ),
        ),
      ),
    );
  }
}
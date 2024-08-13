import 'dart:math';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gnom/core/localization/custom_localization.dart';
import 'package:gnom/core/localization/localization_bloc.dart';
import 'package:gnom/db/sql_lite.dart';
import 'package:gnom/http/guest.dart';
import 'package:gnom/http/user.dart';
import 'package:gnom/pages/language_page/language_page.dart';
import 'package:gnom/pages/main_page/main_page.dart';
import 'package:gnom/repositories/locale_storage.dart';
import 'package:gnom/repositories/token_repo.dart';
import 'package:gnom/store/user_store.dart';
import 'package:gnom/tools/phone_info.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> with TickerProviderStateMixin{

  late AnimationController _textScalecontroller;
  late AnimationController _opacityController;
  late AnimationController _gnomController;

  late Animation<double> _textScale;
  late Animation<double> _opacity;
  late Animation<double> _gnom;

  Tween<double> firstSceneAnimate=Tween<double>(begin: 0.0, end: 65.0);
  Tween<double> secondSceneAnimate=Tween<double>(begin: 60, end: 65.0);


  startOpacityAnimation(){
     _opacityController=AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
      
    );
    _opacity=Tween<double>(begin: 0,end: 1).animate(_opacityController);
    _opacityController.forward();
  }

  startGnomAnimation(){
     _gnomController=AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );
    _gnom = CurvedAnimation(
      parent: Tween<double>(begin: 0,end:1 ).animate(_gnomController),
      curve: Curves.fastOutSlowIn,
    );
    
   // _gnom=Tween<double>(begin: pi/2,end:0 ).animate(_gnomController);
    _gnomController.forward();
  }


  checkProcedure(){

  }

  startTextAnimation()async{
    _textScalecontroller = AnimationController(
      duration: const Duration(milliseconds:200 ),
      vsync: this,
    );
      _textScale = firstSceneAnimate.animate(_textScalecontroller);
      _textScalecontroller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _textScalecontroller.duration=const Duration(milliseconds:1500 );
        _textScale=secondSceneAnimate.animate(_textScalecontroller);
        _textScalecontroller.reverse();
      } 
     
    });
     await Future.delayed(const Duration(milliseconds: 1500));
      _textScalecontroller.forward();
  }


  void toLangPage(){
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LanguagePage(initial: true,),), (route) => false);
  }
  void toMainPage(){
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => MainPage(),), (route) => false);
  }

  checkLanguage()async{
    await Future.delayed(Duration(seconds: 4));
    Locale? locale =await localeStorage.appLanguage;
    await instanceDb.getPath();
    //await instanceDb.dropDatabase();
    
    await instanceDb.createDB();
    
    if(locale!=null){
      if(locale.languageCode=="ru"){
        context.read<LocalizationBloc>().add(LocalizationSetLocaleEvent(locale: RuLocale()));
      }else if(locale.languageCode=="en"){
        context.read<LocalizationBloc>().add(LocalizationSetLocaleEvent(locale: EnLocale()));
      }else if(locale.languageCode=="ar"){
        context.read<LocalizationBloc>().add(LocalizationSetLocaleEvent(locale: ArLocale()));
      }else{
        context.read<LocalizationBloc>().add(LocalizationSetLocaleEvent(locale: EnLocale()));
      }

      toMainPage();
    }else{
      toLangPage();
    }
  }



  authorizeUser()async{
    String? tokenU=await tokenRepo.refreshUserToken;
    print(tokenU);
    if(tokenU==null){
      String? tokenG=await tokenRepo.refreshGuestToken;
     print(tokenG);
      if(tokenG==null){
        String deviceId=await phoneInfo.getDeviceId();
        Tokens? tokens=await GuestHttp().auth(deviceId);
        if(tokens!=null){
          tokenRepo.accessGuestToken=tokens.access;
          await localeStorage.saveRefreshGuestToken(tokens.refresh);
          userStore.role="guest";
          checkLanguage();
        }
      }else{
        print("put refG");
        Tokens? tokens=await GuestHttp().refreshToken(tokenG);
        print(tokens);
        if(tokens==null){
          String deviceId=await phoneInfo.getDeviceId();
          tokens =await GuestHttp().auth(deviceId);
        }
        if(tokens!=null){
          tokenRepo.accessGuestToken=tokens.access;
          await localeStorage.saveRefreshGuestToken(tokens.refresh);
          userStore.role="guest";
          checkLanguage();
        }
      }
    }else{
      final tokens=await UserHttp().refreshToken(tokenU);
      if(tokens!=null){
        tokenRepo.accessUserToken=tokens.access;
        await localeStorage.saveRefreshUserToken(tokens.refresh);
        userStore.role="client";
      }else{
        await localeStorage.saveRefreshUserToken("");
        final tokenG =await localeStorage.refreshGuestToken;
        if(tokenG!=null){
          Tokens? tokens=await GuestHttp().refreshToken(tokenG);
          if(tokens==null){
            String deviceId=await phoneInfo.getDeviceId();
            tokens =await GuestHttp().auth(deviceId);
          }
          if(tokens!=null){
            tokenRepo.accessGuestToken=tokens.access;
            await localeStorage.saveRefreshGuestToken(tokens.refresh);
          }
        }else{
          String deviceId=await phoneInfo.getDeviceId();
          final tokens =await GuestHttp().auth(deviceId);
          if(tokens!=null){
            tokenRepo.accessGuestToken=tokens.access;
            await localeStorage.saveRefreshGuestToken(tokens.refresh);
            
          }
        }
        userStore.role="guest";
      }
      checkLanguage();
    }
    
  }

  @override
  void initState() {
    authorizeUser();
    startOpacityAnimation();
    startGnomAnimation();
    startTextAnimation();
    

    

    super.initState();
  }

  @override
  void dispose() {
    _textScalecontroller.dispose();
    _opacityController.dispose();
    _gnomController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: AnimatedBuilder(
        animation: _opacityController,
        builder: (context,child) {
          return Opacity(
            opacity: _opacity.value,
            child: Container(
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
                    const SizedBox(height: 80,),
                    animationText(),
                    const SizedBox(height: 30,),
                    gnomTransform()
                  ],
                ),
              ),
            ),
          );
        }
      ),
    );
  }

  Widget gnomTransform(){
    return AnimatedBuilder(
      animation: _gnomController,
      builder: (context,_) {
        return Transform.rotate(
          angle: pi/2-(_gnom.value*pi/2),
          
          child: Transform.scale(
            scale: _gnom.value,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                 SizedBox(
                    height: 250,
                    width: 250,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 254, 254),
                        borderRadius: BorderRadius.circular(125)
                      ),
                    ),
                  ),
                
                Image.asset("assets/png/gnome_sticker.png",height: 282,)
              ],
            ),
          ),
        );
      }
    );
  }

  Widget animationText(){
    return AnimatedBuilder(
      animation: _textScalecontroller, 
      builder: (context, child) {
        return  SizedBox(
          height: 130,
          child: Text(
            "GNOM\nHELPER",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: _textScale.value,
              fontWeight: FontWeight.w800,
              fontFamily: "NoirPro",
              height: 0.9,
              color: const Color.fromRGBO(254, 222,181, 1)
              ),
          ),
        );
      },
    );
  }


}
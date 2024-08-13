import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';

class LocaleStorage{
  Future<String?> get refreshGuestToken async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token= prefs.getString("g_refresh_token");
    return token==""?null:token;
  }
  Future<String?> get refreshUserToken async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token= prefs.getString("u_refresh_token");
    return token==""?null:token;
  }
  Future<void> saveRefreshGuestToken(String token)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("g_refresh_token", token);
  }
  Future<void> saveRefreshUserToken(String token)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("u_refresh_token", token);
  }
  Future<Locale?> get appLanguage async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token= prefs.getString("app_lang");
    if(token==null){
      return null;
    }
    final langInfo = token.split("_");
    if(langInfo.length<2){
      return null;
    }
    return Locale(langInfo[0],langInfo[1]);
  }
  Future<void> saveAppLanguage(String lang)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("app_lang", lang);
  }
}

final localeStorage= LocaleStorage();
import 'dart:ui';

class AppLocalization{
  static const Locale ruLocale = Locale("ru","RU");
  static const Locale enLocale = Locale("en","US");
  static  String getLocaleName(Locale locale){
        if(locale.countryCode==ruLocale.countryCode&&locale.scriptCode==ruLocale.scriptCode){
          return "РУССКИЙ";
        }
        if(locale.countryCode==enLocale.countryCode&&locale.scriptCode==enLocale.scriptCode){
          return "ENGLISH";
        }
        return "ENGLISH";
  } 
  static  String getLocaleDescription(Locale locale){
        if(locale.countryCode==ruLocale.countryCode&&locale.scriptCode==ruLocale.scriptCode){
          return "ВЫБЕРИТЕ\nСВОЙ ЯЗЫК";
        }
        if(locale.countryCode==enLocale.countryCode&&locale.scriptCode==enLocale.scriptCode){
          return "CHOOSE YOUR\nLANGUAGE";
        }
        return "CHOOSE YOUR\nLANGUAGE";
  }
  static  String getLocaleButtonStart(Locale locale){
        if(locale.countryCode==ruLocale.countryCode&&locale.scriptCode==ruLocale.scriptCode){
          return "СТАРТ";
        }
        if(locale.countryCode==enLocale.countryCode&&locale.scriptCode==enLocale.scriptCode){
          return "START";
        }
        return "CHOOSE YOUR\nLANGUAGE";
  }
  static List<Locale>listlocations=[ruLocale,enLocale];
  static int localeCount() => AppLocalization.listlocations.length;
  static const String translationsPath = 'assets/translations';

}
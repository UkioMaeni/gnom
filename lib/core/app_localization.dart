import 'dart:ui';

class AppLocalization{
  static const Locale ruLocale = Locale("ru","RU");
  static const Locale enLocale = Locale("en","US");
  static const Locale arLocale = Locale("ar","AA");
  static Locale currentLocale = Locale("en","US");
  static  String getLocaleName(Locale locale){
        if(locale.countryCode==ruLocale.countryCode&&locale.scriptCode==ruLocale.scriptCode){
          return "РУССКИЙ";
        }
        if(locale.countryCode==enLocale.countryCode&&locale.scriptCode==enLocale.scriptCode){
          return "ENGLISH";
        }
        if(locale.countryCode==arLocale.countryCode&&locale.scriptCode==arLocale.scriptCode){
          return "AA";
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
        if(locale.countryCode==arLocale.countryCode&&locale.scriptCode==arLocale.scriptCode){
          return "AA\n";
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
        if(locale.countryCode==arLocale.countryCode&&locale.scriptCode==arLocale.scriptCode){
          return "AASTART";
        }
        return "CHOOSE YOUR\nLANGUAGE";
  }
  static List<Locale>listlocations=[ruLocale,enLocale,arLocale];
  static int localeCount() => AppLocalization.listlocations.length;
  static const String translationsPath = 'assets/translations';

}
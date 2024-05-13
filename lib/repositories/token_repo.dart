import 'package:gnom/repositories/locale_storage.dart';

class TokenRepo{
    String _accessGuestToken='';
    String get accessGuestToken=>_accessGuestToken;
    set accessGuestToken(String value){
      _accessGuestToken=value;
    }
    String _accessUserToken='';
    String get accessUserToken=>_accessUserToken;
    set accessUserToken(String value){
      _accessUserToken=value;
    }
    Future<String?> get refreshGuestToken async{
      String? token=await localeStorage.refreshGuestToken;
      return token;
    }
    Future<String?> get refreshUserToken async{
      String? token=await localeStorage.refreshUserToken;
      return token;
    }
}

final  tokenRepo=TokenRepo();
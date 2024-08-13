import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:gnom/config/http_config.dart';
import 'package:gnom/http/guest.dart';
import 'package:gnom/http/interceptor.dart';
import 'package:gnom/store/user_store.dart';

class FCMHttp{
  Dio dio=Dio();
  FCMHttp(){
    dio.interceptors.add(AuthInterceptor(dio));
  }          
  Future<int> setFcmToken(String fcm)async{
    try {
      Response response=await dio.post(
        "${httpConfig.baseUrl}/set_token",
        data: { 
          "token":fcm
        }
      );
      final data=response.data;
      
      print(data);
      return 0;
    } catch (e) {
      print(e);
      return -1;
    }
  }  
  

}




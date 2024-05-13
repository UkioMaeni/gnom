import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:gnom/config/http_config.dart';
import 'package:gnom/http/interceptor.dart';
import 'package:gnom/store/user_store.dart';

class GuestHttp{
  Dio dio=Dio();
  GuestHttp(){
    dio.interceptors.add(AuthInterceptor(dio));
  }            

  Future request(FormData formData)async{
    try {
      Response response=await dio.post(
        "${httpConfig.baseUrl}/guest/request",
        data: formData
      );
      final data=response.data;
      
      print(data);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<RequestsCount?> getRequestsCount()async{
    try {
      Response response=await dio.get(
        "${httpConfig.baseUrl}/guest/requests_info",
      );
      final data=response.data;
      RequestsCount requestsCount=RequestsCount(essay: data["essay"], math: data["math"], paraphrase: data["paraphrase"], presentation: data["presentation"], reduction: data["reduction"], referre: data["referre"]);
      print(response);
      return requestsCount;
    } catch (e) {
      print(e);
      return null;
    }
  }
  Future<Tokens?> auth(String deviceId)async{
    try {
      Response response=await dio.post(
        "${httpConfig.baseUrl}/guest/auth",
        data: {
          "deviceId":deviceId
        }
      );
      final data=response.data;
      print(response);
      return Tokens(access: data["accessToken"],refresh: data["refreshToken"]);
    } catch (e) {
      print(e);
      return null;
    }
  }
  Future<Tokens?> refreshToken(String token)async{
    try {
      Response response=await dio.put(
        "${httpConfig.baseUrl}/guest/refresh",
        data: {
          "token":token
        }
      );
      final data=response.data;
      print(response);
      return Tokens(access: data["accessToken"],refresh: data["refreshToken"]);
    } catch (e) {
      print(e);
      return null;
    }
  }
}



class Tokens{
  String access;
  String refresh;
  Tokens({
    required this.access,
    required this.refresh
  });
}
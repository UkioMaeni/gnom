import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:gnom/config/http_config.dart';
import 'package:gnom/http/guest.dart';
import 'package:gnom/http/interceptor.dart';
import 'package:gnom/pages/chat_page/store/chat_store.dart';
import 'package:gnom/store/user_store.dart';

class SubjectsHttp{
  Dio dio=Dio();
  SubjectsHttp(){
    dio.interceptors.add(AuthInterceptor(dio));
  }          

  Future<SubjectRequestInfo?> sendRequest(FormData formData)async{
    try {
      Response response=await dio.post(
        "${httpConfig.baseUrl}/subject",
        data: formData
      );
      final data=response.data;
      
      print(data);
      if(data!=null){
        SubjectRequestInfo info=SubjectRequestInfo(messageId: "", result: "", long: false);
        if(data["result"]==null){
          info.long=true;
        }else{
          info.result=data["result"];
        }
        if(data["messageId"]!=null){
          info.messageId=data["messageId"];
        }
        return info;
      }

      
      
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }
  Future sendOtp(String email)async{
    try {
      Response response=await dio.post(
        "${httpConfig.baseUrl}/user/otp",
        data: {
          "email":email
        }
      );
      final data=response.data;
      
      print(data);
    } catch (e) {
      print(e);
      return null;
    }
  }
  Future<Tokens?> verifyOtp(String email,String otp)async{
    try {
      Response response=await dio.post(
        "${httpConfig.baseUrl}/user/verifyotp",
        data: {
          "email":email,
          "otp":otp
        }
      );
      final data=response.data;
      print(data);
      return Tokens(access: data["accessToken"],refresh: data["refreshToken"]);
      
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<RequestsCount?> getRequestsCount()async{
    try {
      Response response=await dio.get(
        "${httpConfig.baseUrl}/user/requests_info",
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

}

class Profile{
  int id;
  String login;
  String nickname;
  Profile({
    required this.id,
    required this.login,
    required this.nickname
  });
}


class SubjectRequestInfo{
  String result;
  String messageId;
  bool long;
  SubjectRequestInfo({
    required this.messageId,
    required this.result,
    required this.long
  });
}

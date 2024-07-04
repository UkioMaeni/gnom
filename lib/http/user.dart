import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:gnom/config/http_config.dart';
import 'package:gnom/http/guest.dart';
import 'package:gnom/http/interceptor.dart';
import 'package:gnom/pages/chat_page/store/chat_store.dart';
import 'package:gnom/store/user_store.dart';
import 'package:uuid/uuid.dart';

class UserHttp{
  Dio dio=Dio();
  UserHttp(){
    dio.interceptors.add(AuthInterceptor(dio));
  }     
  Future<List<SubjectTypedMessage>> checkUnreadMessages()async{
    try {
      Response response=await dio.get(
        "${httpConfig.baseUrl}/user/unread_messages",
      );
      List<dynamic> data=response.data;
      print(data);
      String id()=> Uuid().v4();
      List<String> lastMessagesId=data.map<String>((e) => e["message_id"]??"none").toList();
      //chatStore.updateStatusHistory(lastMessagesId);
      print(lastMessagesId);
      return data.map((element)=>SubjectTypedMessage(message: Message(id: id(), status: "", text: "",link: element["text"], sender: "bot", fileBuffer: null),subjectType: element["subject_type"])).toList();
      
      
    } catch (e) {
      print(e);
      return [];
    }
  }       
  Future<Profile?> profile()async{
    try {
      Response response=await dio.post(
        "${httpConfig.baseUrl}/user/profile",
      );
      final data=response.data;
      
      print(data);
      return Profile(id: data["id"],login: data["login"],nickname: data["nickname"]);
    } catch (e) {
      print(e);
      return null;
    }
  }  
  Future<Profile?> findUser(String login)async{
    try {
      Response response=await dio.get(
        "${httpConfig.baseUrl}/user/find",
        queryParameters: {
          "login":login
        }
      );
      final data=response.data;
      print(response.data);
      if(data is String){
        return null;
      }
      
      return Profile(id: data["id"],login: data["login"],nickname: data["nickname"]);
    } catch (e) {
      print(e);
      return null;
    }
  } 
  Future<Tokens?> refreshToken(String token)async{
    try {
      Response response=await dio.put(
        "${httpConfig.baseUrl}/user/refresh",
        data: {
          "token":token
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



import 'package:dio/dio.dart';
import 'package:gnom/repositories/token_repo.dart';
import 'package:gnom/store/user_store.dart';


class ErrorTypeTimeout{

}

enum ErrorTypeTimeoutEnum{
  timeout,
}


class AuthInterceptor extends Interceptor {
  int repeatCounter = 0;
  late Dio dio;
  AuthInterceptor(Dio _dio){
    dio=_dio;
  }
  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    
    if(err.error==DioExceptionType.sendTimeout){
      return ErrorTypeTimeout();
    }


    // if (err.response?.statusCode == 401&&repeatCounter.isEven) {
    //   repeatCounter++;
    //   return  await dio.request(
    //       err.requestOptions.path, 
    //       data:  err.requestOptions.data,
    //       queryParameters: err.requestOptions.queryParameters,
    //       options: Options(method:  err.requestOptions.method),
         
    //       );  
    // }
    repeatCounter=0;
    if (err.response?.statusCode == 400) {


      
    }
    if (err.response?.statusCode == 409) {
        print(err.response?.data);
      DioException newErr=err;
      newErr.message!="409";
      handler.next(newErr);
    }
    if (err.response?.statusCode == 500) {
        print(err.requestOptions.path);
        print(err.response?.data);

      
    }
    
    handler.next(err);
    
    
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async{
    String token="";
    //print(options.queryParameters);
    if(userStore.role=='client'){
      token=  tokenRepo.accessUserToken;
    }else if(userStore.role=='guest'){
      token=  tokenRepo.accessGuestToken;
    }
   options.headers.addEntries({
    MapEntry("Authorization",token)
   });
   //print("HV"+options.headers["version"]);
    handler.next(options);
  }
}
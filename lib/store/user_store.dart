import 'dart:typed_data';
import 'package:gnom/http/guest.dart';
import 'package:gnom/http/user.dart';
import 'package:mobx/mobx.dart';

part 'user_store.g.dart';



class UserStore = _UserStore with _$UserStore;

abstract class _UserStore with Store {

  ///[_role] - основная роль 
  /// types: "guest","client","imposter"
  @observable
  String _role="guest";
  String get role=>_role;
  set role(String value){
    _role=value;
  }
  @observable
  RequestsCount? requestsCount; 
  @action
  Future<void>getUserDataInfo()async{
    
  }
  @action
  Future<void>getGuestInfo()async{
    
  }
  @action
  Future<void>getRequestsCount()async{
    if(_role=="guest"){
      final result=await GuestHttp().getRequestsCount();
      if(result!=null){
        requestsCount=result;
      }
    }else if(_role=="client"){
      final result=await UserHttp().getRequestsCount();
      if(result!=null){
        requestsCount=result;
      }
    }
  }

  @observable
  Profile? profile=null;

  @action
  void requiredData(){
    if(_role=="guest"){

    }else if(_role=="client"){
      requairedUserData();
    }
  }

  @action
  Future<void> requairedUserData()async{
    final result=await UserHttp().profile();
    if(result!=null){
      profile=result;
    }
  }
  
}

UserStore userStore = UserStore();

class RequestsCount{
  int math;
  int referre;
  int essay;
  int presentation;
  int reduction;
  int paraphrase;
  RequestsCount({
    required this.essay,
    required this.math,
    required this.paraphrase,
    required this.presentation,
    required this.reduction,
    required this.referre
  });

  get summary => math+referre+essay+presentation+reduction+paraphrase;

  int get maxValue{
    int max=math;
    if(referre>max){
      max=referre;
    }else if(essay>max){
      max=essay;
    }else if(presentation>max){
      max=presentation;
    }else if(reduction>max){
      max=reduction;
    }else if(paraphrase>max){
      max=paraphrase;
    }
    return max;
  }

}
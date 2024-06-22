import 'dart:developer';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gnom/db/sql_lite.dart';
import 'package:gnom/http/subjects.dart';
import 'package:gnom/http/user.dart';
import 'package:gnom/pages/chat_page/chat_page.dart';
import 'package:gnom/pages/main_page/tabs/history_tab.dart';
import 'package:gnom/pages/push/push_page.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:uuid/uuid.dart';

part 'chat_store.g.dart';



class ChatStore = _ChatStore with _$ChatStore;

abstract class _ChatStore with Store {

  @observable
  ObservableMap<String,List<Message>> chats=ObservableMap<String,List<Message>>.of({
    EChatPageType.math.name:[],
    EChatPageType.referat.name:[],
    EChatPageType.essay.name:[],
    EChatPageType.presentation.name:[],
    EChatPageType.reduce.name:[],
    EChatPageType.parafrase.name:[],
    EChatPageType.sovet.name:[],
  });
  @observable
  ObservableMap<String,RequiredRequest> requiredComplete=ObservableMap<String,RequiredRequest>.of({
    EChatPageType.math.name:RequiredRequest(required: false,message: null),
    EChatPageType.referat.name:RequiredRequest(required: false,message: null),
    EChatPageType.essay.name:RequiredRequest(required: false,message: null),
    EChatPageType.presentation.name:RequiredRequest(required: false,message: null),
    EChatPageType.reduce.name:RequiredRequest(required: false,message: null),
    EChatPageType.parafrase.name:RequiredRequest(required: false,message: null),
    EChatPageType.sovet.name:RequiredRequest(required: false,message: null),
  });
  
  @action
  addMessage(EChatPageType chatType,String message,XFile? file)async{

    final messageId=Uuid().v4();

    if(message.toLowerCase()=="да"||message.toLowerCase()=="нет"){
      final mess=Message(id: messageId,status: "send",text: message,sender: "people",fileBuffer: null);
      chats[chatType.name]!.add(mess);
      instanceDb.addMessage(SubjectTypedMessage(message: mess, subjectType: chatType.name));
      print(requiredComplete[chatType.name]);
      if(requiredComplete[chatType.name]!.required){
        if(message.toLowerCase()=="да"){ 
          FormData formData=FormData();

            formData.fields.add(MapEntry("type", chatType.name));
            formData.fields.add(MapEntry("text", requiredComplete[chatType.name]!.message!.text));
             formData.fields.add(MapEntry("messageId", requiredComplete[chatType.name]!.message!.id));
            if(requiredComplete[chatType.name]!.message!.fileBuffer!=null){
              String? name=requiredComplete[chatType.name]!.message!.name;
              formData.files.add(MapEntry("file", MultipartFile.fromBytes(requiredComplete[chatType.name]!.message!.fileBuffer!,filename: name??"file.png", )));
            }
            final messBot=Message(id: messageId,status: "send",text: "Запрос отправлен, ожидайте",sender: "bot",fileBuffer: null);
            chats[chatType.name]!.add(messBot);
            instanceDb.addMessage(SubjectTypedMessage(message: messBot, subjectType: chatType.name));
            history.add(HistoryModel(icon: SizedBox.shrink(),progress: "process",theme: requiredComplete[chatType.name]!.message!.text,type: "math",favorite: false,messageId:requiredComplete[chatType.name]!.message!.id));
            history=ObservableList.of(history);
            chats=ObservableMap.of(chats);
            final result= await SubjectsHttp().sendRequest(formData);
            if(result!=null){  
              if(result.isEmpty){
                final messBot=Message(id: messageId,status: "send",text: "Запрос требует временени на обработку.следите за уведомлениями",sender: "bot",fileBuffer: null);
                chats[chatType.name]!.add(messBot);
                instanceDb.addMessage(SubjectTypedMessage(message: messBot, subjectType: chatType.name));
              }else{
                final messBot=Message(id: messageId,status: "send",text:"Ответ:\n"+ result,sender: "bot",fileBuffer: null);
                chats[chatType.name]!.add(messBot);
                instanceDb.addMessage(SubjectTypedMessage(message: messBot, subjectType: chatType.name));
              }
              chats=ObservableMap.of(chats);
              
            }else{
              final messBot=Message(id: messageId,status: "send",text: "Произошла ошибка",sender: "bot",fileBuffer: null);
              chats[chatType.name]!.add(messBot);
              instanceDb.addMessage(SubjectTypedMessage(message: messBot, subjectType: chatType.name));
              chats=ObservableMap.of(chats);
            }
            
            
            requiredComplete[chatType.name]!.required=false;
            requiredComplete[chatType.name]!.message=null; 
        }else{
          final messBot=Message(id: messageId,status: "send",text: "Запрос отменен",sender: "bot",fileBuffer: null);
          chats[chatType.name]!.add(messBot);
          instanceDb.addMessage(SubjectTypedMessage(message: messBot, subjectType: chatType.name));
          requiredComplete[chatType.name]!.required=false;
          requiredComplete[chatType.name]!.message=null;
        }
      }else{
        final messBot=Message(id: messageId,status: "send",text: "Задайте сначала вопрос",sender: "bot",fileBuffer: null);
        chats[chatType.name]!.add(messBot);
        instanceDb.addMessage(SubjectTypedMessage(message: messBot, subjectType: chatType.name));
      }
    }else{
      if(file!=null){
        inspect(file);
          final mess=Message(id: messageId,status: "send",text: message,sender: "people",fileBuffer:await file.readAsBytes(),name:file.name);
          chats[chatType.name]!.add(mess);
          instanceDb.addMessage(SubjectTypedMessage(message: mess, subjectType: chatType.name));
          final messBot=Message(id: messageId,status: "send",text: "Вы действительно хотите отправить данную картинку?",sender: "bot",fileBuffer: null);
          chats[chatType.name]!.add(messBot);
          instanceDb.addMessage(SubjectTypedMessage(message: messBot, subjectType: chatType.name));
          requiredComplete[chatType.name]!.message=mess;
      }else{
          final mess=Message(id: messageId,status: "send",text: message,sender: "people",fileBuffer: null);
          chats[chatType.name]!.add(mess);
          instanceDb.addMessage(SubjectTypedMessage(message: mess, subjectType: chatType.name));
          final messBot=Message(id: messageId,status: "send",text: "Вы действительно хотите запросить \"${message}\"?",sender: "bot",fileBuffer: null);
          chats[chatType.name]!.add(messBot);
          instanceDb.addMessage(SubjectTypedMessage(message: messBot, subjectType: chatType.name));
          requiredComplete[chatType.name]!.message=mess;
      }
      requiredComplete[chatType.name]!.required=true; 
    }
    chats=ObservableMap.of(chats);
    requiredComplete=ObservableMap.of(requiredComplete);
  }

  void checkUnread()async{
    final result=await UserHttp().checkUnreadMessages();
    
    if(result.isNotEmpty){
      for(var element in result){
        chats[element.subjectType]!.add(element.message);
        instanceDb.addMessage(element);
      }
    }
    chats=ObservableMap.of(chats);
  }
  @action
  addMessageFromDb()async{
   final mess=await instanceDb.getMessages();
   for(var element in mess){
    chats[element.subjectType]!.add(element.message);
    pushs.add(PushModel(icon: SizedBox.shrink(),sub: PushModel.titleFromType(element.subjectType),subjectType: element.subjectType, title: "Файл готов к скачиванию"));
    
   }
   pushs=ObservableList.of(pushs);
   chats=ObservableMap.of(chats);
  }

  addMessageFromNotify(String messageType){
    if(messageType=="unread"){
      return checkUnread();
    }
  
    // final messageId=Uuid().v4();
    // if(text.contains("downloads")){
    //    final messBot=Message(id: messageId,status: "file",text:"Ответ:\n Файл",sender: "bot",fileBuffer: null,link:text);
    //   chats[chatType]!.add(messBot);
    // }else{
    //   final messBot=Message(id: messageId,status: "send",text:"Ответ:\n"+ text,sender: "bot",fileBuffer: null);
    //   chats[chatType]!.add(messBot);
    // }
    
    // chats=ObservableMap.of(chats);
  }
  @action
  Future<bool> updateStatusForDownloadFile(String id,String pathFile,String type) async{
    var t= chats[type];
    t!.forEach((element) { 
      print(element.text+element.id);
    });
    print(id);
   bool result= await instanceDb.updateStatusForDownloadFile(id,pathFile);
  if(result){
    int index= chats[type]!.indexWhere((element) => element.id==id);
    if(index!=-1){
      chats[type]![index].text="file";
      chats[type]![index].link=pathFile;
    }
    //print(chats[type]![index].text);
    chats=ObservableMap.of(chats);
  }
   return result;
  }

  //push
  @observable
  ObservableList<PushModel> pushs=ObservableList<PushModel>.of([
    PushModel(icon: SizedBox.shrink(),sub: "Сообщение от поддержки",title: "НАЖМИТЕ ЧТОБ ПРОЧИТАТЬ",subjectType: "sup")
  ]);
  @observable
  ObservableList<HistoryModel> history=ObservableList<HistoryModel>.of([
    
  ]);

  @action
  updateStatusHistory(List<String> ids){
    for(var id in ids){
      history.firstWhere((element) => element.messageId==id).progress="completed";
    }
    
    history=ObservableList.of(history);
  }

  getPush(){

  }
}

ChatStore chatStore = ChatStore();




class Message{
  String id;
  String text;
  String status;
  String sender;
  Uint8List? fileBuffer;
  String? name;
  String? link;
  Message({
    required this.id,
    required this.status,
    required this.text,
    required this.sender,
    required this.fileBuffer,
    this.name,
    this.link
  });

  Map<String,dynamic> toMap(){
    return {
      "id":id,
      "text":text,
      "status":status,
      "sender":sender,
      "name":name,
      "link":link,
      "fileBuffer":fileBuffer
    };
  }
}

class SubjectTypedMessage{
  String subjectType;
  Message message;
  
  SubjectTypedMessage({
    required this.message,
    required this.subjectType
  });
  toMap(){
    final messageMap= message.toMap();
    final Map<String,dynamic> local={"type":subjectType};
    messageMap.addAll(local);
    return messageMap;
  }
}


class RequiredRequest{
  bool required;
  Message? message;
  RequiredRequest({
    required this.required,
    required this.message
  });
}

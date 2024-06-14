import 'dart:developer';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:gnom/http/subjects.dart';
import 'package:gnom/http/user.dart';
import 'package:gnom/pages/chat_page/chat_page.dart';
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
      print(requiredComplete[chatType.name]);
      if(requiredComplete[chatType.name]!.required){
        if(message.toLowerCase()=="да"){ 
          FormData formData=FormData();

            formData.fields.add(MapEntry("type", chatType.name));
            formData.fields.add(MapEntry("text", requiredComplete[chatType.name]!.message!.text));
            if(requiredComplete[chatType.name]!.message!.fileBuffer!=null){
              String? name=requiredComplete[chatType.name]!.message!.name;
              formData.files.add(MapEntry("file", MultipartFile.fromBytes(requiredComplete[chatType.name]!.message!.fileBuffer!,filename: name??"file.png", )));
            }
            final messBot=Message(id: messageId,status: "send",text: "Запрос отправлен, ожидайте",sender: "bot",fileBuffer: null);
            chats[chatType.name]!.add(messBot);
            chats=ObservableMap.of(chats);
            final result= await SubjectsHttp().sendRequest(formData);
            if(result!=null){  
              if(result.isEmpty){
                final messBot=Message(id: messageId,status: "send",text: "Запрос требует временени на обработку.следите за уведомлениями",sender: "bot",fileBuffer: null);
                chats[chatType.name]!.add(messBot);
              }else{
                final messBot=Message(id: messageId,status: "send",text:"Ответ:\n"+ result,sender: "bot",fileBuffer: null);
                chats[chatType.name]!.add(messBot);
              }
              chats=ObservableMap.of(chats);
              
            }else{
              final messBot=Message(id: messageId,status: "send",text: "Произошла ошибка",sender: "bot",fileBuffer: null);
              chats[chatType.name]!.add(messBot);
              chats=ObservableMap.of(chats);
            }
            
            
            requiredComplete[chatType.name]!.required=false;
            requiredComplete[chatType.name]!.message=null; 
        }else{
          final messBot=Message(id: messageId,status: "send",text: "Запрос отменен",sender: "bot",fileBuffer: null);
          chats[chatType.name]!.add(messBot);
          requiredComplete[chatType.name]!.required=false;
          requiredComplete[chatType.name]!.message=null;
        }
      }else{
        final messBot=Message(id: messageId,status: "send",text: "Задайте сначала вопрос",sender: "bot",fileBuffer: null);
        chats[chatType.name]!.add(messBot);
      }
    }else{
      if(file!=null){
        inspect(file);
          final mess=Message(id: messageId,status: "send",text: message,sender: "people",fileBuffer:await file.readAsBytes(),name:file.name);
          chats[chatType.name]!.add(mess);
          final messBot=Message(id: messageId,status: "send",text: "Вы действительно хотите отправить данную картинку?",sender: "bot",fileBuffer: null);
          chats[chatType.name]!.add(messBot);
          requiredComplete[chatType.name]!.message=mess;
      }else{
          final mess=Message(id: messageId,status: "send",text: message,sender: "people",fileBuffer: null);
          chats[chatType.name]!.add(mess);
          final messBot=Message(id: messageId,status: "send",text: "Вы действительно хотите запросить \"${message}\"?",sender: "bot",fileBuffer: null);
          chats[chatType.name]!.add(messBot);
          requiredComplete[chatType.name]!.message=mess;
      }
      requiredComplete[chatType.name]!.required=true; 
    }
    chats=ObservableMap.of(chats);
    requiredComplete=ObservableMap.of(requiredComplete);
  }

  void checkUnread(){
    final result= UserHttp().checkUnreadMessages();
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
}

class RequiredRequest{
  bool required;
  Message? message;
  RequiredRequest({
    required this.required,
    required this.message
  });
}

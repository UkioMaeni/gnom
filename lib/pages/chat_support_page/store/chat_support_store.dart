import 'dart:developer';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gnom/db/sql_lite.dart';
import 'package:gnom/http/subjects.dart';
import 'package:gnom/http/user.dart';
import 'package:gnom/pages/chat_page/chat_page.dart';
import 'package:gnom/pages/chat_page/store/chat_store.dart';
import 'package:gnom/pages/main_page/tabs/history_tab/history_tab.dart';
import 'package:gnom/pages/push/push_page.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:uuid/uuid.dart';

part 'chat_support_store.g.dart';



class ChatStore = _ChatStore with _$ChatStore;

abstract class _ChatStore with Store {

  @observable
  ObservableList<Message> chats=ObservableList<Message>.of([]);
  
  @action
  addMessage(String message,XFile? file)async{

    final messageId=Uuid().v4();
    final mess=Message(id: messageId,status: "send",text: message,sender: "people",fileBuffer:await file?.readAsBytes(),name:file?.name);
    chats.add(mess);
    chats=ObservableList.of(chats);
    
  }

  void checkUnread()async{
    // final result=await UserHttp().checkUnreadMessages();
    
    // if(result.isNotEmpty){
    //   for(var element in result){
    //     print(element.message.id);
    //     print("////");
    //     chats.add(element.message);
    //     for(var h in history){
    //       if(h.messageId==element.message.id){
    //         h.progress="completed";
    //         print(h.messageId);
    //       }
    //     }
    //     history=ObservableList.of(history);
    //     instanceDb.addMessage(element);
    //   }
    // }
    // chats=ObservableList.of(chats);
  }

  // @action
  // addMessageFromDb()async{
  //  final mess=await instanceDb.getMessages();
  //  for(var element in mess){
  //   chats[element.subjectType]!.add(element.message);
  //   pushs.add(PushModel(icon: SizedBox.shrink(),sub: PushModel.titleFromType(element.subjectType),subjectType: element.subjectType, title: "Файл готов к скачиванию"));
    
  //  }
  //  pushs=ObservableList.of(pushs);
  //  chats=ObservableMap.of(chats);
  // }

  addMessageFromNotify(String messageType){
    if(messageType=="unread"){
      return checkUnread();
    }
  }
}

ChatStore chatSupportStore = ChatStore();







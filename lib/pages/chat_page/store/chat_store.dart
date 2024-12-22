import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gnom/core/localization/localization_bloc.dart';
import 'package:gnom/db/sql_lite.dart';
import 'package:gnom/http/subjects.dart';
import 'package:gnom/http/user.dart';
import 'package:gnom/pages/chat_page/chat_page.dart';
import 'package:gnom/pages/main_page/tabs/history_tab/history_tab.dart';
import 'package:gnom/pages/push/push_page.dart';
import 'package:image_picker/image_picker.dart';
import 'package:media_storage/media_storage.dart';
import 'package:mobx/mobx.dart';
import 'package:path_provider/path_provider.dart';
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
    EChatPageType.generation.name:[],
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
    EChatPageType.generation.name:RequiredRequest(required: false,message: null),
  });
  
  @action
  addMessage(EChatPageType chatType,String message,XFile? file,BuildContext context)async{

    final messageId=Uuid().v4();
    final state = (context.read<LocalizationBloc>().state as LocalizationLocaleState);
    if(message.toLowerCase()=="да"||message.toLowerCase()=="yes"||message.toLowerCase()=="нет"||message.toLowerCase()=="no"){
      final mess=Message(id: messageId,status: "send",text: message,sender: "people",fileBuffer: null);
      chats[chatType.name]!.add(mess);
      instanceDb.addMessage(SubjectTypedMessage(message: mess, subjectType: chatType.name));
      print(requiredComplete[chatType.name]);
      if(requiredComplete[chatType.name]!.required){
        if(message.toLowerCase()=="да"||message.toLowerCase()=="yes"){ 
          FormData formData=FormData();

            formData.fields.add(MapEntry("type", chatType.name));
            formData.fields.add(MapEntry("text", requiredComplete[chatType.name]!.message!.text));
             formData.fields.add(MapEntry("messageId", requiredComplete[chatType.name]!.message!.id));
            if(requiredComplete[chatType.name]!.message!.fileBuffer!=null){
              String? name=requiredComplete[chatType.name]!.message!.name;
              formData.files.add(MapEntry("file", MultipartFile.fromBytes(requiredComplete[chatType.name]!.message!.fileBuffer!,filename: name??"file.png", )));
            }
            
            final messBot=Message(id: messageId,status: "send",text: state.locale.promptIsSent,sender: "bot",fileBuffer: null);
            chats[chatType.name]!.add(messBot);
            
            instanceDb.addMessage(SubjectTypedMessage(message: messBot, subjectType: chatType.name));
            //history.add(HistoryModel(fileBuffer: requiredComplete[chatType.name]!.message!.fileBuffer, icon: SizedBox.shrink(),progress: "process",theme: requiredComplete[chatType.name]!.message!.text,type:chatType.name ,favorite: false,messageId:requiredComplete[chatType.name]!.message!.id,answer: "",answerMessageId: "",));
            history=ObservableList.of(history);
            chats=ObservableMap.of(chats);
            requiredComplete[chatType.name]!.required=false;
            requiredComplete=ObservableMap.of(requiredComplete);
            final result= await SubjectsHttp().sendRequest(formData);
            final messageBotId=Uuid().v4();
            if(result!=null){  
              if(result.long==true){
                final messBot=Message(id: messageBotId,status: "send",text:state.locale.theQueryRequiresTime,sender: "bot",fileBuffer: null);
                chats[chatType.name]!.add(messBot);
                instanceDb.addMessage(SubjectTypedMessage(message: messBot, subjectType: chatType.name));
              }else{
                if(result.result.contains("http")){
                  final response=await Dio().get(
                         result.result,
                         options: Options(responseType: ResponseType.bytes)
                      );
                      print(response.data);
                      print(response.headers["content-type"]);
                      String fileExchange=response.headers["content-type"]?[0].replaceAll("image/", "")??"none";
                      var path = await MediaStorage.getExternalStorageDirectories();
                      String directoryPath=path[0]+'/Android/media/com.gnom.helper';
                      final deviceInfo = await DeviceInfoPlugin().androidInfo;
                      final version = deviceInfo.version.sdkInt;
                      if(version<=32){
                        directoryPath=path[0]+'/Android/data/com.gnom.helper';
                      }
                      
                      final gnomDirectory = Directory(directoryPath);
                      if(!gnomDirectory.existsSync()){
                      gnomDirectory.create();
                    }
                      final file = File(gnomDirectory.path+"/${result.messageId}.${fileExchange}");
                      
                      file.writeAsBytesSync(response.data);
                      //chatStore.updateStatusForDownloadFile(widget.message.id, gnomDirectory.path+"/${id}.${fileExchange}",widget.type);
                      final messBot=Message(id: messageBotId,status: "send",text:"@",sender: "bot",fileBuffer: response.data,link:gnomDirectory.path+"/${result.messageId}.${fileExchange}" );
                      updateStatusHistory(result.messageId,result.result,messageBotId);
                      chats[chatType.name]!.add(messBot);
                      instanceDb.addMessage(SubjectTypedMessage(message: messBot, subjectType: chatType.name));
                }else{
                   final messBot=Message(id: messageBotId,status: "send",text:"Ответ:\n"+ result.result,sender: "bot",fileBuffer: null);
                   updateStatusHistory(result.messageId,result.result,messageBotId);
                    chats[chatType.name]!.add(messBot);
                    instanceDb.addMessage(SubjectTypedMessage(message: messBot, subjectType: chatType.name));
                }
                
                
                
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
          String text=state.locale.areYouSure;
          if(state.locale.language=="ar"){
            text="؟\"${message}\" "+text;
          }else{
            text=text+" \"${message}\"?";
          }
          final messBot=Message(id: messageId,status: "send",text: text,sender: "bot",fileBuffer: null);
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
        print(element.message.id);
        print("////");
        //chats[element.subjectType]!.add(element.message);
        for(var h in history){
          print(h.messageId);
          if(h.messageId==element.message.id){
            h.progress="completed";
            h.answer=element.message.link!;
            await instanceDb.updateHistoryAnswer(element.message.id,element.message.link!);
            await instanceDb.updateHistoryProgress(element.message.id);
            print(h.messageId);
          }
        }
        history=ObservableList.of(history);
        //instanceDb.addMessage(element);
      }
    }
    chats=ObservableMap.of(chats);
  }

  @action
  Future<void> updateHistoryAsDocument(String messageId,String path,String documentType)async{
      List<HistoryModel> find = history.where((element) => element.messageId==messageId,).toList();
      for (var element in find) {
        element.answer=documentType;
        element.AisDocument=true;
        element.Apath=path;
        await instanceDb.updateHistoryAnswerInDocument(element.messageId,path,documentType);
      }
      
      
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
  @action
  addHistoryFromDb()async{
   final historyes=await instanceDb.getHistory();
   history=ObservableList.of(historyes);
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
  addHistory(HistoryModel model){
    history.add(model);
    history=ObservableList.of(history);
  }

  @action
  updateStatusHistory(String id,String answer,String answerMessageId )async{
    var historyModel= history.firstWhere((element) => element.messageId==id);
    historyModel.progress="completed";
    historyModel.answer=answer;
    historyModel.answerMessageId=answerMessageId;
    await instanceDb.addHistory(historyModel);
    history=ObservableList.of(history);
  }
  @action
  Future<void> updateFavoriteHistory(String id)async{
     var historyModel = history.firstWhere((element) => element.messageId==id);
     historyModel.favorite=!historyModel.favorite;
     bool currentValue=historyModel.favorite;
     print(currentValue);
    await  instanceDb.updateHistoryFavorite(id,currentValue);
    history=ObservableList.of(history);
  }
  getPush(){

  }
  Message? searchMessage(String messageId,String type){
      if(chats[type]!=null){
        for (var element in chats[type]!) {
          if(element.id==messageId){
            return element;
          }
        }
      }else{
        return null;
      }
      return null;
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
  String? reply;
  String? path;
  
  Message({
    required this.id,
    required this.status,
    required this.text,
    required this.sender,
    required this.fileBuffer,
    this.name,
    this.link,
    this.reply,
    this.path
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

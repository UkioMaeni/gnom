import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gnom/core/localization/localization_bloc.dart';
import 'package:gnom/http/subjects.dart';
import 'package:gnom/pages/chat_page/chat_page.dart';
import 'package:mobx/mobx.dart';
import 'package:uuid/uuid.dart';

part 'chat_store_2.g.dart';



class ChatStore2 = _ChatStore2 with _$ChatStore2;

abstract class _ChatStore2 with Store {

  @observable
  ObservableMap<String,ChatInfo> chats=ObservableMap<String,ChatInfo>.of({
    EChatPageType.math.name:ChatInfo(mess: [], required: false),
    EChatPageType.referat.name:ChatInfo(mess: [], required: false),
    EChatPageType.essay.name:ChatInfo(mess: [], required: false),
    EChatPageType.presentation.name:ChatInfo(mess: [], required: false),
    EChatPageType.reduce.name:ChatInfo(mess: [], required: false),
    EChatPageType.parafrase.name:ChatInfo(mess: [], required: false),
    EChatPageType.sovet.name:ChatInfo(mess: [], required: false),
    EChatPageType.generation.name:ChatInfo(mess: [], required: false),
  });
  @action
  addMessage(MessInterface mess,BuildContext context){
    if(mess is MessageText){
      _addMessageText(mess, context);
    }else if(mess is MessageDocument){
      _addMessageDocument(mess,context);
    }
  }
  _addMessageDocument(MessageDocument mess,BuildContext context ){
    chats[mess.type]!.mess.add(mess);
    chats=ObservableMap.of(chats);
    final state = (context.read<LocalizationBloc>().state as LocalizationLocaleState);
    final messBot=MessageText(uuid: Uuid().v4(),text: "Вы действительно хотите отправить данную картинку?",sender: "bot",type: mess.type);
    chats[mess.type]!.mess.add(messBot);
    chats[mess.type]!.required=true;
    chats=ObservableMap.of(chats);
    //instanceDb.addMessage(SubjectTypedMessage(message: messBot, subjectType: chatType.name));
    //requiredComplete[chatType.name]!.message=mess;
  } 
  _addMessageText(MessageText mess,BuildContext context)async{
    chats[mess.type]!.mess.add(mess);
    chats=ObservableMap.of(chats);
    final state = (context.read<LocalizationBloc>().state as LocalizationLocaleState);
    String text = mess.text;
    if(text==state.locale.yes||text==state.locale.no){
      if(!chats[mess.type]!.required){
        final messBot=MessageText(uuid: Uuid().v4(),text: "Сначала задайте вопрос",sender: "bot",type: mess.type);
        chats[mess.type]!.mess.add(messBot);
        chats=ObservableMap.of(chats);
        return;
      };
      FormData formData=FormData();
      if(text==state.locale.yes){
        formData.fields.add(MapEntry("type", mess.type));
        formData.fields.add(MapEntry("text", text));
        formData.fields.add(MapEntry("messageId", mess.uuid));
        final messBot=MessageText(uuid: Uuid().v4(),text: state.locale.promptIsSent,sender: "bot",type: mess.type);
        chats[mess.type]!.mess.add(messBot);
        chats=ObservableMap.of(chats);
        final result= await SubjectsHttp().sendRequest(formData);
        if(result!=null){  
              if(result.long==true){
                final messBot=MessageText(uuid: Uuid().v4(),text:state.locale.theQueryRequiresTime,sender: "bot",type: mess.type);
                chats[mess.type]!.mess.add(messBot);
                chats=ObservableMap.of(chats);
                //instanceDb.addMessage(SubjectTypedMessage(message: messBot, subjectType: chatType.name));
              }else{
                if(result.result.contains("http")){
                  // final response=await Dio().get(
                  //        result.result,
                  //        options: Options(responseType: ResponseType.bytes)
                  //     );
                  //     print(response.data);
                  //     print(response.headers["content-type"]);
                  //     String fileExchange=response.headers["content-type"]?[0].replaceAll("image/", "")??"none";
                  //     var path = await ExternalPath.getExternalStorageDirectories();
                  //     final gnomDirectory = Directory(path[0]+'/Android/media/com.gnom.helper');
                  //     final file = File(gnomDirectory.path+"/${result.messageId}.${fileExchange}");
                  //     file.writeAsBytesSync(response.data);
                      //chatStore.updateStatusForDownloadFile(widget.message.id, gnomDirectory.path+"/${id}.${fileExchange}",widget.type);
                      final messBot=MessageDocument(uuid: Uuid().v4(),sender: "bot",documentType: "no",path: "no",type: mess.type,downloadPath: result.result);
                      //updateStatusHistory(result.messageId,result.result,messageBotId);
                      chats[mess.type]!.mess.add(messBot);
                      chats=ObservableMap.of(chats);
                      //instanceDb.addMessage(SubjectTypedMessage(message: messBot, subjectType: chatType.name));
                        }
                      }
                      chats=ObservableMap.of(chats);
                      
                    }else{
                      final messBot=MessageText(uuid: Uuid().v4(),text: state.locale.error,sender: "bot",type: mess.type);
                      chats[mess.type]!.mess.add(messBot);
                      chats=ObservableMap.of(chats);
                      //instanceDb.addMessage(SubjectTypedMessage(message: messBot, subjectType: chatType.name));
                      
                    }
      }else{
            String text=state.locale.areYouSure;
          if(state.locale.language=="ar"){
            text="؟\"${mess.text}\" "+text;
          }else{
            text=text+" \"${mess.text}\"?";
          }
          final messBot=MessageText(uuid: Uuid().v4(),text: text,sender: "bot",type: mess.type);
          chats[mess.type]!.required=true;
          chats=ObservableMap.of(chats);
      }
    }else{

    }
    // if(state.locale is RuLocale){
      
    // }else if(state.locale is EnLocale){

    // }else if(state.locale is ArLocale){
      
    // }
  }


}


class ChatInfo{
  bool required;
  List<MessInterface> mess;
  ChatInfo({
    required this.mess,
    required this.required,
  });
}


abstract  class  MessInterface<T>{
   late String type;
   late String sender;
   late String uuid;
}

class MessageText implements MessInterface<String>{
 MessageText({
  required this.text,
  required this.uuid,
  required this.type,
  required this.sender,
 });

  String text;
  @override
  String uuid;

  @override
  String type;
  
  @override
  String sender;

}

class MessageDocument implements MessInterface<String>{
 MessageDocument({
  required this.path,
  required this.documentType,
  required this.type,
  required this.sender,
  required this.uuid,
  required this.downloadPath,
 });
  String path;
  String documentType;
  String downloadPath;
  @override
  String type;
  
  @override
  String sender;
  
  @override
  String uuid;
}

ChatStore2 chatStore2 = ChatStore2();





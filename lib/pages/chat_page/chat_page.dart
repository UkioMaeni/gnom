import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:gnom/core/localization/localization_bloc.dart';
import 'package:gnom/http/guest.dart';
import 'package:gnom/pages/chat_page/components/chat_area.dart';
import 'package:gnom/pages/chat_page/store/chat_store.dart';
import 'package:gnom/pages/chat_page/store/chat_store_2.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
enum EChatPageType{
  math,parafrase,referat,essay,presentation,reduce,sovet,generation,miniGame
}


class ChatPage extends StatefulWidget {
  final EChatPageType type;
  final String title;
  const ChatPage({super.key,required this.type,required this.title});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {


 final TextEditingController _controller=TextEditingController();

  final uuid= Uuid();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

void attachment()async{
  FormData formData=FormData();
  // formData.fields.add(MapEntry("lang", "ru_RU"));
  // formData.fields.add(MapEntry("type", widget.type.name));
  final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
  
  if(pickedFile!=null){
    // final mess= MessageDocument(documentType: pickedFile.mimeType??"no",uuid: uuid.v4(),type: widget.type.name,sender: "person",downloadPath: "no",path: pickedFile.path); 
    // chatStore2.addMessage(mess, context);
    chatStore.addMessage(widget.type, _controller.text,pickedFile,context);
  }
  _controller.text="";
  // // Добавление файла
  //var file = File(pickedFile.path).openRead();
  // formData.files.add(MapEntry('file',await MultipartFile.fromFile(pickedFile.path,)));
  // GuestHttp().request(formData);
  
}
  sendMessage(){
    // final mess= MessageText(text: _controller.text,uuid: uuid.v4(),type: widget.type.name,sender: "person"); 
    // chatStore2.addMessage(mess,context);
    chatStore.addMessage(widget.type, _controller.text,null,context);
    _controller.text="";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Container(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          decoration:  const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/jpg/chat_bg.jpg"),
              fit: BoxFit.cover,
            )
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
            child: Column(
              children: [
                const SizedBox(height: 20,),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Row(
                    children: [
                      const SizedBox(width: 20,),
                      Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)
                        ),
                        child: const Icon(Icons.arrow_back)
                      ),
                      const SizedBox(width: 10,),
                      Builder(
                        builder: (context) {
                          final state = (context.watch<LocalizationBloc>().state as LocalizationLocaleState);
                                          String name=state.locale.error;
                                          if(widget.type.name=="reduce"){
                                            name=state.locale.shortcut;
                                          }else if(widget.type.name=="math"){
                                            name=state.locale.mathematics;
                                          }
                                          else if(widget.type.name=="referre"){
                                            name=state.locale.paper;
                                          }
                                          else if(widget.type.name=="generation"){
                                            name=state.locale.imageGeneration;
                                          }
                                          else if(widget.type.name=="essay"){
                                            name=state.locale.essay;
                                          }
                                          else if(widget.type.name=="presentation"){
                                            name=state.locale.presentation;
                                          }
                                          else if(widget.type.name=="paraphrase"){
                                            name=state.locale.paraphrasing;
                                          }
                                          else if(widget.type.name=="sovet"){
                                            name=state.locale.adviseOn;
                                          }
                          return Text(
                            name,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w400,
                              fontFamily: "NoirPro",
                              height: 1,
                              color: Colors.white
                              ),
                          );
                        }
                      ),
                      
                      
                    ],
                  ),
                ),
                Expanded(
                  child: ChatPageChatArea(type: widget.type,)
                ),
                SizedBox(height: 10,),
                Observer(builder: (context) {
                  if(chatStore.requiredComplete[widget.type.name]!.required)
                  return Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      border: Border(
                        bottom: BorderSide(
                          color: Color.fromARGB(162, 255, 255, 255)
                        )
                      )
                    ),
                    child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Builder(
                          builder: (context) {
                            final state = (context.watch<LocalizationBloc>().state as LocalizationLocaleState);
                            return GestureDetector(
                              onTap: () {
                                chatStore.addMessage(widget.type, state.locale.yes,null,context);
                                // final mess= MessageText(text: state.locale.yes,uuid: uuid.v4(),type: widget.type.name,sender: "person"); 
                                // chatStore2.addMessage(mess,context);
                              },
                              child: Text(
                                          state.locale.yes,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: "NoirPro",
                                            height: 1,
                                            color: Colors.white
                                            ),
                                        )
                            );
                          }
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 50,
                        color: Color.fromARGB(162, 255, 255, 255),
                      ),
                      Expanded(
                        child: Builder(
                          builder: (context) {
                            final state = (context.watch<LocalizationBloc>().state as LocalizationLocaleState);
                            return GestureDetector(
                              onTap: () {
                                chatStore.addMessage(widget.type, state.locale.no,null,context);
                                // final mess= MessageText(text: state.locale.no,uuid: uuid.v4(),type: widget.type.name,sender: "person"); 
                                // chatStore2.addMessage(mess,context);
                              },
                              child: Text(
                                          state.locale.no,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: "NoirPro",
                                            height: 1,
                                            color: Colors.white
                                            ),
                                        )
                            );
                          }
                        ),
                      )
                    ],
                                    ),
                  );
                return SizedBox();
                },),
                
                textField(),
                Container(
                  height: 40,
                  color: Colors.black,
                )
              ],
            ),
          ),
        ),
      
    );
  }

  Widget textField(){
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          border: Border(
                        bottom: BorderSide(
                          color: Color.fromARGB(162, 255, 255, 255)
                        )
                      )
        ),
        child: Row(
          children: [
            SizedBox(width: 10,),
            Builder(
              builder: (context) {
                if(widget.type==EChatPageType.sovet||widget.type==EChatPageType.presentation||widget.type==EChatPageType.essay||widget.type==EChatPageType.referat){
                  return SizedBox.shrink();
                }
                return GestureDetector(
                  onTap: attachment,
                  child: const Icon(Icons.attachment,color: Color.fromARGB(255, 255, 255, 255),size: 30,)
                );
              }
            ),
            
             Expanded(
              child: Builder(
                builder: (context) {
                  final state = (context.watch<LocalizationBloc>().state as LocalizationLocaleState);
                  return TextField(
                    controller: _controller,
                    maxLines: 5,
                    minLines: 1,
                    style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            fontFamily: "NoirPro",
                            height: 1,
                            color: Colors.white
                            ),
                    decoration: InputDecoration(
                      constraints: BoxConstraints(
                        minHeight: 40,
                      ),
                      contentPadding: EdgeInsets.only(left: 10,right: 10),
                      hintText: state.locale.writeAMessage,
                      hintStyle: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            fontFamily: "NoirPro",
                            height: 1,
                            color: Color.fromARGB(96, 255, 255, 255)
                            ),
                      border: InputBorder.none
                    ),
                  );
                }
              ),
            ),
            GestureDetector(
              onTap: sendMessage,
              child: const Icon(Icons.send,color: Colors.white,size: 30,)
            ),
            const SizedBox(width: 10,)
          ],
        ),
      ),
    );
  }

}
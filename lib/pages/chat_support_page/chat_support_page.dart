import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gnom/http/guest.dart';
import 'package:gnom/pages/chat_page/components/chat_area.dart';
import 'package:gnom/pages/chat_support_page/components/chat_support_area.dart';
import 'package:gnom/pages/chat_support_page/store/chat_support_store.dart';
import 'package:image_picker/image_picker.dart';



class ChatSupportPage extends StatefulWidget {
  final String title;
  const ChatSupportPage({super.key,required this.title});

  @override
  State<ChatSupportPage> createState() => _ChatSupportPageState();
}

class _ChatSupportPageState extends State<ChatSupportPage> {


 final TextEditingController _controller=TextEditingController();

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
   // chatStore.addMessage(widget.type, _controller.text,pickedFile);
  }
  _controller.text="";
  // // Добавление файла
  //var file = File(pickedFile.path).openRead();
  // formData.files.add(MapEntry('file',await MultipartFile.fromFile(pickedFile.path,)));
  // GuestHttp().request(formData);
  
}
  sendMessage(){
    chatSupportStore.addMessage(_controller.text,null);
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
                          
                          return Text(
                            widget.title,
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
                  child: ChatSupportPageChatArea()
                ),
                
                SizedBox(height: 10,),
                textField(),
                const SizedBox(height: 20,)
              ],
            ),
          ),
        ),
      
    );
  }

  Widget textField(){
    return SizedBox(
      width: MediaQuery.of(context).size.width-60,
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(157, 43, 42, 42),
          borderRadius: BorderRadius.circular(14)
        ),
        child: Row(
          children: [
            const SizedBox(width: 10,),
            Builder(
              builder: (context) {
               
                return GestureDetector(
                  onTap: attachment,
                  child: const Icon(Icons.attachment,color: Color.fromARGB(255, 255, 255, 255),size: 30,)
                );
              }
            ),
            
             Expanded(
              child: TextField(
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
                  hintText: "Напишите сообщение...",
                  hintStyle: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        fontFamily: "NoirPro",
                        height: 1,
                        color: Color.fromARGB(96, 255, 255, 255)
                        ),
                  border: InputBorder.none
                ),
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
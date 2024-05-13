import 'dart:io';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gnom/http/guest.dart';
import 'package:gnom/pages/chat_page/components/chat_area.dart';
import 'package:image_picker/image_picker.dart';
enum EChatPageType{
  math
}


class ChatPage extends StatefulWidget {
  final EChatPageType type;
  const ChatPage({super.key,required this.type});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {


void sendRequest()async{
  FormData formData=FormData();
  formData.fields.add(MapEntry("lang", "ru_RU"));
  formData.fields.add(MapEntry("type", widget.type.name));
  final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
  if (pickedFile == null) {
    return;
  }
  // Добавление файла
  //var file = File(pickedFile.path).openRead();
  formData.files.add(MapEntry('file',await MultipartFile.fromFile(pickedFile.path,)));
  GuestHttp().request(formData);
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
                          String title="Заявка";
                          if(widget.type==EChatPageType.math){
                            title="Математика";
                          }
                          return Text(
                            title,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(157, 43, 42, 42),
                        borderRadius: BorderRadius.circular(14)
                      ),
                      child: Text(
                            "ДА",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w400,
                              fontFamily: "NoirPro",
                              height: 1,
                              color: Colors.white
                              ),
                          ),
                    ),
                    SizedBox(width: 50,),
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(157, 43, 42, 42),
                        borderRadius: BorderRadius.circular(14)
                      ),
                      child: Text(
                            "НЕТ",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w400,
                              fontFamily: "NoirPro",
                              height: 1,
                              color: Colors.white
                              ),
                          ),
                    )
                  ],
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
            GestureDetector(
              onTap: sendRequest,
              child: const Icon(Icons.attachment,color: Color.fromARGB(255, 255, 255, 255),size: 30,)
            ),
            
            const Expanded(
              child: TextField(
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
              onTap: sendRequest,
              child: const Icon(Icons.send,color: Colors.white,size: 30,)
            ),
            const SizedBox(width: 10,)
          ],
        ),
      ),
    );
  }

}
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gnom/http/fcm.dart';
import 'package:gnom/http/user.dart';
import 'package:gnom/pages/main_page/main_page.dart';
import 'package:gnom/repositories/locale_storage.dart';
import 'package:gnom/repositories/token_repo.dart';
import 'package:gnom/store/user_store.dart';

class CodeScene extends StatefulWidget {
  final TextEditingController controller;
  final Function(String) toScene;
  final String email;
  const CodeScene({super.key,required this.controller,required this.toScene,required this.email});

  @override
  State<CodeScene> createState() => _CodeSceneState();
}

class _CodeSceneState extends State<CodeScene> {


  final FocusNode _focusNode=FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
             Opacity(
              opacity: 0,
               child: TextField(
                maxLength: 4,
                onChanged: (value) {
                  setState(() {
                    
                  });
                },
                  controller: widget.controller,
                  focusNode: _focusNode,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    
                  ),
                ),
             ),
            
            GestureDetector(
              onTap: () {
                print(_focusNode.hasFocus);
                _focusNode.requestFocus();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  codeItem(0),
                  codeItem(1),
                  codeItem(2),
                  codeItem(3),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 30,),
        button()
      ],
    );
  }

    Widget codeItem(int index){
      print(widget.controller.text);
      String text=widget.controller.text.isEmpty?"":widget.controller.text.length>=index+1?widget.controller.text[index]:"";
      return Container(
        height: 100,
        width: 70,
        decoration: BoxDecoration(
          color:  widget.controller.text.length>=index+1?Color.fromARGB(143, 0, 0, 0):Color.fromARGB(96, 0, 0, 0),
          borderRadius: BorderRadius.circular(10)
        ),
        alignment: Alignment.center,
        child: Text(
             text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.w800,
              fontFamily: "NoirPro",
              height: 0.9,
              color: const Color.fromRGBO(254, 222,181, 1)
              ),
          ),
      );
    }

  initFirebase()async{
    final apnsToken = await FirebaseMessaging.instance.getToken();
    await FCMHttp().setFcmToken(apnsToken??"");
  }

    Widget button(){
    return GestureDetector(
      onTap: () async{
       final tokens=await UserHttp().verifyOtp(widget.email,widget.controller.text,);
       if(tokens!=null){
        localeStorage.saveRefreshUserToken(tokens.refresh);
        tokenRepo.accessUserToken=tokens.access;
        userStore.role="client";
        
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => MainPage(),), (route) => false);
        await initFirebase();
        userStore.getRequestsCount();
        userStore.requiredData();
       }
      },
      child: Container(
              decoration: BoxDecoration(
                  color: Color.fromARGB(143, 0, 0, 0),
                  borderRadius: BorderRadius.circular(13)
                ),
                padding: EdgeInsets.all(10),
                child: Text(
                        "ПОДТВЕРДИТЬ",
                        style: TextStyle(
                          fontFamily: "NoirPro",
                          color: Color.fromRGBO(254, 222,181, 1),
                          height: 1,
                          fontWeight: FontWeight.w700,
                          fontSize: 25
                        ),
                    ),
            ),
    );
  }

  Widget input(TextEditingController controller,String hint){
    return SizedBox(
      height: 40,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Color.fromARGB(143, 0, 0, 0),
          borderRadius: BorderRadius.circular(10)
        ),
        child: TextField(
          controller: controller,
          style: TextStyle(
              fontFamily: "NoirPro",
              color: const Color.fromARGB(123, 255, 255, 255),
              height: 1,
              fontWeight: FontWeight.w400,
              fontSize: 20
            ),
          decoration: InputDecoration(
            constraints: BoxConstraints(
              minHeight: 40,
              maxHeight: 40
            ),
            contentPadding: EdgeInsets.only(left: 10,right: 10,bottom: 7),
            border: InputBorder.none,
            hintText: hint,
            hintStyle: TextStyle(
              fontFamily: "NoirPro",
              color: const Color.fromARGB(123, 255, 255, 255),
              height: 1,
              fontWeight: FontWeight.w400,
              fontSize: 20
            ),
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gnom/pages/auth_page/scenes/auth_scene.dart';
import 'package:gnom/pages/auth_page/scenes/code_scene.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {


  final TextEditingController email=TextEditingController();
  final TextEditingController code=TextEditingController();

  @override
  void dispose() {
    email.dispose();
    code.dispose();
    super.dispose();
  }

  String scene="auth";

  void toScene(String newScene){
    setState(() {
      scene=newScene;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PopScope(
        canPop: scene=="auth",
        onPopInvoked: (didPop) {
          if(scene!="auth"){
            setState(() {
              scene="auth";
            });
          }
        },
        child: Container(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/png/app_bg.png"),
                    fit: BoxFit.cover
                  )
                ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: [
                SizedBox(height: 100,),
                Text(
                  "GNOM\nHELPER",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.w800,
                    fontFamily: "NoirPro",
                    height: 0.9,
                    color: const Color.fromRGBO(254, 222,181, 1)
                    ),
                ),
                SizedBox(height: 100,),
                Builder(
                  builder: (context) {
                    if(scene=="auth"){
                      return AuthScene(controller: email,toScene:toScene);
                    }else{
                      return CodeScene(controller: code,toScene:toScene,email:email.text);
                    }
                  }
                )
              ],
            ),
          ),
        ),
      ),
    );
  }



}
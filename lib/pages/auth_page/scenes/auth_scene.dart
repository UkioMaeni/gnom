import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gnom/core/localization/localization_bloc.dart';
import 'package:gnom/core/tools/string_tool.dart';
import 'package:gnom/http/user.dart';

class AuthScene extends StatefulWidget {
  final TextEditingController controller;
  final Function(String) toScene;
  const AuthScene({super.key,required this.controller,required this.toScene});

  @override
  State<AuthScene> createState() => _AuthSceneState();
}

class _AuthSceneState extends State<AuthScene> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        input(widget.controller,"Ваша почта..."),
        SizedBox(height: 30,),
        button()
      ],
    );
  }

    Widget button(){
    return GestureDetector(
      onTap: () {
        UserHttp().sendOtp(widget.controller.text);
        widget.toScene("code");
      },
      child: Container(
              decoration: BoxDecoration(
                  color: Color.fromARGB(143, 0, 0, 0),
                  borderRadius: BorderRadius.circular(13)
                ),
                padding: EdgeInsets.all(10),
                child: Builder(
                  builder: (context) {
                    final state = (context.watch<LocalizationBloc>().state as LocalizationLocaleState);
                    return Text(
                             StringTools.firstUpperOfString(state.locale.logIn),
                            style: TextStyle(
                              fontFamily: "NoirPro",
                              color: Color.fromRGBO(254, 222,181, 1),
                              height: 1,
                              fontWeight: FontWeight.w700,
                              fontSize: 25
                            ),
                        );
                  }
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
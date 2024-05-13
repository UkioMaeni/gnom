import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AuthProfile extends StatefulWidget {
  const AuthProfile({super.key});

  @override
  State<AuthProfile> createState() => _AuthProfileState();
}

class _AuthProfileState extends State<AuthProfile> {


  final TextEditingController email=TextEditingController();
  final TextEditingController pass=TextEditingController();
  final TextEditingController repass=TextEditingController();

  @override
  void dispose() {
    email.dispose();
    pass.dispose();
    repass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 100,),
        Text(
            "СОЗДАТЬ",
            style: TextStyle(
              fontFamily: "NoirPro",
              color: Color.fromRGBO(254, 222,181, 1),
              height: 1,
              fontWeight: FontWeight.w700,
              fontSize: 40
            ),
        ),
        Text(
            "НОВЫЙ АККАУНТ",
            style: TextStyle(
              fontFamily: "NoirPro",
              color: Color.fromRGBO(254, 222,181, 1),
              height: 1,
              fontWeight: FontWeight.w700,
              fontSize: 25
            ),
        ),
        SizedBox(height: 100,),
        input(email,"Ваша почта..."),
        SizedBox(height: 10,),
        input(pass,"Пароль..."),
        SizedBox(height: 10,),
        input(repass,"Повторите пароль..."),
        SizedBox(height: 30,),
        button()
      ],
    );
  }

  Widget button(){
    return Container(
            decoration: BoxDecoration(
                color: Color.fromARGB(143, 0, 0, 0),
                borderRadius: BorderRadius.circular(13)
              ),
              padding: EdgeInsets.all(10),
              child: Text(
                      "СОЗДАТЬ",
                      style: TextStyle(
                        fontFamily: "NoirPro",
                        color: Color.fromRGBO(254, 222,181, 1),
                        height: 1,
                        fontWeight: FontWeight.w700,
                        fontSize: 25
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
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gnom/pages/main_page/tabs/profile_tab/components/plaining_subcribtion/animations_planings.dart';

class PlaneInfo extends StatefulWidget {
  final Function(bool) setOpen;
  const PlaneInfo({super.key,required this.setOpen});

  @override
  State<PlaneInfo> createState() => _PlaneInfoState();
}

class _PlaneInfoState extends State<PlaneInfo> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: GestureDetector(
            onTap: () {
              widget.setOpen(false);
            },
          ),
        ),
        Positioned(
          top: 40,
          left: 30,
          right: 30,
          child: Container(
            width: 200,
            height: 420,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20)
            ),
            child: Column(
              children: [
                SizedBox(height: 20,),
                Text(
                  "BRONZE",
                  style: TextStyle(
                    fontFamily: "NoirPro",
                    color: Color.fromARGB(255, 82, 81, 81),
                    height: 1,
                    fontWeight: FontWeight.w700,
                    fontSize: 35
                  ),
                ),
                SizedBox(height: 10,),
                Text(
                  "1 МЕСЯЦ",
                  style: TextStyle(
                    fontFamily: "NoirPro",
                    color: Color.fromARGB(255, 82, 81, 81),
                    height: 1,
                    fontWeight: FontWeight.w700,
                    fontSize: 15
                  ),
                ),
                SizedBox(height: 10,),
                Stack(
                  alignment: Alignment.center,
                    children: [
                      SizedBox(height: 30,),
                      Container(
                        width: double.infinity,
                        height: 5,
                        color: Color.fromARGB(255, 218, 217, 217),
                      ),
                      Positioned(
                        left: -15,
                        top: 0,
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 218, 217, 217),
                            borderRadius: BorderRadius.circular(15)
                          ),
                        )
                      ),
                      Positioned(
                        right: -15,
                        top: 0,
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 218, 217, 217),
                            borderRadius: BorderRadius.circular(15)
                          ),
                        )
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "389Р",
                        style: TextStyle(
                          fontFamily: "NoirPro",
                          color: Color.fromARGB(255, 82, 81, 81),
                          height: 1,
                          fontWeight: FontWeight.w700,
                          fontSize: 35
                        ),
                      ),
                      Text(
                        "/МЕСЯЦ",
                        style: TextStyle(
                          fontFamily: "NoirPro",
                          color: Color.fromARGB(255, 82, 81, 81),
                          height: 1,
                          fontWeight: FontWeight.w700,
                          fontSize: 17
                        ),
                      ),
                      
                    ],
                  ),
                  SizedBox(height: 30,),
                  punkt("МАТЕМАТИКА - 80"),
                  punkt("СОЧИНЕНИЕ - 80"),
                  punkt("ПЕРЕЗЕНТАЦИИ - 80"),
                  punkt("ДАЙ СОВЕТ - 80"),
                  punkt("СОКРАЩЕНИЕ - 80"),
                  punkt("РЕФЕРАТ - 80"),
                  punkt("ПЕРЕФРАЗИРОВАНИЕ - 80"),
              ],
            ),
          ),
        ),
        // Positioned(
        //   bottom: 86,
        //   left: 20,
        //   child: FirstElementPlaning(onTap: (_){},)
        // )
      ],
    );
  }

  Widget punkt(String title){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: SizedBox(
        child: Row(
          children: [
            SizedBox(width: 20,),
            SizedBox(
              width: 10,
              height: 10,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Color.fromARGB(255, 82, 81, 81)
                )
              )
            ),
            SizedBox(width: 10,),
            Text(
              title,
              style: TextStyle(
                fontFamily: "NoirPro",
                color: Color.fromARGB(255, 82, 81, 81),
                height: 1,
                fontWeight: FontWeight.w700,
                fontSize: 17
              ),
            ),
          ],
        ),
      ),
    );
  }

}
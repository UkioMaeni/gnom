import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gnom/pages/chat_page/chat_page.dart';
import 'package:gnom/pages/chat_page/store/chat_store.dart';

class PushPage extends StatefulWidget {
  const PushPage({super.key});

  @override
  State<PushPage> createState() => _PushPageState();
}

class _PushPageState extends State<PushPage> {


  

  List<Widget> widgets=[];

  startGenerate()async{
    final pushs=chatStore.pushs;
    for(int i=0;i<pushs.length;i++){
      
      await Future.delayed(Duration(milliseconds: 300));
      if(!mounted)return;
      setState(() {
        widgets.add(
           PushElement(topOffset: (i)*105+30, model:pushs[i],)
        );
        });
      
      
    }
  }

  @override
  void initState() {
    startGenerate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body:Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/jpg/app_bg.jpg"),
                  fit: BoxFit.cover
                )
              ),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    SizedBox(height: 50,),
                    GestureDetector(
                      onTap: ()=>Navigator.pop(context),
                      child: Row(
                        children: [
                          Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)
                            ),
                            child: Icon(Icons.arrow_back)
                          ),
                          SizedBox(width: 10,),
                          Text(
                            "Уведомления",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w400,
                              fontFamily: "NoirPro",
                              height: 1,
                              color: Colors.white
                              ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                          child: ListView(
                                children: [
                                  for(int i=0;i<widgets.length;i++)widgets[i]
                                ],
                              ),
                          
                        ),
                  ],
                ),
              ),
            ),
    );
  }
}


class PushModel{
  String subjectType;
  String title;
  String sub;
  Widget icon;
  PushModel({
    required this.icon,
    required this.title,
    required this.sub,
    required this.subjectType,
  });
  static String titleFromType(String type){
    switch(type){
      case "math":
        return "МАТЕМАТИКА"; 
    }
    return "НЕИЗВЕСТНО";
  }
}

class PushElement extends StatefulWidget {
  final PushModel model;
  final double topOffset;
  const PushElement({super.key,required this.model,required this.topOffset});

  @override
  State<PushElement> createState() => _PushElementState();
}

class _PushElementState extends State<PushElement> with TickerProviderStateMixin {

  
  late  AnimationController _scaleController;
  late  Animation<double> _scaleAnimation;

  late double initOffset;
  late double? right;
  @override
  void initState() {
    initOffset=widget.topOffset;
    right=0;
    _scaleController=AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this
    );
    _scaleAnimation=Tween<double>(begin: 0.3,end: 1).animate(_scaleController);
    _scaleController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    return  GestureDetector(
      onTap: () {
       // Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage(type: widget.model.type,title:widget.model.title),));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: AnimatedBuilder(
            animation:_scaleAnimation,
            builder: (context, child) {
              return  Transform.scale(
                  scale: _scaleAnimation.value,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      height: 105,
                      width: width-40,
                      decoration: BoxDecoration(
                                color: const Color.fromRGBO(196, 114, 137, 0.8),
                                
                              ),
                      child: Column(
                        children: [
                          Container(
                            height: 30,
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(left: 10),
                            decoration: BoxDecoration(
                              
                              color: Color.fromARGB(103, 214, 194, 214)
                            ),
                            child: Text(
                                widget.model.sub,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "NoirPro",
                                  height: 1,
                                  color: Colors.white
                                  ),
                              ),
                          ),
                          Expanded(
                            child: Row(
                              
                              children: [
                                widget.model.icon,
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,

                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(right: 30),
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child:Text(
                                              widget.model.title,
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: "NoirPro",
                                                height: 1,
                                                color: Colors.white
                                                ),
                                            ), 
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(right: 50,top: 10),
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                                "СКАЧАТЬ",
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: "NoirPro",
                                                  height: 1,
                                                  color: Colors.white
                                                  ),
                                              ),
                                        ),
                                      ), 
                                    ],
                                  )
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      // child:  Row(
                      //   children: [
                      //     Expanded(
                      //       child: DecoratedBox(
                      //         decoration: BoxDecoration(
                      //           color: const Color.fromRGBO(196, 114, 137, 0.8),
                      //           borderRadius: BorderRadius.circular(15)
                      //         ),
                      //         child: Padding(
                                
                      //           child: Row(
                      //             mainAxisAlignment: MainAxisAlignment.start,
                      //               children: [
                      //                  Align(
                      //                   alignment: Alignment.topCenter,
                      //                   child: SizedBox(
                      //                     width: 70,
                      //                     height: 80,
                      //                     child: SvgPicture.asset("assets/svg/math.svg",fit: BoxFit.contain,)
                      //                   ),
                      //                 ),
                      //                 SizedBox(width: 20,),
                      //                 Column(
                      //                   crossAxisAlignment: CrossAxisAlignment.center,
                      //                   mainAxisAlignment: MainAxisAlignment.center,
                      //                   children: [
                      //                     Text(
                      //                     widget.model.title,
                      //                     textAlign: TextAlign.center,
                      //                     style: const TextStyle(
                      //                       fontSize: 20,
                      //                       fontWeight: FontWeight.w800,
                      //                       fontFamily: "NoirPro",
                      //                       height: 1,
                      //                       color: Color.fromRGBO(254, 222,181, 1)
                      //                       ),
                      //                   ),
                      //                   const SizedBox(height: 5,),
                      //                   Text(
                      //                     widget.model.sub,
                      //                     textAlign: TextAlign.center,
                      //                     style: const TextStyle(
                      //                       fontSize: 14,
                      //                       fontWeight: FontWeight.w500,
                      //                       fontFamily: "NoirPro",
                      //                       height: 1,
                      //                       color: Colors.white
                      //                       ),
                      //                   ),
                      //                   ],
                      //                 ),
                      //                 // Container(
                      //                 //     width: 140,
                      //                 //     height: 60,
                      //                 //     color: Colors.amber,
                      //                 //     alignment: Alignment.centerRight,
                      //                 //     child:  widget.model.icon,
                      //                 //   ),
                                      
                                     
                      //               ],
                      //             ),
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      
                    ),
                  ),
                
              );
            }, 
          
        ),
      ),
    );
  }
}
import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gnom/pages/chat_page/store/chat_store.dart';
import 'package:gnom/pages/main_page/tabs/history_tab/history_info.dart';

class HistoryTab extends StatefulWidget {
  const HistoryTab({super.key});

  @override
  State<HistoryTab> createState() => _HistoryTabState();
}

class _HistoryTabState extends State<HistoryTab> with TickerProviderStateMixin {


  // late final AnimationController _heightController;
  // late final Animation<double> _height;
  double paddingOffset=100;
    List<Widget> widgets=[];

  startGenerate()async{
    final histories= chatStore.history;
    
    final processList= histories.where((element) => element.progress=="process").toList();
    final completedList= histories.where((element) => element.progress=="completed").toList();
    print(processList.length);
    for(int i=0;i<processList.length;i++){
      setState(() {
        if(i==0){
          widgets.add(
          Positioned(
            top: i*105+paddingOffset,
            child: TextElement(title: "В ПРОЦЕССЕ",)
          )
        );
        }
        widgets.add(
           HistoryElement(topOffset: (i)*105+paddingOffset+50, model:processList[i],)
        );
      });
      await Future.delayed(Duration(milliseconds: 300));
    }
    for(int i=0;i<completedList.length;i++){
      setState(() {
        if(i==0){
          widgets.add(
          Positioned(
            top: (i+processList.length)*105+paddingOffset+50,
            child: TextElement(title: "ВЫПОЛНЕНО",)
          )
        );
        }
        widgets.add(
           HistoryElement(topOffset: (i+processList.length)*105+paddingOffset+100, model:completedList[i],)
        );
      });
      await Future.delayed(Duration(milliseconds: 300));
    }
  }
  @override
  void initState() {
    startGenerate();
    print("init");
    // _heightController=AnimationController(
    //   duration: Duration(milliseconds: 1000),
    //   vsync: this
    // );
    // _height=Tween<double>(begin: 0,end:  200).animate(_heightController);
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) { 
      setState(() {
         widthUpdate =MediaQuery.of(context).size.width-60;
      });
    });
  }

  double heightUpdate=130;
  double widthUpdate=0;
  Color color=const Color.fromRGBO(196, 114, 137, 0.8);
  Color textColor=Colors.white;

  void openInfo(){
    setState(() {
      heightUpdate=350;
      widthUpdate=MediaQuery.of(context).size.width-10;
      Future.delayed(const Duration(milliseconds: 200)).then((value) => setState(() {
          widthUpdate=MediaQuery.of(context).size.width-60;
      }));
      color=const Color.fromRGBO(92, 90, 90, 0.8);
      textColor=const Color.fromRGBO(254, 222,181, 1);
    });
  }

  void closeInfo(){
    setState(() {
      heightUpdate=130;
      widthUpdate==MediaQuery.of(context).size.width-60;
      color=const Color.fromRGBO(196, 114, 137, 0.8);
      textColor=Colors.white;
    });
  }


  

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(top: MediaQuery.of(context).padding.top,left: 20,right: 0),
      child: Stack(
        children: [
          
          for(int i=0;i<widgets.length;i++)widgets[i]
        ],
      ),
    );
  }



Widget selectType(String title){
  return GestureDetector(
    onTap: () {
     
    },
    child: SizedBox(
      width: MediaQuery.of(context).size.width-60,
      height: 130,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: const Color.fromRGBO(196, 114, 137, 0.8),
          borderRadius: BorderRadius.circular(40)
        ),
        child: Align(
          alignment: Alignment.center,
          child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w800,
                      fontFamily: "NoirPro",
                      height: 1,
                      letterSpacing: 1,
                      color: Colors.white
                      ),
                  ),
        ),
      ),
    ),
  );
}

  Widget header(String title){
    return Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w800,
              fontFamily: "NoirPro",
              height: 0.9,
              letterSpacing: 1,
              color: Color.fromRGBO(254, 222,181, 1)
              ),
          );
  }

}

class TextElement extends StatefulWidget {
  final String title;
  const TextElement({super.key,required this.title});

  @override
  State<TextElement> createState() => _TextElementState();
}

class _TextElementState extends State<TextElement> {

  double opacity=0;

  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 50)).then((value) => setState(() {
      opacity=1;
    }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      width:width-20,
      alignment: Alignment.center,
      child: Opacity(
        opacity: opacity,
        child: Text(
          widget.title,
          style: TextStyle(
            color: Colors.white,
            fontFamily: "NoirPro",
            fontSize: 25,
            fontWeight: FontWeight.w700
          ),
          ),
      )
      );
  }
}


class HistoryElement extends StatefulWidget {
  final HistoryModel model;
  final double topOffset;
  const HistoryElement({super.key,required this.model,required this.topOffset});

  @override
  State<HistoryElement> createState() => _HistoryElementState();
}

class _HistoryElementState extends State<HistoryElement> with TickerProviderStateMixin {

  double scale=0.21;
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

  favorite()async{
    await chatStore.updateFavoriteHistory(widget.model.messageId);
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    print(widget.model.favorite);
    double width=MediaQuery.of(context).size.width;
    return AnimatedPositioned(
      duration: Duration(seconds: 1),
      top: initOffset,
      left: right,
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => HistoryInfo(model: widget.model,)));
        },
        child: AnimatedBuilder(
          animation:_scaleAnimation,
          builder: (context, child) {
            return  Transform.scale(
                scale: _scaleAnimation.value,
                child: SizedBox(
                  height: 95,
                  width: width-20,
                  child:  Row(
                    children: [
                      Expanded(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: widget.model.type=="math"?Color.fromARGB(80, 196, 114, 137): const Color.fromRGBO(196, 114, 137, 0.8),
                            borderRadius: BorderRadius.circular(15),
                            border: widget.model.type=="math"?Border.all(color: const Color.fromRGBO(196, 114, 137, 0.8),width: 3):null
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: widget.model.type=="math"? MainAxisAlignment.center:MainAxisAlignment.start,
                                    children: [
                                      Builder(
                                        builder: (context) {
                                          String name="Неизвестно";
                                          if(widget.model.type=="reduce"){
                                            name="сокращение";
                                          }else if(widget.model.type=="math"){
                                            name="математика";
                                          }
                                          else if(widget.model.type=="generation"){
                                            name="генерация\nкартинки";
                                          }
                                          else if(widget.model.type=="essay"){
                                            name="сочинение";
                                          }
                                          else if(widget.model.type=="presentation"){
                                            name="презентация";
                                          }
                                          return Text(
                                          name,
                                          textAlign: TextAlign.left,
                                          style: const TextStyle(
                                            fontSize: 28,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: "NoirPro",
                                            height: 1,
                                            color: Color.fromRGBO(254, 222,181, 1)
                                            ),
                                                                              );
                                        }
                                      ),
                                    const SizedBox(height: 5,),
                                    if(widget.model.type!="math") RichText(
                                      text: TextSpan(
                                        children: [
                                          const TextSpan(
                                            text: "ТЕМА ",
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: "NoirPro",
                                              height: 1,
                                              color: Colors.white
                                              ),
                                          ),
                                          TextSpan(
                                            text:"\"${widget.model.theme.length>15?widget.model.theme.substring(0,12)+"...":widget.model.theme}\"",
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: "NoirPro",
                                              height: 1,
                                              letterSpacing: 1,
                                              color:Colors.white
                                              ),
                                          )
                                        ]
                                      ),
                                    )
                                    ],
                                  ),
                                  Align(
                                    alignment: Alignment.topCenter,
                                    child: SizedBox(
                                      width: 70,
                                      height: 80,
                                      child: Builder(
                                        builder: (context) {
                                          Widget wid = SvgPicture.asset("assets/svg/math.svg",fit: BoxFit.contain,color: Color.fromRGBO(254, 222,181, 1),);
                                          
                                          if(widget.model.type=="reduce"){
                                           wid= SvgPicture.asset("assets/svg/reduce.svg",fit: BoxFit.contain,color: Color.fromRGBO(254, 222,181, 1),);
                                            
                                          }else if(widget.model.type=="math"){
                                            wid=Image.asset("assets/png/math.png");
                                          }else if(widget.model.type=="essay"){
                                             wid=Image.asset("assets/png/essay.png");
                                          }
                                          else if(widget.model.type=="generation"){
                                            wid=Image.asset("assets/png/generation.png");
                                          }
                                          else if(widget.model.type=="generation"){
                                            wid=Image.asset("assets/png/generation.png");
                                          }
                                          else if(widget.model.type=="presentation"){
                                            wid=Image.asset("assets/png/presentation.png");
                                          }
                                          return wid;
                                        }
                                      )
                                    ),
                                  )
                                  // Container(
                                  //     width: 140,
                                  //     height: 60,
                                  //     color: Colors.amber,
                                  //     alignment: Alignment.centerRight,
                                  //     child:  widget.model.icon,
                                  //   ),
                                  
                                 
                                ],
                              ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: favorite,
                        child: Container(
                          color: const Color.fromARGB(0, 255, 193, 7),
                          width: 50,
                          child: Align(
                            alignment: Alignment.center,
                            child: SizedBox(
                              width: 25,
                              height: 25,
                              child: widget.model.favorite?Image.asset("assets/png/favorite.png",width: 50,height: 50,fit: BoxFit.cover,): SvgPicture.asset("assets/svg/saved_tab.svg",color: const Color.fromRGBO(254, 222,181, 1))
                            )
                          ),
                        ),
                      )
                    ],
                  ),
                  
                ),
              
            );
          }, 
        ),
      ),
    );
  }
}

class HistoryModel{
  String type;
  String theme;
  Widget icon;
  bool favorite;
  String progress;
  String messageId;
  String answer;
  Uint8List? answerBuffer;
  String answerMessageId;
  Uint8List? fileBuffer;
  String? reply;
  HistoryModel({
    required this.icon,
    required this.favorite,
    required this.theme,
    required this.type,
    required this.progress,
    required this.messageId,
    required this.answer,
    required this.answerMessageId,
    this.fileBuffer,
    this.reply,
    this.answerBuffer
  });
  Map<String,dynamic> toMap(){
    return {
      "favorite":favorite,
      "theme":theme,
      "type":type,
      "progress":progress,
      "messageId":messageId,
      "answer":answer,
      "answerMessageId":answerMessageId,
    };
  }
}

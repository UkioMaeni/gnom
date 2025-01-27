import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gnom/core/localization/localization_bloc.dart';
import 'package:gnom/core/tools/string_tool.dart';
import 'package:gnom/pages/chat_page/store/chat_store.dart';
import 'package:gnom/pages/main_page/tabs/history_tab/history_info.dart';
import 'package:uuid/uuid.dart';




class HistoryTab extends StatefulWidget {
  const HistoryTab({super.key});

  @override
  State<HistoryTab> createState() => _HistoryTabState();
}

class _HistoryTabState extends State<HistoryTab> with TickerProviderStateMixin {


  // late final AnimationController _heightController;
  // late final Animation<double> _height;
  double paddingOffset=50;
    List<Widget> widgets=[];

  String type="process";

  bool isGenerated=false;

  String generateVersion=Uuid().v4();
  void startGenerate()async{
    
    final currentGenerateVersion=Uuid().v4();
    generateVersion=currentGenerateVersion;
    if(!mounted){
      return;
    }
    isGenerated=true;
    String currentType=type;
    widgets=[];
    setState(() {
      
    });
    final histories= chatStore.history;
    final processList= histories.where((element) => element.progress==type).toList();
    //final completedList= histories.where((element) => element.progress=="completed").toList();
    print(processList.length);
    for(int i=0;i<processList.length;i++){
      if(!mounted || currentType!=type ||currentGenerateVersion!=generateVersion) return;
      setState(() {
        final state = (context.read<LocalizationBloc>().state as LocalizationLocaleState);
        widgets.add(
          HistoryElement(topOffset: (i)*105+paddingOffset+50, model:processList[i],)
        );
      });
      await Future.delayed(Duration(milliseconds: 300));
    }
    // for(int i=0;i<completedList.length;i++){
    //   if(!mounted) return;
    //   setState(() {
    //     final state = (context.read<LocalizationBloc>().state as LocalizationLocaleState);
    //     if(i==0){
    //       widgets.add(
    //       Positioned(
    //         top: (i+processList.length)*105+paddingOffset+50,
    //         child: TextElement(title: StringTools.firstUpperOfString(state.locale.done),)
    //       )
    //     );
    //     }
    //     widgets.add(
    //        HistoryElement(topOffset: (i+processList.length)*105+paddingOffset+100, model:completedList[i],)
    //     );
    //   });
    //   await Future.delayed(Duration(milliseconds: 300));
    // }
    isGenerated=false;
    startTask();
  }

  delete(){

  }

  List<TaskData> tasks=[];
  void startTask(){
    if(tasks.length!=0){
      var task= tasks[0].task;
      String currentTask=tasks[0].id;
      tasks=tasks.where((element) => element.id!=currentTask,).toList();
      task();
    }
  }

  @override
  void initState() {
    startGenerate();
    chatStore.historyEventHandler.listen((event) {
      if(event=="update"){
        final id=Uuid().v4();
        tasks.add(TaskData(id: id,task: startGenerate));
        if(isGenerated==false){
          startTask();
        }
      }
    },);
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
      child:  Column(
        children: [
          SizedBox(height: 20,),
          Container(
            height: 70,
            margin: EdgeInsets.only(right: 20),
            decoration: BoxDecoration(
              color: Color.fromARGB(64, 0, 0, 0),
              borderRadius: BorderRadius.circular(10)
            ),
            child: Builder(
              builder: (context) {
                final state = context.watch<LocalizationBloc>().state;
                return Row(
                  children: [
                    NavigationElement(
                      title: state.locale.done.toUpperCase(),
                      type: "completed",
                      currentType: type,
                      updater: () {
                        if(type=="completed") return;
                          setState(() {
                            type="completed";
                            startGenerate();
                          });
                        },
                      width: (MediaQuery.of(context).size.width-40)/3-10,
                    ),
                    Container(
                      width: 1,
                      margin: EdgeInsets.symmetric(vertical: 20),
                      color: Color.fromRGBO(254, 222,181, 1),
                    ),
                    NavigationElement(
                      title: state.locale.inProgress.toUpperCase(),
                      type: "process",
                      currentType: type,
                      updater: () {
                          setState(() {
                            type="process";
                            startGenerate();
                          });
                        },
                      width: (MediaQuery.of(context).size.width-40)/3+20-2,
                    ),
                    Container(
                      width: 1,
                      margin: EdgeInsets.symmetric(vertical: 20),
                      color: Color.fromRGBO(254, 222,181, 1),
                    ),
                    NavigationElement(
                      title: state.locale.error.toUpperCase(),
                      type: "error",
                      currentType: type,
                      updater: () {
                          setState(() {
                            type="error";
                            startGenerate();
                          });
                        },
                      width: (MediaQuery.of(context).size.width-40)/3-10,
                    ),
                  ],
                );
              }
            ),
          ),
          Expanded(
            child: Observer(
              builder: (context) {
               final history= chatStore.history;
                return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: SingleChildScrollView(
                      child:  SizedBox(
                          height: widgets.length*105+100,
                          child: Stack(
                            children: [
                              
                              for(int i=0;i<widgets.length;i++)widgets[i]
                            ],
                          ),
                        
                      ),
                      
                    
                  ),
                  // child: Observer(
                  //   builder: (context) {
                  //     final histories= chatStore.history;
                    
                  //     final processList= histories.where((element) => element.progress=="process").toList();
                  //     final completedList= histories.where((element) => element.progress=="completed").toList();
                  //     return ListView(
                  //       children: [
                
                  //       ],
                  //     );
                  //   }
                  // ),
                );
              }
            ),
          ),
        ],
      ),
    );
  }




//class NavigationElement ex


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
  

class NavigationElement extends StatelessWidget {
  final double width;
  final String title;
  final String type;
  final String currentType;
  final Function() updater;
  const NavigationElement({super.key,required this.title,required this.type,required this.currentType,required this.updater,required this.width});

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
                    onTap:updater,
                    child: Container(
                      width: width,
                      height: double.infinity,
                      alignment: Alignment.center,
                      color: Colors.transparent,
                      child:AnimatedDefaultTextStyle(
                        duration: Duration(milliseconds: 200),
                        style: TextStyle(
                          fontSize: currentType==type?16:13,
                          color:currentType==type? Color.fromRGBO(254, 222,181, 1):Color.fromRGBO(254, 222,181, 0.4)
                        ),
                        child: Text(
                          title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            
                            fontWeight: FontWeight.w800,
                            fontFamily: "NoirPro",
                            height: 1,
                            letterSpacing: 1,
                            ),
                        ),
                      ),
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


  class TaskData{
    String id;
    Function task;
    TaskData({
      required this.id,
      required this.task
    });
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
                            color:widget.model.progress=="error"?Color.fromARGB(45, 0, 0, 0): widget.model.type=="maths"?Color.fromARGB(80, 196, 114, 137): const Color.fromRGBO(196, 114, 137, 0.8),
                            borderRadius: BorderRadius.circular(15),
                            border: widget.model.type=="maths"?Border.all(color: const Color.fromRGBO(196, 114, 137, 0.8),width: 3):null
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Opacity(
                                    opacity: 1,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: widget.model.type=="maths"? MainAxisAlignment.center:MainAxisAlignment.start,
                                      children: [
                                        Builder(
                                          builder: (context) {
                                            final state = (context.watch<LocalizationBloc>().state as LocalizationLocaleState);
                                            String name=state.locale.error;
                                            if(widget.model.type=="reduce"){
                                              name=state.locale.shortcut;
                                            }else if(widget.model.type=="math"){
                                              name=state.locale.mathematics;
                                            }
                                            else if(widget.model.type=="referat"){
                                              name=state.locale.paper;
                                            }
                                            else if(widget.model.type=="generation"){
                                              name=state.locale.imageGeneration;
                                            }
                                            else if(widget.model.type=="essay"){
                                              name=state.locale.essay;
                                            }
                                            else if(widget.model.type=="presentation"){
                                              name=state.locale.presentation;
                                            }
                                            else if(widget.model.type=="parafrase"){
                                              name=state.locale.paraphrasing;
                                            }
                                            else if(widget.model.type=="sovet"){
                                              name=state.locale.adviseOn;
                                            }
                                            return Opacity(
                                              opacity: widget.model.progress=="error"?0.3:1,
                                              child: Text(
                                               StringTools.firstUpperOfString(name),
                                              textAlign: TextAlign.left,
                                              style: const TextStyle(
                                                fontSize: 28,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: "NoirPro",
                                                height: 1,
                                                color: Color.fromRGBO(254, 222,181, 1)
                                                ),
                                              ),
                                            );
                                          }
                                        ),
                                      const SizedBox(height: 5,),
                                      
                                      if(widget.model.type!="math") Builder(
                                        builder: (context) {
                                          final state = (context.watch<LocalizationBloc>().state as LocalizationLocaleState);
                                          return Opacity(
                                            opacity: widget.model.progress=="error"?0.3:1,
                                            child: RichText(
                                              text: TextSpan(
                                                children: [
                                                   TextSpan(
                                                    text: "${ StringTools.firstUpperOfString(state.locale.topic)} ",
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.w500,
                                                      fontFamily: "NoirPro",
                                                      height: 1,
                                                      color: Colors.white
                                                      ),
                                                  ),
                                                  TextSpan(
                                                    text:"\"${widget.model.question.length>10?widget.model.question.substring(0,10)+"...":widget.model.question}\"",
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
                                            ),
                                          );
                                        }
                                      ),
                                      if(widget.model.progress=="error")
                                        Container(
                                          margin: EdgeInsets.only(top: 5),
                                          padding: EdgeInsets.all(3),
                                          decoration: BoxDecoration(
                                            color: const Color.fromRGBO(196, 114, 137, 0.8),
                                            borderRadius: BorderRadius.circular(5)
                                          ),
                                          child: Builder(
                                            builder: (context) {
                                              final state = context.watch<LocalizationBloc>().state as LocalizationLocaleState;
                                              String name=state.locale.error;
                                              if(widget.model.type=="reduce"){
                                                name=state.locale.error;
                                              }else if(widget.model.type=="math"){
                                                name=state.locale.mathError;
                                              }
                                              else if(widget.model.type=="referat"){
                                                name=state.locale.reportError;
                                              }
                                              else if(widget.model.type=="generation"){
                                                name=state.locale.error;
                                              }
                                              else if(widget.model.type=="essay"){
                                                name=state.locale.essayError;
                                              }
                                              else if(widget.model.type=="presentation"){
                                                name=state.locale.presentationError;
                                              }
                                              else if(widget.model.type=="parafrase"){
                                                name=state.locale.error;
                                              }
                                              else if(widget.model.type=="sovet"){
                                                name=state.locale.error;
                                              }
                                              return Text(
                                                 name,
                                                textAlign: TextAlign.left,
                                                style: const TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: "NoirPro",
                                                  height: 1,
                                                  color: Color.fromRGBO(254, 222,181, 1)
                                                  ),
                                                );
                                            }
                                          ),
                                        ),
                                      ],
                                    ),
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
                                           wid= Image.asset("assets/png/reduce1.png",fit: BoxFit.contain,);
                                            
                                          }else if(widget.model.type=="math"){
                                            wid=Image.asset("assets/png/math.png");
                                          }else if(widget.model.type=="referat"){
                                            wid=Image.asset("assets/png/referer.png",fit: BoxFit.contain,);
                                          }
                                          else if(widget.model.type=="essay"){
                                             wid=Image.asset("assets/png/essay.png");
                                          }
                                          
                                          else if(widget.model.type=="parafrase"){
                                            wid=Image.asset("assets/png/paraphrase1.png",fit: BoxFit.contain,);
                                          }
                                          else if(widget.model.type=="generation"){
                                            wid=Image.asset("assets/png/generation.png");
                                          }
                                          else if(widget.model.type=="sovet"){
                                            wid=Image.asset("assets/png/sovet.png",fit: BoxFit.contain,);
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
                              child: widget.model.favorite?SvgPicture.asset("assets/svg/isFavorite.svg",color: const Color.fromRGBO(254, 222,181, 1), width: 50,height: 50,fit: BoxFit.cover,): SvgPicture.asset("assets/svg/saved_tab.svg",color: const Color.fromRGBO(254, 222,181, 1))
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
  bool QisDocument;
  bool AisDocument;
  String question;
  String Qpath;
  String Apath;
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
    required this.question,
    required this.type,
    required this.progress,
    required this.messageId,
    required this.answer,
    required this.answerMessageId,
    this.fileBuffer,
    this.reply,
    this.answerBuffer,
    required this.QisDocument,
    required this.AisDocument,
    required this.Qpath,
    required this.Apath

  });
  Map<String,dynamic> toMap(){
    return {
      "favorite":favorite.toString(),
      "question":question,
      "qpath":Qpath,
      "apath":Apath,
      "qisDocument":QisDocument.toString(),
      "aisDocument":AisDocument.toString(),
      "type":type,
      "progress":progress,
      "messageId":messageId,
      "answer":answer,
      "fileBuffer":fileBuffer,
      "answerMessageId":answerMessageId,
    };
  }
}

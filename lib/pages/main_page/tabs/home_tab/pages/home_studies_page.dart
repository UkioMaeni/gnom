import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gnom/core/localization/localization_bloc.dart';
import 'package:gnom/core/tools/string_tool.dart';
import 'package:gnom/pages/chat_page/chat_page.dart';
import 'package:gnom/pages/transaction_page/transaction_page.dart';

class HOMEStudiesPage extends StatefulWidget {
  final Function(String) update;
  const HOMEStudiesPage({super.key,required this.update});

  @override
  State<HOMEStudiesPage> createState() => _HOMEStudiesPageState();
}

class _HOMEStudiesPageState extends State<HOMEStudiesPage> {



  List<StudiesModel> stadies=[
    StudiesModel(sub: "РЕЗУЛЬТАТ В ТЕЧЕНИЕ 20 СЕК.",title: "МАТЕМАТИКА",type: EChatPageType.math,icon: SvgPicture.asset("assets/svg/math.svg",fit: BoxFit.contain,)),
    StudiesModel(sub: "РЕЗУЛЬТАТ В ТЕЧЕНИЕ 5 МИНУТ",title: "РЕФЕРАТ",type: EChatPageType.referat,icon: Image.asset("assets/png/referer.png",fit: BoxFit.contain,)),
    StudiesModel(sub: "РЕЗУЛЬТАТ В ТЕЧЕНИЕ 3 МИНУТ",title: "СОЧИНЕНИЕ",type: EChatPageType.essay,icon: Image.asset("assets/png/essay.png",fit: BoxFit.contain,)),
    StudiesModel(sub: "РЕЗУЛЬТАТ В ТЕЧЕНИЕ 5 МИНУТ.",title: "ПРЕЗЕНТАЦИЯ",type: EChatPageType.presentation,icon: Image.asset("assets/png/presentation.png",fit: BoxFit.contain,)),
    StudiesModel(sub: "РЕЗУЛЬТАТ В ТЕЧЕНИЕ 30 СЕК.",title: "СОКРАЩЕНИЕ",type: EChatPageType.reduce,icon: Image.asset("assets/png/reduce1.png",fit: BoxFit.contain,)),
    StudiesModel(sub: "РЕЗУЛЬТАТ В ТЕЧЕНИЕ 30 СЕК.",title: "ПЕРЕФРАЗИРОВАНИЕ",type: EChatPageType.parafrase,icon: Image.asset("assets/png/paraphrase1.png",fit: BoxFit.contain,)),
    StudiesModel(sub: "РЕЗУЛЬТАТ В ТЕЧЕНИЕ 10 СЕК",title: "ДАЙ СОВЕТ",type: EChatPageType.sovet,icon: Image.asset("assets/png/sovet.png",fit: BoxFit.contain,)),
  ];

  List<Widget> widgets=[];

  startGenerate()async{
    for(int i=0;i<stadies.length;i++){
      setState(() {
        if(!mounted) return;
        widgets.add(
           StudiesElement(topOffset: (i)*105+30, model:stadies[i],)
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
    });
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          SizedBox(height: 50,),
          GestureDetector(
            onTap: ()=>widget.update("/init"),
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
                Builder(
                  builder: (context) {
                    final state = (context.watch<LocalizationBloc>().state as LocalizationLocaleState);
                    return Text(
                       StringTools.firstUpperOfString(state.locale.education),
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
            child: ListView(
                  children: [
                    for(int i=0;i<widgets.length;i++)widgets[i]
                  ],
                ),
            
          ),
        ],
      ),
    );
  }
}


class StudiesModel{
  EChatPageType type;
  String title;
  String sub;
  Widget icon;
  StudiesModel({
    required this.icon,
    required this.title,
    required this.sub,
    required this.type,
  });
}

class StudiesElement extends StatefulWidget {
  final StudiesModel model;
  final double topOffset;
  const StudiesElement({super.key,required this.model,required this.topOffset});

  @override
  State<StudiesElement> createState() => _StudiesElementState();
}

class _StudiesElementState extends State<StudiesElement> with TickerProviderStateMixin {

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



  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    return  GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => TransactionPage(type: widget.model.type,model:widget.model),));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: AnimatedBuilder(
            animation:_scaleAnimation,
            builder: (context, child) {
              return  Transform.scale(
                  scale: _scaleAnimation.value,
                  child: SizedBox(
                    height: 95,
                    width: width-40,
                    child:  Row(
                      children: [
                        Expanded(
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(196, 114, 137, 0.8),
                              borderRadius: BorderRadius.circular(15)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                     Align(
                                      alignment: Alignment.topCenter,
                                      child: SizedBox(
                                        width: 70,
                                        height: 80,
                                        child: widget.model.icon
                                      ),
                                    ),
                                    SizedBox(width: 20,),
                                    Builder(
                                      builder: (context) {
                                        final state = (context.watch<LocalizationBloc>().state as LocalizationLocaleState);
                                        String title= state.locale.error;
                                        String  sub=state.locale.error;
                                        if(widget.model.type.name=="reduce"){
                                           title= state.locale.shortcut;
                                           sub = state.locale.result_30s;
                                          }else if(widget.model.type.name=="math"){
                                            title=state.locale.mathematics;
                                            sub = state.locale.result_20s;
                                          }else if(widget.model.type.name=="referat"){
                                            title=state.locale.paper;
                                            sub = state.locale.result_30s;
                                            
                                          }
                                          else if(widget.model.type.name=="essay"){
                                             title=state.locale.essay;
                                             sub = state.locale.result_3m;
                                          }
                                          
                                          else if(widget.model.type.name=="parafrase"){
                                            title=state.locale.paraphrasing;
                                            sub = state.locale.result_30s;
                                          }
                                          else if(widget.model.type.name=="generation"){
                                            title=state.locale.imageGeneration;
                                            sub = state.locale.result_30s;
                                          }
                                          else if(widget.model.type.name=="sovet"){
                                            title=state.locale.adviseOn;
                                            sub = state.locale.result_20s;
                                          }
                                          else if(widget.model.type.name=="presentation"){
                                            title=state.locale.presentation;
                                            sub = state.locale.result_5m;
                                          }
                                        return Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                             StringTools.firstUpperOfString(title),
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w800,
                                              fontFamily: "NoirPro",
                                              height: 1,
                                              color: Color.fromRGBO(254, 222,181, 1)
                                              ),
                                          ),
                                          const SizedBox(height: 5,),
                                          Text(
                                             StringTools.firstUpperOfString(sub),
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: "NoirPro",
                                              height: 1,
                                              color: Colors.white
                                              ),
                                          ),
                                          ],
                                        );
                                      }
                                    ),
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
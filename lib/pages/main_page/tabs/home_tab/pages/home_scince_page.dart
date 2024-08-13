import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gnom/pages/chat_page/chat_page.dart';
import 'package:gnom/pages/mini_game/mini_game.dart';

class HOMEScincePage extends StatefulWidget {
  final Function(String) update;
  const HOMEScincePage({super.key,required this.update});

  @override
  State<HOMEScincePage> createState() => _HOMEScincePageState();
}

class _HOMEScincePageState extends State<HOMEScincePage> {



  List<ScinceModel> stadies=[
    ScinceModel(title: "ГЕНЕРАЦИЯ\nКАРТИНКИ",icon: Image.asset("assets/png/generation.png",fit: BoxFit.contain,)),
    ScinceModel(title: "МИНИ\nИГРА",icon: Image.asset("assets/png/mini_game.png",fit: BoxFit.contain,)),
  ];

  List<Widget> widgets=[];

  startGenerate()async{
    for(int i=0;i<stadies.length;i++){
      setState(() {
        widgets.add(
           ScinceElement(topOffset: (i)*105+30, model:stadies[i],)
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
                Text(
                  "Учеба",
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
    );
  }
}


class ScinceModel{
  String title;
  Widget icon;
  ScinceModel({
    required this.icon,
    required this.title,
  });
}

class ScinceElement extends StatefulWidget {
  
  final ScinceModel model;
  final double topOffset;
  const ScinceElement({super.key,required this.model,required this.topOffset});

  @override
  State<ScinceElement> createState() => _ScinceElementState();
}

class _ScinceElementState extends State<ScinceElement> with TickerProviderStateMixin {

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
        if(widget.model.title=="ГЕНЕРАЦИЯ\nКАРТИНКИ"){
          Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage(type: EChatPageType.generation,title:widget.model.title),));
        }else{
          Navigator.push(context, MaterialPageRoute(builder: (context) => MiniGame(),));
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: AnimatedBuilder(
            animation:_scaleAnimation,
            builder: (context, child) {
              return  Transform.scale(
                  scale: _scaleAnimation.value,
                  child: SizedBox(
                    height: 140,
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
                                        width: 90,
                                        height: 140,
                                        child: widget.model.icon
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                          widget.model.title,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontSize: 26,
                                            fontWeight: FontWeight.w800,
                                            fontFamily: "NoirPro",
                                            height: 1,
                                            color: Color.fromRGBO(254, 222,181, 1)
                                            ),
                                        ),
                                        const SizedBox(height: 5,),
                                        
                                        ],
                                      ),
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
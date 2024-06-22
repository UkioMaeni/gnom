import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gnom/pages/chat_page/store/chat_store.dart';

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
            child: TextElement(title: "ГОТОВО",)
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

  favorite(){
   
  }

  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    return AnimatedPositioned(
      duration: Duration(seconds: 1),
      top: initOffset,
      left: right,
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
                          color: const Color.fromRGBO(196, 114, 137, 0.8),
                          borderRadius: BorderRadius.circular(15)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                    widget.model.type,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "NoirPro",
                                      height: 1,
                                      color: Color.fromRGBO(254, 222,181, 1)
                                      ),
                                  ),
                                  const SizedBox(height: 5,),
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        const TextSpan(
                                          text: "ТЕМА ",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: "NoirPro",
                                            height: 1,
                                            color: Colors.white
                                            ),
                                        ),
                                        TextSpan(
                                          text:"\"${widget.model.theme}\"",
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
                                    child: SvgPicture.asset("assets/svg/math.svg",fit: BoxFit.contain,)
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
                            child: SvgPicture.asset("assets/svg/saved_tab.svg",color: const Color.fromRGBO(254, 222,181, 1),)
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
  HistoryModel({
    required this.icon,
    required this.favorite,
    required this.theme,
    required this.type,
    required this.progress,
    required this.messageId
  });
}
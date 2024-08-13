import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gnom/pages/main_page/tabs/profile_tab/components/plaining_subcribtion/animations_planings.dart';
import 'package:gnom/pages/main_page/tabs/profile_tab/components/profile_requests_diagramm.dart';
import 'package:gnom/store/user_store.dart';

class DiagramInfo extends StatefulWidget {
  final Function() close;
  final int openTypeIndex;
  final RequestsCount requestsCount;
  const DiagramInfo({super.key,required this.close,required this.openTypeIndex,required this.requestsCount});

  @override
  State<DiagramInfo> createState() => _DiagramInfoState();
}

class _DiagramInfoState extends State<DiagramInfo> with SingleTickerProviderStateMixin {


  late int maxValue;
  List<int> req=[];
  double currentHeight=0;

  late final AnimationController _scaleController;
  late Animation<double> _scaleAnimation;
  get _height => MediaQuery.of(context).size.height;

  @override
  void initState() {
    _scaleController=AnimationController(vsync: this,duration: Duration(milliseconds: 300));
    _scaleAnimation=Tween<double>(begin: 0,end: 1).animate(_scaleController);
    _scaleController.forward();
    maxValue=widget.requestsCount.maxValue;
     req.add(widget.requestsCount.math);
     req.add(widget.requestsCount.referre);
     req.add(widget.requestsCount.essay);
     req.add(widget.requestsCount.presentation);
     req.add(widget.requestsCount.reduction);
     req.add(widget.requestsCount.paraphrase);
     req.add(widget.requestsCount.sovet);
     req.add(widget.requestsCount.generation);
     WidgetsBinding.instance.addPostFrameCallback((_){
      setState(() {
        currentHeight=_height;
      });
     });
    super.initState();
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("start");
    return SizedBox(
      height:_height,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: () {
                print("object");
                widget.close();
              },
              onVerticalDragUpdate: (details) {
                
              },
              child: ColoredBox(
                color: Color.fromARGB(113, 0, 0, 0),
              ),
            ),
          ),
          Positioned(
            top: 150,
            left: 20,
            right: 20,
            child: AnimatedBuilder(
              animation: _scaleAnimation,
              builder: (context,_) {
                return Transform.scale(
                  scale: _scaleAnimation.value,
                  child: Opacity(
                    opacity: _scaleAnimation.value,
                    child: SizedBox(
                      height:currentHeight,
                      child: Column(
                          children: [
                           miniDiagram(req),
                           SizedBox(height: 10,),
                           Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width-80,
                            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                            decoration: BoxDecoration(
                              color: Color.fromARGB(204, 194, 145, 159),
                              borderRadius: BorderRadius.circular(25)
                            ),
                            child: Column(
                              children: [
                                punkt("Математика",1),
                                punkt("Реферат",2),
                                punkt("Сочинение",3),
                                punkt("Презентация",4),
                                punkt("Сокращение",5),
                                punkt("Перефразирование",6),
                                punkt("Дай совет",7),
                                punkt("Генерация картинки",8)
                              ],
                            ),
                           )
                          ],
                        ),
                    ),
                  ),
                );
              }
            ),
          ),
          
          // Positioned(
          //   bottom: 86,
          //   left: 20,
          //   child: FirstElementPlaning(onTap: (_){},)
          // )
        ],
      ),
    );
  }

  

  Widget punkt(String title,int number){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: SizedBox(
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 2),
              width: 30,
              height: 30,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: const Color.fromRGBO(254, 222,181, 1),
                  width: 4
                )
              ),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  (number).toString(),
                  style: TextStyle(
                    fontFamily: "NoirPro",
                    color: Colors.white,
                    height: 1,
                    fontWeight: FontWeight.w600,
                    fontSize: 14
                  ),
                )
              ),
          ),
          SizedBox(width: 10,),
          Text(
                  title,
                  style: TextStyle(
                    fontFamily: "NoirPro",
                    color: Colors.white,
                    height: 1,
                    fontWeight: FontWeight.w500,
                    fontSize: 14
                  ),
            )
          ],
        ),
      ),
    );
  }


  Widget miniDiagram(List<int> req){
    return Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Color.fromARGB(204, 194, 145, 159)
                    ),
                    height: 200,
                    width: double.infinity,
                    child: Column(
                      children: [
                        SizedBox(height: 10,),
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                             mainAxisAlignment: MainAxisAlignment.spaceAround,
                             children:[
                                for(int i=0;i<req.length;i++)
                                Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    req[i].toString(),
                                    style: TextStyle(
                                      fontFamily: "NoirPro",
                                      color: Colors.white,
                                      height: 1,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14
                                    ),
                                  ),
                                  SizedBox(height: 3,),
                                  SizedBox(
                                    height: 80,
                                    width: 35,
                                    child: Stack(
                                      children: [
                                        
                                        
                                        
                                    Positioned(
                                      top: 11,
                                      child: Container(
                                          width: 35,
                                          height:(80/maxValue)*req[i],
                                          decoration: BoxDecoration(
                                            color: interpolateColor(req[i].toDouble())
                                          ),
                                      ),
                                    ),
                                    Positioned(
                                          top: 0.2,
                                          child: CustomPaint(
                                          painter: EquilateralTrianglePainter(color:interpolateColor(req[i].toDouble()),reverse:false),
                                          size: Size(35, 11),
                                                                            ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  
                                  SizedBox(
                                    width: 35,
                                    height: 10,
                                    child: Transform.rotate(
                                      angle: pi,
                                      child: CustomPaint(
                                        painter: EquilateralTrianglePainter(color:interpolateColor(req[i].toDouble()),reverse:false),
                                      ),
                                    ),
                                  ),
                                  Container(
                                      width: 30,
                                      height: 30,
                                      margin: EdgeInsets.only(top: 5),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(
                                          color: const Color.fromRGBO(254, 222,181, 1),
                                          width: 4
                                        )
                                      ),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          (i+1).toString(),
                                          style: TextStyle(
                                            fontFamily: "NoirPro",
                                            color: Colors.white,
                                            height: 1,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14
                                          ),
                                        )
                                      ),
                                  )
                                ],
                              )
                            ]
                            
                          ),
                        ),
                        SizedBox(height: 20,)
                      ],
                    )
                  );
  }
  Color interpolateColor(double value) {
  if (value < 0) {
    value = 0;
  } else if (value > maxValue) {
    value = maxValue.toDouble();
  }
//255,88,0
  double normalizedValue = value / maxValue;
  double red = 234+ (255-234)*(normalizedValue) ;
  double green = 88+(213-88)*(1-normalizedValue);
  double blue = 0+ 26*(1-normalizedValue);
  Color.fromRGBO(234, 213, 26,1);
  print(255);
  return Color.fromRGBO(red.toInt(), green.toInt(), blue.toInt(),1);
}
}

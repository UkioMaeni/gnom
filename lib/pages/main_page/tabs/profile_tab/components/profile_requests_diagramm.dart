import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gnom/store/user_store.dart';

class ProfileRequestsDiagramm extends StatefulWidget {
  final RequestsCount requestsCount;
  final Function() setOpen;
  const ProfileRequestsDiagramm({super.key,required this.requestsCount,required this.setOpen});

  @override
  State<ProfileRequestsDiagramm> createState() => _ProfileRequestsDiagrammState();
}

class _ProfileRequestsDiagrammState extends State<ProfileRequestsDiagramm> with TickerProviderStateMixin {

  late final AnimationController _opacityController;
  late final AnimationController _scaleController;
  late final Animation<double> _opacityAnimation;
  late final Animation<double> _scaleAnimation;

  //mockked
  List<int> req=[];

  int maxValue=0;
  @override
  void initState() {
    _opacityController=AnimationController(
    vsync: this,
    duration: Duration(milliseconds: 300)
   );
   _scaleController=AnimationController(
    vsync: this,
    duration: Duration(milliseconds: 400)
   );
   _opacityAnimation=Tween<double>(begin: 0.2,end: 1).animate(_opacityController);
   _scaleAnimation=Tween<double>(begin: 0.2,end: 1).animate(_scaleController);
   _scaleController.forward();
   _opacityController.forward();
     maxValue = widget.requestsCount.maxValue;
     req.add(widget.requestsCount.math);
     req.add(widget.requestsCount.referre);
     req.add(widget.requestsCount.essay);
     req.add(widget.requestsCount.presentation);
     req.add(widget.requestsCount.reduction);
     req.add(widget.requestsCount.paraphrase);
     req.add(widget.requestsCount.sovet);
     req.add(widget.requestsCount.generation);
    super.initState();
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _opacityController.dispose();
    super.dispose();
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


  @override
  Widget build(BuildContext context) {
    print(maxValue);
    return GestureDetector(
      onTap: widget.setOpen,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: AnimatedBuilder(
              animation: _opacityAnimation,
              builder: (context,_) {
                return Opacity(
                  opacity: _opacityAnimation.value,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: const Color.fromRGBO(196, 114, 137, 0.8)
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
                                      top: 11+(80/maxValue)*(maxValue- req[i].clamp(6,2000).toDouble()),
                                      child: Container(
                                          width: 35,
                                          height:(80/maxValue)*req[i].clamp(6,2000),
                                          decoration: BoxDecoration(
                                            color: interpolateColor(req[i].toDouble())
                                          ),
                                      ),
                                    ),
                                    Positioned(
                                          top: 0.2+ (80/maxValue)*(maxValue- req[i].clamp(6,2000) .toDouble()),
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
                  ),
                );
              }
            ),
            );
        },
        
      ),
    );
  }



  Widget diagrammRequests(double percent){
    return Container(
      width: 100,
      height: 100,
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        gradient: LinearGradient(colors: [Colors.yellow,Colors.red],transform: GradientRotation(pi/4))
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 60,
            height: 60,
            child: CustomPaint(
              painter: ArcPainter(percent:percent),
            ),
          ),
           Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            color: Color.fromARGB(255, 196, 114, 137)
          ),
        ),
        ],
        
      ),
    );
  }
}

class ArcPainter extends CustomPainter {
  late double percent;
  double startAngle=0;
  double endAngle=0;
  ArcPainter({required double percent}){
    endAngle=percent*360;
    startAngle=270-percent*360;
  }
  double radius = 50;
  Color color = Color.fromARGB(255, 94, 94, 94);
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(size.width / 2, size.height / 2)
      ..arcTo(
          Rect.fromCircle(
              center: Offset(size.width / 2, size.height / 2),
              radius: radius),
          startAngle / 360 * 2 * pi,
          endAngle / 360 * 2 * pi,
          false);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}




class EquilateralTrianglePainter extends CustomPainter {
  final Color color;
  final bool reverse;
  EquilateralTrianglePainter({required this.color,required this.reverse});
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;

    final path = Path();
    if(reverse){
      path.moveTo(0, size.height); // Перевернутая вершина
      path.lineTo(size.width / 2, size.height);
      path.lineTo(size.width, size.height);
    }else{
      path.moveTo(size.width / 2, 0);
      path.lineTo(0, size.height);
      path.lineTo(size.width, size.height);
      path.close();
    }
    

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
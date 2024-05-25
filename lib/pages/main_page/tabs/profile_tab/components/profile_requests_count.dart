import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gnom/store/user_store.dart';

class ProfileRequestCount extends StatefulWidget {
  final RequestsCount requestsCount;
  const ProfileRequestCount({super.key,required this.requestsCount});

  @override
  State<ProfileRequestCount> createState() => _ProfileRequestCountState();
}

class _ProfileRequestCountState extends State<ProfileRequestCount> with SingleTickerProviderStateMixin {

  late final AnimationController _scaleController;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
   _scaleController=AnimationController(
    vsync: this,
    duration: Duration(milliseconds: 400)
   );
   _scaleAnimation=Tween<double>(begin: 0.2,end: 1).animate(_scaleController);
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
    
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Opacity(
            opacity: _scaleAnimation.value,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: const Color.fromRGBO(196, 114, 137, 0.8)
                  ),
                  height: 180,
                  width: double.infinity,
                  child: Row(
                    children: [
                      SizedBox(width: 15,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "ОБЩИЙ",
                            style: TextStyle(
                              fontFamily: "NoirPro",
                              color: Color.fromRGBO(254, 222,181, 1),
                              height: 1,
                              fontWeight: FontWeight.w800,
                              fontSize: 25
                            ),
                            ),
                            Text(
                            "ОСТАТОК ЗАПРОСОВ",
                            style: TextStyle(
                              fontFamily: "NoirPro",
                              color: Color.fromRGBO(254, 222,181, 1),
                              height: 1.4,
                              fontWeight: FontWeight.w600,
                              fontSize: 17
                            ),
                            ),
                            SizedBox(height: 10,),
                            ClipOval(
                              child: Container(
                                  width: 120,
                                  height: 70,
                                  decoration: BoxDecoration(
                                    color: Colors.grey
                                    
                                  ),
                                  alignment: Alignment.center,
                                  child: ClipOval(
                                    child: Container(
                                      width: 118,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        color: const Color.fromRGBO(196, 114, 137, 0.85),
                                        
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        widget.requestsCount.summary.toString(),
                                        style: TextStyle(
                                          fontFamily: "NoirPro",
                                          color: Colors.white,
                                          height: 1.4,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 40
                                        ),
                                        ),
                                    ),
                                  ),
                              ),
                            )
                        ],
                      ),
                    ],
                  )
                ),
                Positioned(
                  bottom: -1,
                  right: -30,
                  child: Transform.rotate(
                    angle: 3*pi/4,
                    child: Container(
                      width: 160,
                      height: 5,
                      color: Colors.yellow,
                    ),
                  )
                ),
                Positioned(
                  bottom: -1,
                  right: -40,
                  child: Transform.rotate(
                    angle: 3*pi/4,
                    child: Container(
                      width: 270,
                      height: 7,
                      color: Colors.orange,
                    ),
                  )
                ),
                Positioned(
                  bottom: -1,
                  right: -70,
                  child: Transform.rotate(
                    angle: 3*pi/4,
                    child: Container(
                      width: 420,
                      height: 9,
                      color: const Color.fromARGB(255, 212, 57, 45),
                    ),
                  )
                )
              ],
            ),
          ),
          );
      },
      
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
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileListFriends extends StatefulWidget {
  const ProfileListFriends({super.key});

  @override
  State<ProfileListFriends> createState() => _ProfileListFriendsState();
}

class _ProfileListFriendsState extends State<ProfileListFriends> with TickerProviderStateMixin {

  late final AnimationController _opacityController;
  late final AnimationController _scaleController;
  late final Animation<double> _opacityAnimation;
  late final Animation<double> _scaleAnimation;

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
    super.initState();
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _opacityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: AnimatedBuilder(
            animation: _opacityAnimation,
            builder: (context, child) {
              return Opacity(
                opacity:_opacityAnimation.value,
                child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: const Color.fromRGBO(196, 114, 137, 0.8)
                ),
                height: 80,
                width: 300,
                child: Row(
                  children: [
                    SizedBox(width: 15,),
                    SizedBox(
                      width: 70,
                      child: SvgPicture.asset("assets/svg/friends.svg",color: Color.fromRGBO(254, 222,181, 1),)
                    ),
                    Expanded(child: SizedBox.shrink()),
                     Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "СПИСОК",
                            style: TextStyle(
                              fontFamily: "NoirPro",
                              color: Color.fromRGBO(254, 222,181, 1),
                              height: 1,
                              fontWeight: FontWeight.w700,
                              fontSize: 25
                            ),
                        ),
                        Text(
                            "ДРУЗЕЙ",
                            style: TextStyle(
                              fontFamily: "NoirPro",
                              color: Colors.white,
                              height: 1,
                              fontWeight: FontWeight.w500,
                              fontSize: 25
                            ),
                        ),
                        ],
                      
                    ),
                    Expanded(child: SizedBox.shrink()),
                    
                  ],
                )
                            ),
              );
            },
            
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
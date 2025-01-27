import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gnom/core/localization/localization_bloc.dart';
import 'package:gnom/core/tools/string_tool.dart';
import 'package:gnom/pages/main_page/tabs/profile_tab/components/plaining_subcribtion/animations_planings.dart';
import 'package:gnom/pages/main_page/tabs/profile_tab/profile_tab.dart';
import 'package:gnom/store/user_store.dart';

class ProfileplaningSubcribtion extends StatefulWidget {
  final RequestsCount requestsCount;
  final Function(int) setOpen;
  final ScrollController controller;
  const ProfileplaningSubcribtion({super.key,required this.requestsCount,required this.setOpen,req,required this.controller});

  @override
  State<ProfileplaningSubcribtion> createState() => _ProfileplaningSubcribtionState();
}

class _ProfileplaningSubcribtionState extends State<ProfileplaningSubcribtion> with TickerProviderStateMixin {

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

  double normalizedValue =value / maxValue;

  double red = 255 ;
  double green = 255 *(normalizedValue);
  double blue = 0;
  return Color.fromRGBO(red.toInt(), green.toInt(), blue.toInt(),1);
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
            builder: (context,_) {
              return Opacity(
                opacity: _opacityAnimation.value,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: const Color.fromRGBO(196, 114, 137, 0.8)
                  ),
                  height: 200,
                  width: double.infinity,
                  child: Column(
                    children: [
                      SizedBox(height: 10,),
                      Builder(
                        builder: (context) {
                          final state = (context.watch<LocalizationBloc>().state as LocalizationLocaleState);
                          return Text(
                            StringTools.firstUpperOfString(state.locale.subscriptionPlan),
                            style: TextStyle(
                              fontFamily: "NoirPro",
                              color: Color.fromRGBO(254, 222,181, 1),
                              height: 1,
                              fontWeight: FontWeight.w700,
                              fontSize: 25
                            ),
                          );
                        }
                      ),
                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FirstElementPlaning(
                            color: Colors.amber,
                            price: prices[0],
                            scaleView: 1,
                            onTap:(_)async{
                            print(widget.controller.offset);
                            await widget.controller.animateTo(300, duration: Duration(milliseconds: 300), curve: Curves.linear);
                            widget.setOpen(1);
                          }),
                          FirstElementPlaning(
                            price: prices[1],
                            color: Colors.amber,
                            scaleView: 1.3,
                            onTap:(_)async{
                            print(widget.controller.offset);
                            await widget.controller.animateTo(300, duration: Duration(milliseconds: 300), curve: Curves.linear);
                            widget.setOpen(2);
                          }),
                          FirstElementPlaning(
                            price: prices[2],
                            color: Colors.amber,
                            scaleView: 1,
                            onTap:(_)async{
                            print(widget.controller.offset);
                            await widget.controller.animateTo(300, duration: Duration(milliseconds: 300), curve: Curves.linear);
                            widget.setOpen(3);
                          }),
                        ],
                      )
                    ],
                  )
                ),
              );
            }
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
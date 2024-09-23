import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


enum EChevronType{
  left,right
}

class UIChevron extends StatefulWidget {
  final EChevronType type;
  final Function() onClick;
  const UIChevron({
    required this.type,
    required this.onClick,
    super.key
    });

  @override
  State<UIChevron> createState() => _UIChevronState();
}

class _UIChevronState extends State<UIChevron> with SingleTickerProviderStateMixin{

  late AnimationController _scaleController;
   late Animation<double> _scale;

  onClick(){
    _scaleController.forward().then((value) => _scaleController.reverse());
    widget.onClick();
  }

  @override
  void initState() {
   _scaleController=AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this
   );
   _scale=Tween<double>(begin: 0,end: 1).animate(_scaleController);
   
    super.initState();
  }
  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Matrix4 transform = Matrix4.identity();
    if(widget.type==EChevronType.left){
      transform.scale(-1.0, 1.0);
    }
    return AnimatedBuilder(
      animation: _scaleController,
      builder: (context,_) {
        return GestureDetector(
          onTap: onClick,
          child: Container( 
            color: Colors.transparent,
            height: 80,
            width: 60,
            child: Align(
              alignment:Alignment.center,
              child: Transform(
                alignment: Alignment.center,
                transform: transform,
                child: SvgPicture.asset("assets/svg/chevron_right.svg",height: 25+_scale.value*5,width: 25+_scale.value*5,)
              )
            ),
          ),
        );
      }
    );
  }
}


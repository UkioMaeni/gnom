import 'package:flutter/material.dart';

class HOMEInitPage extends StatefulWidget {
  final Function(String) update;
  const HOMEInitPage({super.key,required this.update});

  @override
  State<HOMEInitPage> createState() => _HOMEInitPageState();
}

class _HOMEInitPageState extends State<HOMEInitPage> with TickerProviderStateMixin{

  late final AnimationController _scaleController;
  late final AnimationController _heightController;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _heightAnimation;

  

  double heightUpdate=130;
  double widthUpdate=0;
  Color color=const Color.fromRGBO(196, 114, 137, 0.8);
  Color bgColor=Color.fromRGBO(0, 0, 0, 0.0);
  Color textColor=Colors.white;
  bool isOpenInfo=false;

    void openInfo(){
    setState(() {
      _scaleController.forward().then((value){
        _scaleController.reverse();
        _heightController.forward();
        heightUpdate=350;
      });
      
      widthUpdate=MediaQuery.of(context).size.width-10;
      Future.delayed(const Duration(milliseconds: 200)).then((value) => setState(() {
          widthUpdate=MediaQuery.of(context).size.width-60;
      }));
      color=const Color.fromRGBO(92, 90, 90, 0.8);
      bgColor=Color.fromRGBO(0, 0, 0, 0.884);
      textColor=const Color.fromRGBO(254, 222,181, 1);
      isOpenInfo=true;
    });
  }

  void closeInfo(){
    setState(() {
      _heightController.reverse();
      heightUpdate=130;
      widthUpdate==MediaQuery.of(context).size.width-60;
      color=const Color.fromRGBO(196, 114, 137, 0.8);
      bgColor=Color.fromRGBO(0, 0, 0, 0.0);
      textColor=Colors.white;
      isOpenInfo=false;
    });
  }
  @override
  void dispose() {
    _scaleController.dispose();
    _heightController.dispose();
    super.dispose();
  }
  // late final AnimationController _heightController;
  // late final Animation<double> _height;
  @override
  void initState() {
    // _heightController=AnimationController(
    //   duration: const Duration(milliseconds: 1000),
    //   vsync: this
    // );
    // _height=Tween<double>(begin: 0,end:  200).animate(_heightController);
   _scaleController =AnimationController(
    vsync: this,
    duration: Duration(milliseconds: 200)
  );
  _scaleAnimation=Tween<double>(begin: 0.95,end: 1).animate(_scaleController);
  _heightController=AnimationController(
    vsync: this,
     duration: Duration(milliseconds: 200)
  );
  _heightAnimation=Tween<double>(begin: 160,end: 300).animate(_heightController);
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) { 
      setState(() {
         widthUpdate =MediaQuery.of(context).size.width-60;
      });
    });
  }

  ///navigation
  void goToStudiesPage(){
    widget.update("/studies");
  }


  @override
  Widget build(BuildContext context) {

    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;

    return Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 60,
              right: 30,
              child: Icon(Icons.notifications,size: 40,color: Colors.white,)
            ),
            Positioned(
              top: 0,
              child: Column(
                children: [
                  const SizedBox(height: 50,),
                  header("GNOM\nHELPER"),
                  const SizedBox(height: 230,),
                  const Text(
                    "ВЫБЕРИ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w800,
                      fontFamily: "NoirPro",
                      height: 1,
                      letterSpacing: 1,
                      color: Color.fromRGBO(254, 222,181, 1)
                      ),
                  ),
                  const SizedBox(height: 10,),
                  GestureDetector(
                    onTap: goToStudiesPage,
                    child: selectType("УЧЁБА")
                  ),
                  const SizedBox(height: 20,),
                  GestureDetector(
                    onTap: closeInfo,
                    child: selectType("ТВОРЧЕСТВО")
                  )
                ],
              ),
            ),
            Positioned(
              top: 0,
              child: GestureDetector(
                onTap: closeInfo,
                child: SizedBox(
                  height:isOpenInfo? height:0,
                  child: AnimatedContainer(
                    width: width, 
                    duration: Duration(milliseconds: 400),
                    color: bgColor,
                  ),
                ),
              )
            ),
            Positioned(
              top: 130,
              child:  Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    updateViewInfo(),
                  ],
                ),
            ),
          ],
        );
  }

Widget selectType(String title){
  return  SizedBox(
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
    
  );
}

Widget updateViewInfo(){
  return GestureDetector(
    onTap: openInfo,
    child:  AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return  Transform.scale(
              scale: _scaleAnimation.value,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: AnimatedBuilder(
                  animation: _heightAnimation,
                  builder: (context, child) {
                    return Container(
                    color: color,
                    width:360,//widthUpdate==0?MediaQuery.of(context).size.width-60:widthUpdate,
                    height: _heightAnimation.value,//heightUpdate,
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 200),
                        padding: EdgeInsets.only(top: 40-heightUpdate/10),
                        child: Text(
                            "UPDATE\n09.03.2024",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w500,
                              fontFamily: "NoirPro",
                              height: 1,
                              letterSpacing: 1,
                              color: textColor
                              ),
                          ),
                      ),
                    );
                  },
                  
                ),
              ),
            );
          
        },
          // duration: const Duration(milliseconds: 400),
          // width:widthUpdate==0?MediaQuery.of(context).size.width-60:widthUpdate,
          // height: heightUpdate,
          // color: color,

          
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
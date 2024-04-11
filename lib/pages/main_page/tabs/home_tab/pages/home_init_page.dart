import 'package:flutter/material.dart';

class HOMEInitPage extends StatefulWidget {
  const HOMEInitPage({super.key});

  @override
  State<HOMEInitPage> createState() => _HOMEInitPageState();
}

class _HOMEInitPageState extends State<HOMEInitPage> with TickerProviderStateMixin{


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

  // late final AnimationController _heightController;
  // late final Animation<double> _height;
  @override
  void initState() {
    // _heightController=AnimationController(
    //   duration: const Duration(milliseconds: 1000),
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

  ///navigation
  void goToStudiesPage(){
    Navigator.of(context).pushNamed('/studies');
  }


  @override
  Widget build(BuildContext context) {
    return Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 0,
              child: Column(
                children: [
                  const SizedBox(height: 40,),
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
              top: 130,
              child:  Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    updateViewInfo(),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: closeInfo,
                      child: Container(
                        color: Colors.red,
                        width: 200,
                        height: 50,
                      ),
                    )
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
    child: ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          width:widthUpdate==0?MediaQuery.of(context).size.width-60:widthUpdate,
          height: heightUpdate,
          color: color,
          padding: EdgeInsets.only(top: 40-heightUpdate/10),
          child: Text(
              "UPDATE\n09.03.2024",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w800,
                fontFamily: "NoirPro",
                height: 1,
                letterSpacing: 1,
                color: textColor
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
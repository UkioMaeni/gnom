import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HistoryTab extends StatefulWidget {
  const HistoryTab({super.key});

  @override
  State<HistoryTab> createState() => _HistoryTabState();
}

class _HistoryTabState extends State<HistoryTab> with TickerProviderStateMixin {


  // late final AnimationController _heightController;
  // late final Animation<double> _height;
  @override
  void initState() {
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
          HistoryElement(
            model: HistoryModel(icon: const Icon(Icons.abc), saved: false, theme: "ЛОГАРИФМЫ", type: "МАТЕМАТИКА",progress: "inProgress"),
          ),

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


class HistoryElement extends StatefulWidget {
  final HistoryModel model;
  const HistoryElement({super.key,required this.model});

  @override
  State<HistoryElement> createState() => _HistoryElementState();
}

class _HistoryElementState extends State<HistoryElement> with SingleTickerProviderStateMixin {

  double scale=0.3;
  late final AnimationController _scaleController;
  late final Animation<double> _scaleAnimation;
  @override
  void initState() {
    _scaleController=AnimationController(
      duration: const Duration(milliseconds: 2000),
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
    return AnimatedBuilder(
      animation:_scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: SizedBox(
            height: 90,
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
                          ],
                        ),
                    ),
                  ),
                ),
                Container(
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
                )
              ],
            ),
            
          ),
        );
      }, 
    );
  }
}

class HistoryModel{
  String type;
  String theme;
  Widget icon;
  bool saved;
  String progress;
  HistoryModel({
    required this.icon,
    required this.saved,
    required this.theme,
    required this.type,
    required this.progress
  });
}
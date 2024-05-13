import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FirstElementPlaning extends StatefulWidget {
  final Function(bool) onTap;
  const FirstElementPlaning({super.key,required this.onTap});

  @override
  State<FirstElementPlaning> createState() => _FirstElementPlaningState();
}

class _FirstElementPlaningState extends State<FirstElementPlaning> with SingleTickerProviderStateMixin {

  late final AnimationController _scaleController;
  late final Animation<double> _scaleAnimation;
  @override
  void initState() {
    _scaleController=AnimationController(vsync: this,duration: Duration(milliseconds: 300));
    _scaleAnimation=Tween<double>(begin: 1,end: 1.2).animate(_scaleController);
    super.initState();
  }
  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: () {
        widget.onTap(true);
        _scaleController.forward().then((value) => _scaleController.reverse());
      },
      child: AnimatedBuilder(
                animation: _scaleAnimation, 
                builder: (context, child) {
                  return Transform.scale(
                    scale: _scaleAnimation.value,
                    child: Container(
                      width: 80,
                      height: 80,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(40)
                      ),
                      child: Container(
                        width: 60,
                        height: 60,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.grey
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "349",
                                  style: TextStyle(
                                    fontFamily: "NoirPro",
                                    color: Color.fromRGBO(254, 222,181, 1),
                                    height: 1,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18
                                  ),
                                ),
                                Text(
                                  "Р",
                                  style: TextStyle(
                                    fontFamily: "NoirPro",
                                    color: Color.fromRGBO(254, 222,181, 1),
                                    height: 1,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 25
                                  ),
                                ),
                              ],
                            ),
                            Text(
                                  "МЕСЯЦ",
                                  style: TextStyle(
                                    fontFamily: "NoirPro",
                                    color: Color.fromRGBO(254, 222,181, 1),
                                    height: 1,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 10
                                  ),
                                ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
    );
  }
}




class SecondElementPlaning extends StatefulWidget {
  const SecondElementPlaning({super.key});

  @override
  State<SecondElementPlaning> createState() => _SecondElementPlaningState();
}

class _SecondElementPlaningState extends State<SecondElementPlaning> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
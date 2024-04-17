import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> with TickerProviderStateMixin {

  late AnimationController _gnomController;
  late AnimationController _opacityController;
  late AnimationController _opacityRequestController;

  late Animation<double> _gnom;
  late Animation<double> _opacity;
  late Animation<double> _opacityRequest;
  startOpacityRequestAnimation(){
     _opacityRequestController=AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );
    _opacityRequest  = CurvedAnimation(
      parent: Tween<double>(begin: 0,end:1 ).animate(_opacityRequestController),
      curve: Curves.fastOutSlowIn,
    );
    
   // _gnom=Tween<double>(begin: pi/2,end:0 ).animate(_gnomController);
    _opacityRequestController.forward();
  }
 startGnomAnimation(){
     _gnomController=AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );
    _gnom = CurvedAnimation(
      parent: Tween<double>(begin: 0,end:1 ).animate(_gnomController),
      curve: Curves.fastOutSlowIn,
    );
    
   // _gnom=Tween<double>(begin: pi/2,end:0 ).animate(_gnomController);
    _gnomController.forward();
  }
  startOpacityAnimation(){
     _opacityController=AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );
    _opacity = CurvedAnimation(
      parent: Tween<double>(begin: 0,end:1 ).animate(_gnomController),
      curve: Curves.fastOutSlowIn,
    );
    
   // _gnom=Tween<double>(begin: pi/2,end:0 ).animate(_gnomController);
    _opacityController.forward();
  }
  @override
  void initState() {
    startGnomAnimation();
    startOpacityAnimation();
    startOpacityRequestAnimation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(top: MediaQuery.of(context).padding.top+10,left: 20,right: 20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            gnomTransform(),
            SizedBox(height: 4,),
            userName(),
            SizedBox(height: 20,),
            requestCount(),
            SizedBox(height: 20,),
            friends(),
            SizedBox(height: 20,),
            stats(),
            SizedBox(height: 20,),
            planing()
          ],
        ),
      ),
    );
  }

  Widget planing(){
    return AnimatedBuilder(
      animation: _opacityRequest,
      builder: (context, child) {
        return Transform.scale(
          scale: _opacityRequest.value,
          child: Opacity(
            opacity: _opacity.value,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: const Color.fromRGBO(196, 114, 137, 0.8)
              ),
              height: 180,
              width: 300,
              child: Text(
                "__OWNER__",
                style: TextStyle(
                  color: Colors.white
                ),
                ),
            ),
          ),
          );
      },
      
    );
  }
  Widget stats(){
    return AnimatedBuilder(
      animation: _opacityRequest,
      builder: (context, child) {
        return Transform.scale(
          scale: _opacityRequest.value,
          child: Opacity(
            opacity: _opacity.value,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: const Color.fromRGBO(196, 114, 137, 0.8)
              ),
              height: 180,
              width: 300,
              child: Column(
                children: [
                  SizedBox(height: 10,),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                       mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(
                      8, 
                      (index) =>  Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text((index+1).toString()+"00"),
                          Container(
                              width: 35,
                              height: index*10+30,
                              decoration: BoxDecoration(
                                color: Colors.red
                              ),
                              
                            
                          ),
                        ],
                      )
                    )
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(
                      8, 
                      (index) =>  Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: Colors.black,
                              width: 4
                            )
                          ),
                          child: Text((index+1).toString()),
                        
                      )
                    )
                  ),
                  SizedBox(height: 20,)
                ],
              )
            ),
          ),
          );
      },
      
    );
  }

 Widget friends(){
    return AnimatedBuilder(
      animation: _opacityRequest,
      builder: (context, child) {
        return Transform.scale(
          scale: _opacityRequest.value,
          child: Opacity(
            opacity: _opacity.value,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: const Color.fromRGBO(196, 114, 137, 0.8)
              ),
              height: 80,
              width: 300,
              child: Text(
                "__OWNER__",
                style: TextStyle(
                  color: Colors.white
                ),
                ),
            ),
          ),
          );
      },
      
    );
  }


  Widget requestCount(){
    return AnimatedBuilder(
      animation: _opacityRequest,
      builder: (context, child) {
        return Transform.scale(
          scale: _opacityRequest.value,
          child: Opacity(
            opacity: _opacity.value,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: const Color.fromRGBO(196, 114, 137, 0.8)
              ),
              height: 140,
              width: 300,
              child: Text(
                "__OWNER__",
                style: TextStyle(
                  color: Colors.white
                ),
                ),
            ),
          ),
          );
      },
      
    );
  }

  Widget userName(){
    return AnimatedBuilder(
      animation: _opacity,
      builder: (context, child) {
        return Opacity(
          opacity: _opacity.value,
          child: Text(
            "__OWNER__",
            style: TextStyle(
              color: Colors.white
            ),
            ),
          );
      },
      
    );
  }


  Widget gnomTransform(){
    return AnimatedBuilder(
      animation: _gnomController,
      builder: (context,_) {
        return Transform.rotate(
          angle: pi/2-(_gnom.value*pi/2),
          
          child: Transform.scale(
            scale: _gnom.value,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                 SizedBox(
                    height: 120,
                    width: 120,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 254, 254),
                        borderRadius: BorderRadius.circular(125)
                      ),
                    ),
                  ),
                
                Image.asset("assets/png/gnome_sticker.png",height: 120,)
              ],
            ),
          ),
        );
      }
    );
  }
}
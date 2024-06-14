import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gnom/pages/auth_page/auth_page.dart';
import 'package:gnom/pages/main_page/tabs/profile_tab/components/auth.dart';
import 'package:gnom/pages/main_page/tabs/profile_tab/components/plaining_subcribtion/plaining_subcribtion.dart';
import 'package:gnom/pages/main_page/tabs/profile_tab/components/plane_info.dart';
import 'package:gnom/pages/main_page/tabs/profile_tab/components/profile_list_friends.dart';
import 'package:gnom/pages/main_page/tabs/profile_tab/components/profile_requests_count.dart';
import 'package:gnom/pages/main_page/tabs/profile_tab/components/profile_requests_diagramm.dart';
import 'package:gnom/store/user_store.dart';

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
  void dispose() {
    _gnomController.dispose();
    _opacityController.dispose();
    _opacityRequestController.dispose();
    super.dispose();
  }

  bool isOpen=false;
  setOpen(bool value){
    setState(() {
      isOpen=value;
    });
  }
  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    return Padding(
      padding:  EdgeInsets.only(top: MediaQuery.of(context).padding.top+10,left: 20,right: 20),
      child: Observer(
        builder: (context) {

          bool isGuest=userStore.role=="guest";
          final requestsCount= userStore.requestsCount;
          if(requestsCount==null){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Stack(
            children: [
              SingleChildScrollView(
                child:  Column(
                    children: [
                      if(!isGuest)gnomTransform(),
                      if(!isGuest)SizedBox(height: 6,),
                      if(!isGuest)userName(),
                      SizedBox(height: 20,),
                      ProfileRequestCount(requestsCount:requestsCount),
                      if(!isGuest)SizedBox(height: 20,),
                      if(!isGuest)ProfileListFriends(),
                      SizedBox(height: 20,),
                      ProfileRequestsDiagramm(requestsCount:requestsCount),
                      if(!isGuest)SizedBox(height: 20,),
                      if(!isGuest)ProfileplaningSubcribtion(requestsCount:requestsCount,setOpen:setOpen),
                      // SizedBox(height: 20,),
                      // planing()
                      if(isGuest)Padding(
                          padding: const EdgeInsets.only(top: 50),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => AuthPage(),));
                            },
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 45,
                                  width: 45,
                                  child: SvgPicture.asset("assets/svg/exit.svg",color: Color.fromRGBO(254, 222,181, 1),)
                                ),
                                Text(
                                  " Войти",
                                  style: TextStyle(
                                    fontFamily: "NoirPro",
                                    color: Colors.white,
                                    height: 1,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 25
                                  ),
                              ),
                              
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                
              ),
              if(isOpen)
               Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Center(
                    child: PlaneInfo(setOpen:setOpen)
                  ),
                ),
              ),
            ],
          );
        }
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
          child: Column(
            children: [
              Text(
                userStore.profile?.nickname??"",
                style: TextStyle(
                  color: Colors.white
                ),
                ),
                  GestureDetector(
                                onTap: () async{
                                  await Clipboard.setData(ClipboardData(text: userStore.profile?.login??""));
                                },
                                child: Container(
                                  height: 30,
                                  width: 150,
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(5),
                                    
                              
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "ID:"+(userStore.profile?.login??""),
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: "Inter",
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600
                                        ),
                                      ),
                                      SizedBox(width: 10,),
                                      Icon(Icons.copy,size: 15,),
                                      Text(
                                      "copy",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: "Inter",
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400
                                      ),
                                    ),
                                    ],
                                  ),
                                ),
                              ),
            ],
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
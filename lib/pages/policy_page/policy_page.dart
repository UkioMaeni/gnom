import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gnom/core/localization/localization_bloc.dart';
import 'package:gnom/repositories/policy_repo.dart';
//import "package:webview_universal/webview_universal.dart";
class PolicyPage extends StatefulWidget {
  const PolicyPage({super.key});

  @override
  State<PolicyPage> createState() => _PolicyPageState();
}

class _PolicyPageState extends State<PolicyPage> {

  // final controller = WebViewController()
  // ..setJavaScriptMode(JavaScriptMode.unrestricted)
  
  // ..setNavigationDelegate(
  //   NavigationDelegate(
  //     onProgress: (int progress) {
  //       // Update loading bar.
  //     },
      
  //     onPageStarted: (String url) {},
  //     onPageFinished: (String url) {},
  //     onHttpError: (HttpResponseError error) {},
  //     onWebResourceError: (WebResourceError error) {
  //       print(error);
  //     },
  //     onNavigationRequest: (NavigationRequest request) {
  //       if (request.url.startsWith('https://gnom-pomoshnik-game.ru/index')) {
  //         return NavigationDecision.prevent;
  //       }
  //       return NavigationDecision.navigate;
  //     },
  //   ),
  // )
  // ..loadRequest(Uri.parse('https://gnom-pomoshnik-game.ru/index'));
  //WebViewController webViewController = WebViewController();
  ScrollController _scrollController = ScrollController();
  bool agree=false;
  @override
  void initState() {
    _scrollController.addListener(scrollListener);
    Timer.periodic(Duration(seconds: 0), (timer){
      scrollListener();
      timer.cancel();
    },);
    // webViewController.init(
    //   context: context, 
    //   setState: setState,
    //   uri: Uri.parse("https://gnom-pomoshnik-game.ru/index")
    // );
    super.initState();
  }

  final key=GlobalKey();

  void scrollListener(){
    if(_scrollController.position.extentAfter==0&&_scrollController.position.atEdge){
      setState(() {
        _opacity=1;
      });
    }
    // }else{
    //   if(_scrollController.position.atEdge&&_scrollController.position.pixels){
    //   setState(() {
    //     _opacity=1;
    //   });
    // }
    // }
    
  }

  double _opacity=0;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child:   Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top+20,left: 24,right: 24),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/png/app_bg.png"),
            fit: BoxFit.cover
          )
        ),
        child: Column(
              children: [
                //Expanded(child: WebView(controller: webViewController,)),
                Expanded(
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    child: Column(
                      key: key,
                      children: [
                        Builder(
                            builder: (context) {
                              final locale= context.watch<LocalizationBloc>().state.locale;
                              return Column(
                                children: [
                                  Text(
                                    locale.h1_body,
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "NoirPro",
                                      height: 1.2,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(height: 20,),
                                  Text(
                                    locale.h1_title,
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "NoirPro",
                                      height: 1.2,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(height: 20,),
                                  Text(
                                    locale.h2_body,
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "NoirPro",
                                      height: 1.2,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(height: 20,),
                                  Text(
                                    locale.h2_title,
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "NoirPro",
                                      height: 1.2,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(height: 20,),
                                  Text(
                                    locale.h3_body,
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "NoirPro",
                                      height: 1.2,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(height: 20,),
                                  Text(
                                    locale.h3_title,
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "NoirPro",
                                      height: 1.2,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(height: 20,),
                                  Text(
                                    locale.h4_body,
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "NoirPro",
                                      height: 1.2,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(height: 20,),
                                  Text(
                                    locale.h4_title,
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "NoirPro",
                                      height: 1.2,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(height: 20,),
                                  Text(
                                    locale.h5_body,
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "NoirPro",
                                      height: 1.2,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(height: 20,),
                                  Text(
                                    locale.h5_title,
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "NoirPro",
                                      height: 1.2,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(height: 20,),
                                  Text(
                                    locale.h6_body,
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "NoirPro",
                                      height: 1.2,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(height: 20,),
                                  Text(
                                    locale.h6_title,
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "NoirPro",
                                      height: 1.2,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(height: 20,),
                                  Builder(
                                    builder: (context) {
                                      String text="";
                                      if(locale.locale=="ar"){
                                        text=locale.mailCompany+" :"+locale.support;
                                      }else{
                                        text=locale.support+": "+locale.mailCompany;
                                      }
                                      return Text(
                                        text,
                                        textAlign: TextAlign.start,
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "NoirPro",
                                          height: 1.2,
                                          color: Colors.white,
                                        ),
                                      );
                                    }
                                  ),
                                  SizedBox(height: 50,),
                                  AnimatedOpacity(
                                    duration: Duration(milliseconds: 400),
                                    opacity: _opacity,
                                    child: GestureDetector(
                                      onTap: () async{
                                        if(_opacity<1) return;
                                        await policyRepo.savePolicy("yes");
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                                        decoration: BoxDecoration(
                                          color: Color.fromARGB(255, 59, 66, 208),
                                          borderRadius: BorderRadius.circular(10)
                                        ),
                                        child: Text(
                                            locale.agree,
                                            textAlign: TextAlign.start,
                                            style: const TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: "NoirPro",
                                              height: 1,
                                              color: Colors.white,
                                            ),
                                          ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 40,)
                                ],
                              );
                            },
                          )
                      ],
                    ),
                  )
                ),
                // Container(
                //   height: 140,
                //   decoration: BoxDecoration(
                //     border: Border(
                //       top: BorderSide(
                //         color: Color.fromARGB(255, 208, 206, 206),
                //         width: 2
                //       )
                //     )
                //   ),
                //   child: Column(
                //     children: [
                //       SizedBox(height: 20,),
                //       GestureDetector(
                //         onTap: () {
                //           setState(() {
                //             agree=!agree;
                //           });
                //         },
                //         child: Row(
                //           children: [
                //             SizedBox(width: 20,),
                //             Container(
                //               width: 30,
                //               height: 30,
                //               decoration: BoxDecoration(
                //                 border: Border.all(
                //                   color: Colors.blue
                //                 )
                //               ),
                //               alignment: Alignment.center,
                //               child: agree?Container(
                //                 width: 20,
                //                 height: 20,
                //                 color: Colors.blue,
                //               ):SizedBox.shrink(),
                //             ),
                //             SizedBox(width: 20,),
                //             Text(
                //               "I agree with the privacy policy",
                //               style: TextStyle(
                //                 fontSize: 18
                //               ),
                //             )
                //           ],
                //         ),
                //       ),
                //       SizedBox(height: 20,),
                //       GestureDetector(
                //         onTap: ()async {
                //           if(!agree) return;
                //           await policyRepo.savePolicy("yes");
                //           Navigator.pop(context);
                //         },
                //         child: Container(
                //           width: 150,
                //           height: 50,
                //           alignment: Alignment.center,
                //           decoration: BoxDecoration(
                //             color: agree?Colors.blue:Color.fromARGB(116, 158, 158, 158)
                //           ),
                //           child: Text(
                //               "Continue",
                //               style: TextStyle(
                //                 fontSize: 18,
                //                 color: agree?Colors.white:Colors.black
                //               ),
                //             ),
                //         ),
                //       )
                //     ],
                //   ),
                // )
              ],
        ),
      ),
    );
  }
}
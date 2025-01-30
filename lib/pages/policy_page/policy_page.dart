import 'package:flutter/material.dart';
import 'package:gnom/repositories/policy_repo.dart';
import "package:webview_universal/webview_universal.dart";
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
  WebViewController webViewController = WebViewController();

  bool agree=false;
  @override
  void initState() {
    webViewController.init(
      context: context, 
      setState: setState,
      uri: Uri.parse("https://gnom-pomoshnik-game.ru/index")
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Container(
        child: Column(
          children: [
            Expanded(child: WebView(controller: webViewController,)),
            Container(
              height: 140,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Color.fromARGB(255, 208, 206, 206),
                    width: 2
                  )
                )
              ),
              child: Column(
                children: [
                  SizedBox(height: 20,),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        agree=!agree;
                      });
                    },
                    child: Row(
                      children: [
                        SizedBox(width: 20,),
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.blue
                            )
                          ),
                          alignment: Alignment.center,
                          child: agree?Container(
                            width: 20,
                            height: 20,
                            color: Colors.blue,
                          ):SizedBox.shrink(),
                        ),
                        SizedBox(width: 20,),
                        Text(
                          "I agree with the privacy policy",
                          style: TextStyle(
                            fontSize: 18
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  GestureDetector(
                    onTap: ()async {
                      if(!agree) return;
                      await policyRepo.savePolicy("yes");
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 150,
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: agree?Colors.blue:Color.fromARGB(116, 158, 158, 158)
                      ),
                      child: Text(
                          "Continue",
                          style: TextStyle(
                            fontSize: 18,
                            color: agree?Colors.white:Colors.black
                          ),
                        ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
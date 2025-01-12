import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gnom/core/localization/localization_bloc.dart';
import 'package:gnom/core/tools/string_tool.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
class MiniGame extends StatefulWidget {
  const MiniGame({super.key});

  @override
  State<MiniGame> createState() => _MiniGameState();
}

class _MiniGameState extends State<MiniGame> {


  final controller = WebViewController()
  ..setJavaScriptMode(JavaScriptMode.unrestricted)
  ..setBackgroundColor(const Color(0x00000000))
  ..setNavigationDelegate(
    NavigationDelegate(
      onProgress: (int progress) {
        // Update loading bar.
      },
      onPageStarted: (String url) {},
      onPageFinished: (String url) {},
      onHttpError: (HttpResponseError error) {},
      onWebResourceError: (WebResourceError error) {},
      onNavigationRequest: (NavigationRequest request) {
        if (request.url.startsWith('http://')) {
          return NavigationDecision.navigate;
        }
        return NavigationDecision.navigate;
      },
    ),
  )
  ..loadRequest(Uri.parse('https://gnom-pomoshnik-game.ru/cat_jump'));
   
  // (NavigationRequest request) {
  //   if (request.url.startsWith('http://')) {
  //     return NavigationDecision.navigate; // Allow navigation to insecure URLs
  //   }
  //   return NavigationDecision.navigate;
  // },
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/png/app_bg.png"),
            fit: BoxFit.cover
          )
        ),
        child: Column(
          children: [
            SizedBox(height: 60,),
            GestureDetector(
              onTap:()=> Navigator.pop(context),
              child: Row(
                children: [
                  SizedBox(width: 20,),
                  Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)
                    ),
                    child: Icon(Icons.arrow_back)
                  ),
                  SizedBox(width: 10,),
                  Builder(
                    builder: (context) {
                      final state = (context.watch<LocalizationBloc>().state as LocalizationLocaleState);
                      return Text(
                        StringTools.firstUpperOfString(state.locale.education),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w400,
                          fontFamily: "NoirPro",
                          height: 1,
                          color: Colors.white
                          ),
                      );
                    }
                  ),
                ],
              ),
            ),
            SizedBox(height: 10,),
            Expanded(child: WebViewWidget(controller: controller)),
          ],
        ),
      ),
    );
  }
}
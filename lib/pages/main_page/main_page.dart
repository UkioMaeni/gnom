import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gnom/http/fcm.dart';
import 'package:gnom/pages/chat_page/chat_page.dart';
import 'package:gnom/pages/chat_page/store/chat_store.dart';
import 'package:gnom/pages/main_page/tabs/favorite_tab/favorite_tab.dart';
import 'package:gnom/pages/main_page/tabs/friends_tab.dart';
import 'package:gnom/pages/main_page/tabs/history_tab/history_tab.dart';
import 'package:gnom/pages/main_page/tabs/home_tab/home_tab.dart';
import 'package:gnom/pages/main_page/tabs/profile_tab/profile_tab.dart';
import 'package:gnom/pages/policy_page/policy_page.dart';
import 'package:gnom/repositories/policy_repo.dart';
import 'package:gnom/store/user_store.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}




class _MainPageState extends State<MainPage>  with WidgetsBindingObserver{



  int _selectedIndex = 0;
  static const List<Widget> _pages = <Widget>[
  HomeTab(),
  HistoryTab(),
  FriendsTab(),
  FavoriteTab(),
  ProfileTab()
];


  void _onItemTapped(int index) {
    userStore.selectedIndex=index;
  }

  void initFirebase()async{
    final apnsToken = await FirebaseMessaging.instance.getToken();
    print(apnsToken);
    await FCMHttp().setFcmToken(apnsToken??"");
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');
      final data=message.data;
      String messageType=data['messageType'];
      
      chatStore.addMessageFromNotify(messageType);
      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
  }

    @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {
      print(state);
      if(state==AppLifecycleState.resumed){
       chatStore.checkUnread();
      }
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void initialize()async{
    String isPolicy= await policyRepo.policyIsCompleted;
    if(isPolicy=="no"){
      await showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return Dialog(
            insetPadding: EdgeInsets.zero,
            child: PolicyPage()
          );
        },
      );
    }
    chatStore.checkUnread();
    initFirebase();
    userStore.getRequestsCount();
    userStore.requiredData();
    chatStore.addMessageFromDb();
    chatStore.addHistoryFromDb();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void initState() {
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
   
    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: SizedBox(
      
        height: 70,
        child:  Observer(
          builder: (context) {
            return BottomNavigationBar(
                backgroundColor: const Color.fromRGBO(155, 13, 13, 0.226),
                elevation: 0,
                type: BottomNavigationBarType.fixed,
                currentIndex: userStore.selectedIndex, //New
                onTap: _onItemTapped,
              showUnselectedLabels: false,
              showSelectedLabels: false,
              enableFeedback: false,
              landscapeLayout:BottomNavigationBarLandscapeLayout.linear ,
                items:  <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    activeIcon: SizedBox(
                      width: 30,
                      height: 30,
                      child: SvgPicture.asset("assets/svg/home_tab.svg",color: const Color.fromRGBO(254, 222,181, 1),)
                    ),
                    icon: SizedBox(
                      width: 30,
                      height: 30,
                      child: SvgPicture.asset("assets/svg/home_tab.svg",color: Colors.white)
                    ),
                    label: ""
                  ),
                  BottomNavigationBarItem(
                    activeIcon:  SizedBox(
                      width: 30,
                      height: 30,
                      child: SvgPicture.asset("assets/svg/history_tab.svg",color: const Color.fromRGBO(254, 222,181, 1))
                    ),
                    icon: SizedBox(
                      width: 30,
                      height: 30,
                      child: SvgPicture.asset("assets/svg/history_tab.svg",color: Colors.white)
                    ),
                    label: ""
                  ),
                  BottomNavigationBarItem(
                    activeIcon: SizedBox(
                      width: 30,
                      height: 30,
                      child: SvgPicture.asset("assets/svg/friends_tab.svg",color: const Color.fromRGBO(254, 222,181, 1))
                    ),
                    icon: SizedBox(
                      width: 30,
                      height: 30,
                      child: SvgPicture.asset("assets/svg/friends_tab.svg",color: Colors.white)
                    ),
                    label: ""
                  ),
                  BottomNavigationBarItem(
                    activeIcon: SizedBox(
                      width: 30,
                      height: 30,
                      child: SvgPicture.asset("assets/svg/saved_tab.svg",color: const Color.fromRGBO(254, 222,181, 1))
                    ),
                    icon: SizedBox(
                      width: 30,
                      height: 30,
                      child: SvgPicture.asset("assets/svg/saved_tab.svg",color: Colors.white)
                    ),
                    label: ""
                  ),
                  BottomNavigationBarItem(
                    activeIcon: SizedBox(
                      width: 30,
                      height: 30,
                      child: SvgPicture.asset("assets/svg/profile_tab.svg",color: const Color.fromRGBO(254, 222,181, 1))
                    ),
                    icon: SizedBox(
                      width: 30,
                      height: 30,
                      child: SvgPicture.asset("assets/svg/profile_tab.svg",color: Colors.white)
                    ),
                    label: ""
                  ),
                ],
              );
          }
        ),
      ),
      body: Observer(
        builder: (context) {
          print("edit");
          int index= userStore.selectedIndex;
          return SizedBox(
            width: width,
            height:height,
            child: DecoratedBox(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/jpg/app_bg.jpg"),
                  fit: BoxFit.cover
                )
              ),
              child: _pages.elementAt(index)
            ),
          );
        }
      ),
    );
  }
}
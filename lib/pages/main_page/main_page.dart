import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gnom/pages/main_page/tabs/friends_tab.dart';
import 'package:gnom/pages/main_page/tabs/history_tab.dart';
import 'package:gnom/pages/main_page/tabs/home_tab/home_tab.dart';
import 'package:gnom/pages/main_page/tabs/profile_tab/profile_tab.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}




class _MainPageState extends State<MainPage> {

  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
  HomeTab(),
  HistoryTab(),
  FriendsTab(),
  Icon(
    Icons.camera,
    size: 150,
  ),
  ProfileTab()
];


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
        child:  BottomNavigationBar(
            backgroundColor: const Color.fromRGBO(155, 13, 13, 0.226),
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            currentIndex: _selectedIndex, //New
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
          ),
      ),
      body: SizedBox(
        width: width,
        height:height,
        child: DecoratedBox(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/jpg/app_bg.jpg"),
              fit: BoxFit.cover
            )
          ),
          child: _pages.elementAt(_selectedIndex)
        ),
      ),
    );
  }
}
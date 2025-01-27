import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gnom/core/localization/localization_bloc.dart';
import 'package:gnom/core/tools/string_tool.dart';
import 'package:gnom/http/user.dart';
import 'package:gnom/store/user_store.dart';

class FriendsTab extends StatefulWidget {
  const FriendsTab({Key? key}) : super(key: key);

  @override
  State<FriendsTab> createState() => _FriendsTabState();
}

Future<dynamic> debounce(Function action) {
  Completer<dynamic> completer = Completer<dynamic>();
  Timer(Duration(seconds: 1), () {
    completer.complete(action());
  });
  return completer.future;
}

class _FriendsTabState extends State<FriendsTab> with TickerProviderStateMixin {
  final GlobalKey _friendsListKey = GlobalKey();

   List<UserModel> users = [
    
    // UserModel(name: 'Jane Smith', status: 'Platinum'),
    // UserModel(name: 'John Doe', status: 'Silver'),
    // UserModel(name: 'Jane Smith', status: 'Gold'),
    // UserModel(name: 'John Doe', status: 'Gols'),
    // UserModel(name: 'Jane Smith', status: 'Platinum'),
    // UserModel(name: 'John Doe', status: 'Silver'),
    // UserModel(name: 'Jane Smith', status: 'Gold'),
  ];

  bool notFind=false;

  late final TextEditingController _searchController;
  late ScrollController _scrollController;

  bool _showDetails = false;
  bool _showList = false;
  late UserModel _selectedUser;

  @override
  void initState() {
    _searchController = TextEditingController();
    super.initState();
  }


  void search()async{
    users=[];
    notFind=false;
    final result = await UserHttp().findUser(_searchController.text);
    print(result);
    if(result!=null){
      users.addAll([
        UserModel(name: result.nickname, status: 'Silver'),
      ]);
    }else{
      notFind=true;
    }
    setState(() {
      
    });
  }

  List<Widget> widgets=[];
  startGenerate()async{
    for(int i=0;i<3;i++){
      setState(() {
        // widgets.add(
        //    HistoryElement(topOffset: (i)*105+paddingOffset+50, model: HistoryModel(icon: SvgPicture.asset("assets/svg/history.svg",fit: BoxFit.contain,), saved: true, theme: "лог", type: "мат", progress: "progress"),)
        // );
      });
      await Future.delayed(Duration(milliseconds: 300));
    }
  }

  @override
  Widget build(BuildContext context) {
    if(userStore.role=="guest"){
      return Center(
        child: Builder(
          builder: (context) {
            final state = (context.watch<LocalizationBloc>().state as LocalizationLocaleState);
            return Text(
                    StringTools.firstUpperOfString(state.locale.notAvailableForTrial),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      fontFamily: "NoirPro",
                      height: 1,
                      color: Color.fromRGBO(254, 222, 181, 1),
                    ),
                  );
          }
        ),
      );
    }
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if(_showDetails){
          setState(() {
            _showDetails=false;
          });
        }
      },
      child: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
          left: 0,
          right: 0,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              children: [
                SizedBox(height: 40,),
                 SizedBox(
                    height: 30,
                    width: MediaQuery.of(context).size.width -100,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(157, 0, 0, 0),
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 30,
                              child: TextField(
                                controller: _searchController,
                                onChanged: (value) {
                                  setState(() {
                                    users=[];
                                    notFind=false;
                                  });
                                },
                                maxLength: 9,
                                style: TextStyle(
                                              fontFamily: "NoirPro",
                                              color: Color.fromARGB(144, 209, 204, 204),
                                              height: 1,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14
                                            ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(bottom: 13,left: 10,right: 10),
                                  counter: SizedBox.shrink(),
                                  //hintText: "USER ID",
                                  hintStyle: TextStyle(
                                              fontFamily: "NoirPro",
                                              color: Color.fromARGB(144, 209, 204, 204),
                                              height: 1,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14
                                            ),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: search,
                            child: SizedBox(
                              width: 25,
                              height: 20,
                              child: SvgPicture.asset("assets/svg/search.svg",color: Color.fromARGB(255, 255, 255, 255),)
                            ),
                          ),
                          SizedBox(width: 10,)
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    key: _friendsListKey,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                       notFind? 
                       Text(
                          "НЕ НАЙДЕНО",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            fontFamily: "NoirPro",
                            height: 1,
                            color: Color.fromRGBO(254, 222, 181, 1),
                          ),
                        )
                       :ListView.separated(
                          separatorBuilder: (context, index) {
                            return SizedBox(height: 5,);
                          },
                          itemCount: users.length,
                          itemBuilder: (context, index) {
                            final Duration animationDuration =
                            Duration(milliseconds: 1000);
                            final Duration delay =
                            Duration(milliseconds: 200 * index);
                            return DelayedAnimation(
                              delay: delay,
                              child: FriendsElement(
                                  user: users[index],
                                  onDetailsPressed: (user) {
                                    setState(() {
                                      _selectedUser = user;
                                      _showDetails = true;
                                    });
                                  },
                                  showList: _showList,
                                  showDetails: _showDetails,
                                ),
                              // child: Padding(
                              //   padding: EdgeInsets.symmetric(
                              //       vertical: 10, horizontal: 20),
                              //   child: FriendsElement(
                              //     user: users[index],
                              //     onDetailsPressed: (user) {
                              //       setState(() {
                              //         _selectedUser = user;
                              //         _showDetails = true;
                              //       });
                              //     },
                              //     showList: _showList,
                              //     showDetails: _showDetails,
                              //   ),
                              // ),
                              duration: animationDuration,
                            );
                          },
                        ),
                        if (_showDetails)
                          Positioned.fill(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                              child: Center(
                                child: FormContainer(
                                  user: _selectedUser,
                                  onClose: () {
                                    setState(() {
                                      _showDetails = false;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
            )
              ],
            ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}

class DelayedAnimation extends StatefulWidget {
  final Widget child;
  final Duration delay;
  final Duration duration;

  const DelayedAnimation({
    required this.delay,
    required this.child,
    required this.duration,
  });

  @override
  _DelayedAnimationState createState() => _DelayedAnimationState();
}

class _DelayedAnimationState extends State<DelayedAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
    Future.delayed(widget.delay, () => _controller.forward());
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class FriendsElement extends StatefulWidget {
  final UserModel user;
  final ValueSetter<UserModel> onDetailsPressed;
  final bool showList;
  final bool showDetails;

  const FriendsElement({
    Key? key,
    required this.user,
    required this.onDetailsPressed,
    required this.showList,
    required this.showDetails,
  }) : super(key: key);

  @override
  State<FriendsElement> createState() => _FriendsElementState();
}

class _FriendsElementState extends State<FriendsElement>
    with SingleTickerProviderStateMixin {
  late final AnimationController _scaleController;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _scaleAnimation =
    CurvedAnimation(parent:Tween<double>(begin: 0.1, end: 1).animate(_scaleController) , curve: Curves.easeInOut);
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
    double width = MediaQuery.of(context).size.width;
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: AnimatedOpacity(
            duration: Duration(milliseconds: 200),
            opacity: widget.showDetails?0.2:1,
            child: Container(
              height: 95,
              width: 150,
              margin: EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                children: [
                  Expanded(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(204, 160, 109, 124),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 0,
                          vertical: 5,
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              'assets/svg/profile_tab.svg',
                              width: 100,
                              height: 100,
                              color: Colors.white,
                            ),
                            Expanded(
                              child:  Column(
            
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 5,),
                                    Text(
                                      widget.user.name,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "NoirPro",
                                        height: 1,
                                        color: Color.fromRGBO(254, 222, 181, 1),
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          const TextSpan(
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: "NoirPro",
                                              height: 1,
                                              color: Colors.white,
                                            ),
                                          ),
                                          TextSpan(
                                            text:
                                            "\"${widget.user.status}\"",
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: "NoirPro",
                                              height: 1,
                                              letterSpacing: 1,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.bottomRight,
                                        child: Padding(
                                          padding: const EdgeInsets.only(right: 25),
                                          child: GestureDetector(
                                            onTap:()=> widget.onDetailsPressed(widget.user),
                                            child: SizedBox(
                                              height: 30,
                                              width: 165,
                                              child: DecoratedBox(
                                                decoration: BoxDecoration(
                                                  color: Color.fromRGBO(254, 222, 181, 1),
                                                  borderRadius: BorderRadius.circular(12)
                                                ),
                                                child: Align(
                                                  alignment: Alignment.center,
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Text(
                                                          'ПОДЕЛИТЬСЯ',
                                                          style: const TextStyle(
                                                              fontSize: 16,
                                                              fontWeight: FontWeight.w500,
                                                              fontFamily: "NoirPro",
                                                              height: 1,
                                                              letterSpacing: 1,
                                                              color: Colors.white,
                                                            ),
                                                        ),
                                                        SizedBox(width: 5,),
                                                        SizedBox(
                                                          width: 30,
                                                          height: 30,
                                                          child: SvgPicture.asset("assets/svg/share.svg",color: Colors.white,)
                                                        )
                                                    ],
                                                  ),
                                                    ),
                                                ),
                                              ),
                                            ),
                                        ),
                                      ),
                                    ),
                                    
                                  ],
                                ),
                              
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class UserModel {
  String name;
  String status;

  UserModel({
    required this.status,
    required this.name,
  });
}

class FormContainer extends StatefulWidget {
  final UserModel user;
  final VoidCallback onClose;

  const FormContainer({super.key, required this.user, required this.onClose});

  @override
  _FormContainerState createState() => _FormContainerState();
}

class _FormContainerState extends State<FormContainer> {
  int value = 0;

  void increment() {
    setState(() {
      value++;
    });
  }

  void decrement() {
    setState(() {
      value--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints:
        BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          color: Colors.transparent,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                    'ЗАПРОСЫ',
                    style: TextStyle(
                        color: Color.fromRGBO(254, 222, 181, 1),
                        fontSize: 35,
                        fontFamily: "NoirPro",
                        fontWeight: FontWeight.w800
                    ),
                  ),
                  SizedBox(height: 40,),
                UserCounter(
                  userName: 'МАТЕМАТИКА',
                ),
                UserCounter(
                  userName: 'РЕФЕРАТ',
                ),
                UserCounter(
                  userName: 'СОЧИНЕНИЕ',
                ),
                UserCounter(
                  userName: 'ПРЕЗЕНТАЦИЯ',
                ),
                UserCounter(
                  userName: 'СОКРАЩЕНИЕ',
                ),
                UserCounter(
                  userName: 'ПЕРЕФРАЗИРОВАНИЕ',
                ),
                
                SizedBox(
                  height: 50,
                ),
                TextButton(
                  onPressed: widget.onClose,
                  child: Text(
                    'ПОДЕЛИТЬСЯ',
                    style: TextStyle(
                        color: Color.fromRGBO(254, 222, 181, 1),
                        fontSize: 28,
                        fontFamily: "NoirPro",
                        fontWeight: FontWeight.w800
                      ),
                  ),
                ),
              ],
            ),
          ),
        ),
      
    );
  }
}

class UserCounter extends StatefulWidget {
  final String userName;

  const UserCounter({Key? key, required this.userName}) : super(key: key);

  @override
  _UserCounterState createState() => _UserCounterState();
}

class _UserCounterState extends State<UserCounter> {
  int _value = 0;

  void _increment() {
    if(_value==99) return;
    setState(() {
      _value++;
    });
  }

  void _decrement() {
    if(_value==0) return;
    setState(() {
      _value--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 200,
          child: Text(
            widget.userName,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              fontFamily: "NoirPro",
              color: Colors.white,
            ),
          ),
        ),
        
        Row(
          children: [
            IconButton(
              onPressed: _decrement,
              icon: Icon(Icons.remove,size: 16,),
              color: Colors.white,
            ),
            SizedBox(
              width: 25,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  '$_value',
                  style: TextStyle(
                            color: Color.fromRGBO(254, 222, 181, 1),
                            fontSize: 20,
                            fontFamily: "NoirPro",
                            fontWeight: FontWeight.bold
                          ),
                ),
              ),
            ),
            IconButton(
              onPressed: _increment,
              icon: Icon(Icons.add,size: 16,),
              color: Colors.white,
            ),
          ],
        ),
      ],
    );
  }
}



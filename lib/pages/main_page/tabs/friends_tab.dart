import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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

  final List<UserModel> users = [
    UserModel(name: 'John Doe', status: 'Silver'),
    UserModel(name: 'Jane Smith', status: 'Gold'),
    UserModel(name: 'John Doe', status: 'Silver'),
    UserModel(name: 'Jane Smith', status: 'Platinum'),
    UserModel(name: 'John Doe', status: 'Silver'),
    UserModel(name: 'Jane Smith', status: 'Gold'),
    UserModel(name: 'John Doe', status: 'Gols'),
    UserModel(name: 'Jane Smith', status: 'Platinum'),
    UserModel(name: 'John Doe', status: 'Silver'),
    UserModel(name: 'Jane Smith', status: 'Gold'),
  ];

  late TextEditingController _searchController;
  late ScrollController _scrollController;

  bool _showDetails = false;
  bool _showList = false;
  late UserModel _selectedUser;

  @override
  void initState() {
    _searchController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
        left: 20,
        right: 0,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Container(
                  height: 30,
                  width: MediaQuery.of(context).size.width / 3,
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color.fromRGBO(255, 255, 255, 0.3607843137254902),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          debounce(() {
                            return _searchController.text;
                          }).then((result) {
                            print(result);
                            setState(() {
                              _showList = _searchController.text.length >= 7;
                            });
                          });
                        },
                        icon: Icon(Icons.search),
                      ),
                      contentPadding: EdgeInsets.only(top: 10.0, bottom: 5.0),
                    ),
                    cursorColor: Colors.transparent,
                    showCursor: false,
                  ),
                ),
              ),
              if (_showList) ...[
                Expanded(
                  key: _friendsListKey,
                  child: Stack(
                    children: [
                      ListView.builder(
                        itemCount: users.length,
                        itemBuilder: (context, index) {
                          final Duration animationDuration =
                          Duration(milliseconds: 1000);
                          final Duration delay =
                          Duration(milliseconds: 200 * index);
                          return DelayedAnimation(
                            delay: delay,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
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
                            ),
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
            ],
          ),
        ],
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
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    _scaleAnimation =
        Tween<double>(begin: 0.1, end: 1).animate(_scaleController);
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
          child: SizedBox(
            height: 95,
            width: width - 20,
            child: widget.showList && !widget.showDetails
                ? Row(
              children: [
                Expanded(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(196, 114, 137, 0.8),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 5,
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/svg/profile_tab.svg',
                            width: 100,
                            height: 100,
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 5,
                              ),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    widget.user.name,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "NoirPro",
                                      height: 1,
                                      color: Color.fromRGBO(
                                          254, 222, 181, 1),
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
                                  TextButton(
                                    onPressed: () {
                                      widget
                                          .onDetailsPressed(widget.user);
                                    },
                                    child: Text(
                                      'Поделиться',
                                      style: TextStyle(
                                          color: Color.fromRGBO(
                                              254, 222, 181, 1)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
                : SizedBox(),
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

  FormContainer({required this.user, required this.onClose});

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
    return Positioned.fill(
      child: ConstrainedBox(
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
                UserCounter(
                  userName: 'Математика',
                ),
                UserCounter(
                  userName: 'Русский',
                ),
                UserCounter(
                  userName: 'Физика',
                ),
                UserCounter(
                  userName: 'Математика',
                ),
                UserCounter(
                  userName: 'Русский',
                ),
                UserCounter(
                  userName: 'Физика',
                ),
                SizedBox(
                  height: 100,
                ),
                TextButton(
                  onPressed: widget.onClose,
                  child: Text(
                    'ПОДЕЛИТЬСЯ',
                    style: TextStyle(
                        color: Color.fromRGBO(254, 222, 181, 1),
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
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
    setState(() {
      _value++;
    });
  }

  void _decrement() {
    setState(() {
      _value--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          widget.userName,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color.fromRGBO(254, 222, 181, 1),
          ),
        ),
        Spacer(),
        Row(
          children: [
            IconButton(
              onPressed: _increment,
              icon: Icon(Icons.add),
              color: Colors.grey,
            ),
            Text(
              '$_value',
              style: TextStyle(color: Colors.grey),
            ),
            IconButton(
              onPressed: _decrement,
              icon: Icon(Icons.remove),
              color: Colors.grey,
            ),
          ],
        ),
      ],
    );
  }
}



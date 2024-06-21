import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rive/rive.dart';

import '../../riveUtils.dart';

//pages
import '../MessMenu/messMenu.dart';
import '../map/classPage.dart/Home.dart';
import '../CoursePolicyPage/coursePolicy.dart';
import '../Profile/profile.dart';
import '../map/classPage.dart/searchClass.dart';
import './SideMenu/SideMenu.dart';
import '../ChatBot/chatBotPage.dart';

class navPage extends StatefulWidget {
  const navPage({super.key});

  @override
  State<navPage> createState() => _navPageState();
}

class _navPageState extends State<navPage> {
  List<Widget> pages = [
    messMenu(),
    HomeScreen(),
    coursePolicy(),
    profilePage(),
  ];
  int currentIndex = 0;
  int appbar = 0;
  List<Widget> appBar = [
    Text('Mess Menu'),
    Text('Class'),
    Text('Course Policy'),
    Text('Profile'),
  ];

  RiveAsset selectedBottomNavs = bottomNavs.first;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // change the appbar title based on the current index
          title: appBar[currentIndex],
          actions: [
            TextButton(
              child: Text('Search Class',
                  style: TextStyle(color: Colors.white, fontSize: 13)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => searchClass()),
                );
              },
            ),
          ],
        ),
        drawer: Drawer(
          child: SideMenu(),
        ),
        body: Stack(
          children: [
            IndexedStack(
              index: currentIndex,
              children: pages,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: _buildBottomNavigationBar(),
                ),
              ),
            ),
            Positioned(
              bottom: 150,
              right: 10,
              child: FloatingActionButton(
                onPressed: () {  Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => chatBotPage()),
                                );},
                child: Icon(FontAwesomeIcons.message),
              ),
            ),
          ],
        ));
  }

  Widget _buildBottomNavigationBar() {
    return SafeArea(
        child: Padding(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.all(Radius.circular(24)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ...List.generate(
              bottomNavs.length,
              (index) => GestureDetector(
                onTap: () {
                  bottomNavs[index].input?.value = true;
                  if (bottomNavs[index] != selectedBottomNavs) {
                    setState(() {
                      selectedBottomNavs = bottomNavs[index];
                      currentIndex = index; // Update the currentIndex
                    });
                  }
                  Future.delayed(Duration(seconds: 3), () {
                    bottomNavs[index].input?.value = false;
                  });
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AnimatedContainer(
                      duration: Duration(milliseconds: 400),
                      margin: EdgeInsets.only(bottom: 4),
                      height: 4,
                      width: bottomNavs[index] == selectedBottomNavs ? 24 : 0,
                      decoration: BoxDecoration(
                        color: Color(0xFF81B4FF),
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                    SizedBox(
                      height: 36,
                      width: 36,
                      child: Opacity(
                        opacity:
                            bottomNavs[index] == selectedBottomNavs ? 1 : 0.5,
                        child: RiveAnimation.asset(
                          bottomNavs[index].src,
                          artboard: bottomNavs[index].artBoard,
                          onInit: (artboard) {
                            StateMachineController controller =
                                RiveUtils.getRiveController(artboard,
                                    stateMachineName:
                                        bottomNavs[index].stateMachineName);
                            bottomNavs[index].input =
                                controller.findSMI("active") as SMIBool;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}

class RiveAsset {
  final String artBoard, stateMachineName, title, src;
  late SMIBool? input;

  RiveAsset(
      {required this.src,
      required this.artBoard,
      required this.stateMachineName,
      required this.title,
      this.input});

  set setInput(SMIBool status) {
    input = status;
  }
}

List<RiveAsset> bottomNavs = [
  RiveAsset(
      src: "assets/icons2.riv",
      artBoard: "food",
      stateMachineName: "food_interactivity",
      title: "food"),
  RiveAsset(
      src: "assets/icons2.riv",
      artBoard: "compass",
      stateMachineName: "compass_interactivity",
      title: "Search"),
  RiveAsset(
      src: "assets/icons.riv",
      artBoard: "BELL",
      stateMachineName: "BELL_Interactivity",
      title: "Settings"),
  RiveAsset(
      src: "assets/icons.riv",
      artBoard: "SETTINGS",
      stateMachineName: "SETTINGS_Interactivity",
      title: "Profile"),
];



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:rive_animation/Home/Navigation/navPage.dart';
import 'package:rive_animation/Home/map/classPage.dart/searchClass.dart';
import 'package:rive_animation/riveUtils.dart';

// pages
import 'package:rive_animation/Home/Profile/profile.dart';
import 'package:rive_animation/Home/MessMenu/messMenu.dart';

import 'package:rive_animation/Home/CoursePolicyPage/coursePolicy.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  RiveAsset selectedMenu = sideMenus.first;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 320,
        height: double.infinity,
        color: Color(0xFF17203A),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InfoCard(
                name: 'UserName',
                email: 'UserEmail',
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24, top: 32, bottom: 16),
                child: Text("Browse".toUpperCase(),
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: Colors.white70)),
              ),
              ...sideMenus.map((e) => SideMenuTile(
                    menu: e,
                    press: () {
                      e.input!.change(true);
                      Future.delayed(Duration(seconds: 3), () {
                        e.input!.change(false);
                      });
                      setState(() {
                        selectedMenu = e;
                      });
                    },
                    riveonInit: (artboard) {
                      StateMachineController? controller =
                          RiveUtils.getRiveController(artboard,
                              stateMachineName: e.stateMachineName);
                      e.input = controller.findSMI("active") as SMIBool;
                    },
                    isActive: selectedMenu == e,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

class SideMenuTile extends StatelessWidget {
  const SideMenuTile({
    super.key,
    required this.menu,
    required this.press,
    required this.riveonInit,
    required this.isActive,
  });
  final RiveAsset menu;
  final VoidCallback press;
  final ValueChanged<Artboard> riveonInit;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 24),
          child: Divider(
            color: Colors.white24,
            height: 1,
          ),
        ),
        Stack(
          children: [
            AnimatedPositioned(
              duration: Duration(milliseconds: 400),
              height: 56,
              left: 0,
              width: isActive ? 320 : 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFF6792FF),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            ListTile(
              onTap: () {
                press();
                Future.delayed(Duration(milliseconds: 650), () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => getPage(menu.title),
                    ),
                  );
                });
              },
              leading: SizedBox(
                  height: 34,
                  width: 34,
                  child: RiveAnimation.asset(
                    menu.src,
                    artboard: menu.artBoard,
                    onInit: riveonInit,
                  )),
              title: Text(
                menu.title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class InfoCard extends StatelessWidget {
  const InfoCard({
    super.key,
    required this.name,
    required this.email,
  });

  final String name, email;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
          backgroundColor: Colors.white24,
          child: Icon(
            CupertinoIcons.person,
            color: Colors.white,
          )),
      title: Text(
        name,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        email,
        style: TextStyle(
          color: Colors.white,
          fontSize: 15,
        ),
      ),
    );
  }
}

List<RiveAsset> sideMenus = [
  RiveAsset(
      src: "assets/icons2.riv",
      artBoard: "food",
      stateMachineName: "food_interactivity",
      title: "MESS MENU"),
  RiveAsset(
      src: "assets/icons2.riv",
      artBoard: "coffee",
      stateMachineName: "coffee_interactivity",
      title: "CANTEEN"),
  RiveAsset(
      src: "assets/icons2.riv",
      artBoard: "map",
      stateMachineName: "map_interactivity",
      title: "GALLERY"),
  RiveAsset(
      src: "assets/icons.riv",
      artBoard: "USER",
      stateMachineName: "USER_Interactivity",
      title: "CONTACTS"),
  RiveAsset(
      src: "assets/icons2.riv",
      artBoard: "walk",
      stateMachineName: "walk_interactivity",
      title: "FACULTY"),
 RiveAsset(
      src: "assets/icons.riv",
      artBoard: "BELL",
      stateMachineName: "BELL_Interactivity",
      title: "LATEST EVENTS"),
  RiveAsset(
      src: "assets/icons.riv",
      artBoard: "CHAT",
      stateMachineName: "CHAT_Interactivity",
      title: "FEEDBACK"),
];

Widget getPage(String title) {
  switch (title) {
    case 'MESS MENU':
      return navPage();
    case 'CANTEEN':
      return coursePolicy();
    case 'GALLERY':
      return searchClass();
    case 'CONTACTS':
      return profilePage();
    case 'FACULTY':
      return messMenu();
    case 'LATEST EVENTS':
      return messMenu();
    case 'FEEDBACK':
      return messMenu();
    default:
      return Container();
  }
}

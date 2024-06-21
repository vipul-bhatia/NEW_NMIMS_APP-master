import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import './SignIn.dart';

class AuthOnboarding extends StatefulWidget {
  @override
  State<AuthOnboarding> createState() => _AuthOnboardingState();
}

class _AuthOnboardingState extends State<AuthOnboarding> {
  late RiveAnimationController _btnAnimationController;

  void initState() {
    _btnAnimationController = OneShotAnimation(
      "active",
      autoplay: false,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Container(
              child: Stack(
                  children: [
              Positioned(
                  width: MediaQuery.of(context).size.width * 1.7,
                  bottom: 200,
                  left: 100,
                  child: Image.asset('assets/Spline.png')),
              Positioned.fill(
                  child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 10),
              )),
              RiveAnimation.asset('assets/shapes.riv'),
              Positioned.fill(
                  child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                child: SizedBox(),
              )),
              SafeArea(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
                child: Column(
                  children: [
                    Spacer(),
                    SizedBox(
                      width: 240,
                      child: Column(
                        children: [
                          Text(
                            'Let\'s get started',
                            style: TextStyle(
                                fontSize: 60,
                                height: 1.2,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Create an account to get all features',
                            style: TextStyle(fontSize: 20, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        _btnAnimationController.isActive = true;
                        Future.delayed(Duration(milliseconds: 800), () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignIn()));
                        });
                      },
                      child: SizedBox(
                        
                        height: 64,
                        width: 260,
                        child: Stack(
                          children: [
                            RiveAnimation.asset(
                              'assets/button.riv',
                              controllers: [_btnAnimationController],
                            ),
                            Positioned.fill(
                              top: 8,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.black,
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    'Login or Sign up',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ))
                  ],
                ),
            ),
          ),
        ));
  }
}

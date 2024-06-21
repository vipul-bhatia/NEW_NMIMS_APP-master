import 'package:auth/auth.dart';
import 'package:flutter/material.dart';

// AuthOnboarding page
import 'package:rive_animation/Authentication/AuthOnboarding.dart';

class messMenu extends StatefulWidget {
  const messMenu({super.key});

  @override
  State<messMenu> createState() => _messMenuState();
}

class _messMenuState extends State<messMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: Center(
        child: TextButton(child: Text('Logout'), onPressed: (){
          FirebaseAuth.instance.signOut();
          Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) => AuthOnboarding()));
        })
      )
    );
  }
}
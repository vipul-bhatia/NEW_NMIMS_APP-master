import 'package:auth/auth.dart';
import 'package:flutter/material.dart';

//pages
import './AuthOnboarding.dart';
import '../Home/Navigation/navPage.dart';

class authDecider extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
         if(snapshot.hasData){
           return navPage();
         }else{
           return AuthOnboarding();
         }
        },
      ),
    );
  }
}
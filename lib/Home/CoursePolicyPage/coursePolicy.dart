import 'package:flutter/material.dart';

class coursePolicy extends StatefulWidget {
  const coursePolicy({super.key});

  @override
  State<coursePolicy> createState() => _coursePolicyState();
}

class _coursePolicyState extends State<coursePolicy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: Center(
        child: Text('Course Policy'),
      )
    );
  }
}
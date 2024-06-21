import 'package:auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rive_animation/Authentication/services/GoogleService.dart';

//pages

import '../Home/Navigation/navPage.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isShowLoading = false;
  bool isShowConfetti = false;

  late SMITrigger check;
  late SMITrigger error;
  late SMITrigger reset;

  late SMITrigger confetti;

  StateMachineController getRiveController(Artboard artboard) {
    StateMachineController? controller =
        StateMachineController.fromArtboard(artboard, "State Machine 1");
    artboard.addController(controller!);

    return controller;
  }

  StateMachineController? controller;

  SMIInput<bool>? isChecking;

  SMIInput<bool>? isHandsUp;

  SMIInput<bool>? trigSuccess;

  SMIInput<bool>? trigFail;

  final usernameController = TextEditingController();

  final passwordController = TextEditingController();

  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black, size: 30),
        elevation: 0,
        backgroundColor: Color(0xffD6E2EA),
      ),
      backgroundColor: Color(0xffD6E2EA),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Stack(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //rive animation
                      SizedBox(
                        width: size.width,
                        height: 300,
                        child: RiveAnimation.asset(
                          "assets/login_animation.riv",
                          stateMachines: const ["Login Machine"],
                          onInit: (artboard) {
                            controller = StateMachineController.fromArtboard(
                                artboard, "Login Machine");
                            if (controller == null) return;

                            artboard.addController(controller!);
                            isChecking = controller?.findInput("isChecking");
                            isHandsUp = controller?.findInput("isHandsUp");
                            trigSuccess = controller?.findInput("trigSuccess");
                            trigFail = controller?.findInput("trigFail");
                          },
                        ),
                      ),

                      const SizedBox(height: 10),
                      TextFormField(
                        controller: usernameController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "";
                          }
                          return null;
                        },
                        onSaved: (email) {},
                        onChanged: (value) {
                          if (isHandsUp != null) {
                            isHandsUp!.change(false);
                          }
                          if (isChecking == null) return;

                          isChecking!.change(true);
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: "E mail",
                          prefixIcon: const Icon(Icons.mail),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: passwordController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "";
                          }
                          return null;
                        },
                        onSaved: (password) {},
                        onChanged: (value) {
                          if (isChecking != null) {
                            isChecking!.change(false);
                          }
                          if (isHandsUp == null) return;

                          isHandsUp!.change(true);
                        },
                        obscureText: true, // to hide password
                        decoration: InputDecoration(
                          hintText: "Password",
                          prefixIcon: const Icon(Icons.lock),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                       TextFormField(
                        controller: confirmPasswordController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "";
                          }
                          return null;
                        },
                        onSaved: (confirmPassword) {},
                        onChanged: (value) {
                          if (isHandsUp != null) {
                            isHandsUp!.change(false);
                          }
                          if (isChecking == null) return;

                          trigSuccess!.change(true);
                        },
                        obscureText: true, // to hide password
                        decoration: InputDecoration(
                          hintText: "Confirm Password",
                          prefixIcon: const Icon(Icons.lock),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),


                      MaterialButton(
                        minWidth: size.width,
                        height: 50,
                        color: Colors.purple,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        onPressed: () async {
                          setState(() {
                            isShowLoading = true;
                            isShowConfetti = true;
                          });

                          try {
                            if(passwordController.text == confirmPasswordController.text){
                             await FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                              email: usernameController.text,
                              password: passwordController.text,
                              
                            );

                            }else{
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Password Mismatch"),
                                    content: Text("Please check your password"),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text("OK"),
                                      ),
                                    ],
                                  );
                                },
                              
                              );
                            }

                            // List of all the animations to run in parallel
                            final List<Future> animations = [
                              Future.delayed(Duration(seconds: 1))
                                  .then((_) => check.fire()),
                              Future.delayed(Duration(seconds: 2))
                                  .then((_) => confetti.fire()),
                              Future.delayed(Duration(seconds: 3)).then((_) {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) => const navPage()));
                               
                              }),
                            ];

                            // Wait for all the animations to complete
                            await Future.wait(animations);

                            setState(() {
                              isShowLoading = false;
                            });
                          } on FirebaseException {
                            error.fire();
                            Future.delayed(Duration(seconds: 2), () {
                              setState(() {
                          
                                isShowLoading = false;
                              });
                            });
                          }

                          // Future.delayed(const Duration(seconds: 1), () {
                          //   if (_formKey.currentState!.validate()) {
                          //     check.fire();

                          //     Future.delayed(Duration(seconds: 2), () {
                          //       setState(() {
                          //         isShowLoading = false;
                          //       });

                          //       confetti.fire();

                          //     });
                          //   } else {
                          //     error.fire();
                          //     Future.delayed(Duration(seconds: 2), () {
                          //       setState(() {
                          //         isShowLoading = false;
                          //       });
                          //     });
                          //   }
                          // });
                        },
                        child: const Text(
                          "Register",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),

                      // google or facebook login
                      const SizedBox(height: 10),
                      SizedBox(
                        width: size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Or Register with"),
                            const SizedBox(width: 10),
                            IconButton(
                                onPressed: () {
                                  // todo google login
                                  GoogleService().signInWithGoogle();
                                },
                                icon: FaIcon(FontAwesomeIcons.google)),
                            IconButton(
                              onPressed: () {
                                // todo facebook login
                              },
                              icon: FaIcon(FontAwesomeIcons.facebook),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                isShowLoading
                    ? Positioned.fill(
                        child: Column(
                        children: [
                          Spacer(),
                          SizedBox(
                            height: 100,
                            width: 100,
                            child: RiveAnimation.asset(
                              'assets/login_loading.riv',
                              onInit: (artboard) {
                                StateMachineController controller =
                                    getRiveController(artboard);
                                check =
                                    controller.findSMI("Check") as SMITrigger;
                                error =
                                    controller.findSMI("Error") as SMITrigger;
                                reset =
                                    controller.findSMI("Reset") as SMITrigger;
                              },
                            ),
                          ),
                          Spacer(flex: 2)
                        ],
                      ))
                    : const SizedBox(),
                isShowConfetti
                    ? Positioned.fill(
                        child: Column(
                          children: [
                            Spacer(),
                            SizedBox(
                              height: 100,
                              width: 100,
                              child: Transform.scale(
                                scale: 7,
                                child: RiveAnimation.asset(
                                  'assets/confetti.riv',
                                  onInit: (artboard) {
                                    StateMachineController controller =
                                        getRiveController(artboard);
                                    confetti =
                                        controller.findSMI("Trigger explosion")
                                            as SMITrigger;
                                  },
                                ),
                              ),
                            ),
                            Spacer(
                              flex: 2,
                            ),
                          ],
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

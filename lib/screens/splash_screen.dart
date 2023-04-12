import 'package:auctify/const/constants.dart';
import 'package:auctify/screens/home_screen.dart';
import 'package:auctify/screens/signin_screen.dart';
import 'package:auctify/screens/signup_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    timer();
  }

  // logic to navigate to another screen after 2 seconds automatically.
  Future timer() {
    final time = Future.delayed(Duration(seconds: 2), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SigninScreen()));
    });
    return time;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [backgroundColorShade1, backgroundColorShade2],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight)),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset('assets/images/logo.png'),
          SizedBox(
            height: 10.0,
          ),
          Text("Auctify"),
          SizedBox(
            height: 10,
          ),
          Text("Alliviate your predicament through merchandising."),
        ]),
      ),
    );
  }
}

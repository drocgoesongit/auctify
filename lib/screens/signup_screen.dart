import 'package:auctify/const/constants.dart';
import 'package:auctify/screens/home_screen.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
          child: Column(
        children: [
          const Text("Welcome to \nAuctify", style: kPageTitle,),
          Expanded(
            child: Container(),
          ),
          const Text("username"),
          TextFormField(),
          const Text("email"),
          TextFormField(),
          const Text("password"),
          TextFormField(),
          MaterialButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
            },
            color: primaryAccentColor,
            child: const Text("Sign up"),
          ),
          const Text("Not a member? Sign up"),
        ],
      )
      ),
    );
  }
}

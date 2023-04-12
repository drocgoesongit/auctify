import 'package:auctify/const/constants.dart';
import 'package:auctify/screens/signup_screen.dart';
import 'package:flutter/material.dart';

class SigninScreen extends StatelessWidget {
  const SigninScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
          child: Column(
        children: [
          const Text(
            "Welcome to \nAuctify",
            style: kPageTitle,
          ),
          Expanded(
            child: Container(),
          ),
          const Text("email"),
          TextFormField(),
          const Text("password"),
          TextFormField(
            obscureText: true,
          ),
          MaterialButton(
            onPressed: () {
              Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignUpScreen()));
            },
            color: primaryAccentColor,
            child: const Text("Sign in"),
          ),
          GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignUpScreen()));
              },
              child: const Text("Not a member? Sign up")),
        ],
      )),
    );
  }
}

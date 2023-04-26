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
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20.0),
            child: const Text(
              "Welcome to \nAuctify",
              style: kPageTitle,
            ),
          ),
          Expanded(
            child: Container(
              child: Image.asset("assets/images/signin.png"),
            ),
          ),
          Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: const Text("email")),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
            child: TextFormField(
                style: kTextFormFieldBasic,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  fillColor: secondaryAccentColor,
                  filled: true,
                  hintText: "Enter your email",
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 1,
                        color: Colors.black.withOpacity(0.3)), //<-- SEE HERE
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 1,
                        color: Colors.black.withOpacity(0.3)), //<-- SEE HERE
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                )),
          ),
          Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: const Text("password")),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
            child: TextFormField(
                obscureText: true,
                style: kTextFormFieldBasic,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  fillColor: secondaryAccentColor,
                  filled: true,
                  hintText: "Enter your password",
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 1,
                        color: Colors.black.withOpacity(0.3)), //<-- SEE HERE
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 1,
                        color: Colors.black.withOpacity(0.3)), //<-- SEE HERE
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50.0),
                backgroundColor: primaryAccentColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignUpScreen()));
              },
              child: Text(
                "Sign in",
                style:
                    kAppbarTitle.copyWith(color: Colors.white, fontSize: 16.0),
              ),
            ),
          ),
          GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignUpScreen()));
              },
              child: const Text.rich(TextSpan(children: [
                TextSpan(text: "Don't have an account? "),
                TextSpan(
                    text: "Sign up",
                    style: TextStyle(fontWeight: FontWeight.bold))
              ]))),
          const SizedBox(
            height: 40.0,
          ),
        ],
      )),
    );
  }
}

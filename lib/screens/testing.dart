import 'package:auctify/const/constants.dart';
import 'package:auctify/screens/home_screen.dart';
import 'package:auctify/screens/signin_screen.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              width: double.infinity,
              child: const Text(
                "Welcome to \nAuctify",
                style: kPageTitle,
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: Image.asset("assets/images/signup.png"),
            ),
          ),
          Row(
            children: [
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: const Text("username")),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                child: Container(
                  width: 160,
                  height: 60,
                  child: TextFormField(
                      style: kTextFormFieldBasic,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        fillColor: secondaryAccentColor,
                        filled: true,
                        hintText: "Enter your username",
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1,
                              color:
                                  Colors.black.withOpacity(0.3)), //<-- SEE HERE
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1,
                              color:
                                  Colors.black.withOpacity(0.3)), //<-- SEE HERE
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      )),
                ),
              ),
            ],
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
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              },
              child: Text(
                "Sign up",
                style:
                    kAppbarTitle.copyWith(color: Colors.white, fontSize: 16.0),
              ),
            ),
          ),
          GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SigninScreen()));
              },
              child: const Text.rich(TextSpan(children: [
                TextSpan(text: "Already have an account, "),
                TextSpan(
                    text: "Sign in",
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

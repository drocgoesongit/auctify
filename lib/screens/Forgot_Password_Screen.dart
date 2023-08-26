import 'package:auctify/screens/signin_screen.dart';
import 'package:auctify/viewmodels/signin_viewmodel.dart';
import 'package:flutter/material.dart';

import '../const/constants.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formkey = GlobalKey<FormState>();
  String _email = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
          child: Form(
        key: _formkey,
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              child: Image.asset("assets/images/signin.png"),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(left: 20.0),
              child: const Text(
                "Welcome to \nAuctify",
                style: kPageTitle,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 40.0),
              child: const Text(
                "Forgot Password?",
                style: mediumTitle,
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: 8.0, left: 20.0, right: 20.0),
              child: const Text(
                "Enter your email and we’ll send you a link to reset your password.",
                style: normalText,
              ),
            ),
            Container(
                width: double.infinity,
                padding: const EdgeInsets.only(left: 28.0, top: 30),
                child: const Text(
                  "Email",
                  style: smallImportant,
                )),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 8.0),
              child: TextFormField(
                style: kTextFormFieldBasic,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  fillColor: secondaryAccentColor,
                  filled: true,
                  prefixIcon: const Icon(
                    Icons.email_rounded,
                    color: Colors.black,
                  ),
                  hintText: "Enter your email",
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 1,
                        color: Colors.black.withOpacity(0.3)), //<-- SEE HERE
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 1,
                        color: Colors.black.withOpacity(0.3)), //<-- SEE HERE
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter Email";
                  }
                  return null;
                },
                onChanged: (val) {
                  setState(() {
                    _email = val;
                  });
                },
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 32.0, right: 20.0, left: 20.0),
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(400.0, 50.0),
                  backgroundColor: primaryAccentColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                ),
                onPressed: () {
                  if (_formkey.currentState!.validate()) {
                    SignInBackend().resetPassword(context, _email);
                  }
                },
                child: Text(
                  "Send Email",
                  style: normalImportant.copyWith(color: Colors.white),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SigninScreen()));
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.arrow_back_ios_new_outlined,
                      size: 18,
                    ),
                    Padding(padding: EdgeInsets.only(left: 8)),
                    Text(
                      "Back to Login",
                      style: normalImportant,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 40.0,
            ),
          ],
        ),
      )),
    );
  }
}

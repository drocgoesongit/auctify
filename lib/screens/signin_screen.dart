import 'package:auctify/const/constants.dart';
import 'package:auctify/screens/Forgot_Password_Screen.dart';
import 'package:auctify/screens/signup_screen.dart';
import 'package:auctify/viewmodels/signin_viewmodel.dart';
import 'package:flutter/material.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  bool _isObscured = true;
  final _formkey = GlobalKey<FormState>();
  String _email = "";
  String _password = "";

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
              width: double.infinity,
              padding: const EdgeInsets.all(20.0),
              child: const Text(
                "Welcome to \nAuctify",
                style: kPageTitle,
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              child: Image.asset("assets/images/signin.png"),
            ),
            Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: const Text("Email")),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
              child: TextFormField(
                style: kTextFormFieldBasic,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  fillColor: secondaryAccentColor,
                  filled: true,
                  prefixIcon: Icon(Icons.email_rounded),
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
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter Email";
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _email = value;
                  });
                },
              ),
            ),
            Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: const Text("Password")),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
              child: TextFormField(
                obscureText: _isObscured,
                style: kTextFormFieldBasic,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  fillColor: secondaryAccentColor,
                  filled: true,
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        _isObscured = !_isObscured;
                      });
                    },
                    child: Icon(
                        _isObscured ? Icons.visibility : Icons.visibility_off),
                  ),
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
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Password';
                  } else if (value.length < 6) {
                    return 'Password length is short';
                  }
                  return null;
                },
                onChanged: (value) => _password = value,
              ),
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
                  if (_formkey.currentState!.validate()) {
                    SignInBackend().loginWithEmail(_email, _password, context);
                  }
                },
                child: Text(
                  "Sign in",
                  style: kAppbarTitle.copyWith(
                      color: Colors.white, fontSize: 16.0),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUpScreen()));
                        },
                        child: const Text.rich(TextSpan(children: [
                          TextSpan(text: "Not a Member? "),
                          TextSpan(
                              text: "Sign up",
                              style: TextStyle(fontWeight: FontWeight.bold))
                        ]))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ForgotPassword()));
                        },
                        child: const Text.rich(TextSpan(children: [
                          TextSpan(
                              text: "Forgot Password?",
                              style: TextStyle(fontWeight: FontWeight.bold))
                        ]))),
                  ),
                ),
              ],
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

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
              padding: EdgeInsets.only(top: 35.0),
              height: MediaQuery.of(context).size.height * 0.3,
              child: Image.asset("assets/images/login_new.png"),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(left: 20.0),
              child: const Text(
                "Welcome \nBack!",
                style: kPageTitle,
              ),
            ),
            Container(
                width: double.infinity,
                padding: const EdgeInsets.only(left: 28.0, top: 40.0),
                child: const Text(
                  "Email",
                  style: smallImportant,
                )),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
              child: TextFormField(
                style: kTextFormFieldBasic,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  fillColor: secondaryAccentColor,
                  filled: true,
                  prefixIcon: Icon(
                    Icons.email_rounded,
                    color: Colors.black,
                  ),
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
                padding: const EdgeInsets.only(left: 28.0, top: 16.0),
                child: const Text("Password", style: smallImportant)),
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
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Colors.black,
                  ),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        _isObscured = !_isObscured;
                        Colors.black;
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
              padding:
                  const EdgeInsets.only(left: 20.0, right: 20.0, top: 24.0),
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
                    SignInBackend().loginWithEmail(_email, _password, context);
                  }
                },
                child: Text(
                  "Sign in",
                  style: normalImportant.copyWith(color: Colors.white),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30.0, top: 10.0),
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
                          TextSpan(text: "Not a Member? ", style: smallNormal),
                          TextSpan(text: "Sign up", style: smallImportant)
                        ]))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 30.0, top: 10),
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
                              text: "Forgot Password?", style: smallImportant)
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

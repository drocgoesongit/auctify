import 'dart:developer';
import 'package:auctify/const/constants.dart';
import 'package:auctify/screens/signin_screen.dart';
import 'package:auctify/viewmodels/signin_viewmodel.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

// points
// all the paddings must be static once defined and then used wherever needed.
// try to add padding to the parent element rather than adding to each element separately,
// can do it if you want to add different padding.
// add proper on focus colors and stuff.
// also FirstName and last Name must also have some icon.
// confirm password is missing in sign up screen.
// sign up with google is missing.
// sign in with goolge.
// data is not getting stored anywhere.
// no auto scroll while typing as keyboard opens. can be done using scaffold _> resizetoAvoidBottomInset
// when you add scrolls you can't add expanded in there.
// focus management is absent.
// Input decoration must be static, if not possible then only focused and enabled border and then used wherever needed.
// proper backend functions to make login and signup resilient and also add proper checks to handle edge cases.
// format users firstname and lastName as CamelCase, no space.

class _SignUpScreenState extends State<SignUpScreen> {
  bool _isObscured = true;
  final _formkey = GlobalKey<FormState>();
  String _email = "";
  String _password = "";
  String _firstName = "";
  String _lastName = "";
  String _confirmPassword = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Form(
        key: _formkey,
        child: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 35.0),
                height: MediaQuery.of(context).size.height * 0.3,
                child: Image.asset("assets/images/login_new.png"),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Container(
                  width: double.infinity,
                  child: const Text(
                    "Welcome to \nAuctify",
                    style: kPageTitle,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 28.0, top: 40.0),
                          child: const Text(
                            "First name",
                            style: smallImportant,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, top: 8.0),
                          child: Container(
                            height: 50,
                            child: TextFormField(
                              style: kTextFormFieldBasic,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.account_circle_outlined),
                                fillColor: secondaryAccentColor,
                                filled: true,
                                hintText: "First name",
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: Colors.black.withOpacity(0.3),
                                  ),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: Colors.black.withOpacity(0.3),
                                  ),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter first name";
                                }
                                return null;
                              },
                              onChanged: (value) {
                                setState(() {
                                  _firstName = value;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 28.0, top: 40.0),
                          child: const Text(
                            "Last name",
                            style: smallImportant,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 20.0, left: 10.0, top: 8.0),
                          child: Container(
                            height: 50,
                            child: TextFormField(
                              style: kTextFormFieldBasic,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.account_circle_outlined),
                                fillColor: secondaryAccentColor,
                                filled: true,
                                hintText: "Last name",
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: Colors.black.withOpacity(0.3),
                                  ),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: Colors.black.withOpacity(0.3),
                                  ),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter last name";
                                }
                                return null;
                              },
                              onChanged: (value) {
                                setState(() {
                                  _lastName = value;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(left: 28.0, top: 16.0),
                  child: const Text(
                    "Email",
                    style: smallImportant,
                  )),
              Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, right: 20.0, top: 8.0),
                child: TextFormField(
                  style: kTextFormFieldBasic,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    fillColor: secondaryAccentColor,
                    filled: true,
                    prefixIcon: Icon(Icons.email),
                    focusColor: Colors.black,
                    prefixIconColor: Colors.black87,
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
                  child: const Text(
                    "Password",
                    style: smallImportant,
                  )),
              Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, right: 20.0, top: 8.0),
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
                        });
                      },
                      child: Icon(
                        _isObscured ? Icons.visibility : Icons.visibility_off,
                        color: Colors.black,
                      ),
                    ),
                    hintText: "Enter your password",
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
                      return 'Please enter Password';
                    } else if (value.length < 6) {
                      return 'Password length is short';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _password = value;
                    });
                  },
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(left: 28.0, top: 16.0),
                child: const Text(
                  "Confirm Password",
                  style: smallImportant,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, right: 20.0, top: 8.0),
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
                        });
                      },
                      child: Icon(
                        _isObscured ? Icons.visibility : Icons.visibility_off,
                        color: Colors.black,
                      ),
                    ),
                    hintText: "Confirm your password",
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: Colors.black.withOpacity(0.3),
                      ),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: Colors.black.withOpacity(0.3),
                      ),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your Password';
                    } else if (value != _password) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _confirmPassword = value;
                    });
                  },
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
                      _formkey.currentState!.save();
                      log(
                        "First name: $_firstName, Last name: $_lastName, Email: $_email, Password: $_password",
                      );
                      SignInBackend().registerWithEmail(
                          _email, _password, _firstName, _lastName, context);

                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => HomeScreen()));
                    }
                  },
                  child: Text(
                    "Sign up",
                    style: normalImportant.copyWith(color: Colors.white),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SigninScreen()));
                    },
                    child: const Text.rich(TextSpan(children: [
                      TextSpan(
                          text: "Already have an account, ",
                          style: smallNormal),
                      TextSpan(text: "Sign in", style: smallImportant)
                    ]))),
              ),
              const SizedBox(
                height: 40.0,
              ),
            ],
          ),
        )),
      ),
    );
  }
}

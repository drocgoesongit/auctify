import 'dart:developer';
import 'package:auctify/models/user_login_model.dart';
import 'package:auctify/screens/home_screen.dart';
import 'package:auctify/screens/signin_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignInBackend {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // register with email and password
  Future<bool?> registerWithEmail(String email, String password,
      String firstName, String lastName, BuildContext context) async {
    try {
      showDialog(
          context: context,
          builder: ((context) => const Center(
                child: CircularProgressIndicator(),
              )));
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      log("User created successfully");
      String uid = auth.currentUser!.uid;
      String timeStamp = DateTime.now().toString();
      if (uid.isNotEmpty) {
        UserLoginModel userLoginModel = UserLoginModel(
          email: email,
          firstName: firstName,
          lastName: lastName,
          registerTime: timeStamp,
          uid: uid,
        );
        await firestore
            .collection("users")
            .doc(auth.currentUser!.uid)
            .set(userLoginModel.toMap());
        log("User added to firestore successfully");
      } else {
        throw Exception("User id is empty");
      }
      Navigator.pop(context);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
          (route) => false);
      // user created successfully
      return true; // Registration successful
    } catch (e) {
      Navigator.pop(context);
      log("Error while creating user with email and password: ${e.toString()}");
      return false; // Return error message if registration fails
    }
  }

  // login with email and password
  Future<bool?> loginWithEmail(
      String email, String password, BuildContext context) async {
    try {
      showDialog(
          context: context,
          builder: ((context) => const Center(
                child: CircularProgressIndicator(),
              )));

      if (auth.currentUser != null) {
        Navigator.pop(context);
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text("Sign out"),
                  content: const Text(
                      "You are already signed in. Please sign out to continue."),
                  actions: [
                    TextButton(
                        onPressed: () async {
                          await auth.signOut();
                          Navigator.pop(context);
                        },
                        child: const Text("Sign out"))
                  ],
                ));
      } else {
        await auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        Navigator.pop(context);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const HomeScreen()));
        log("User logged in successfully");
      }

      return true; // Login successful
    } catch (e) {
      Navigator.pop(context);
      log("Error while logging in with email and password: ${e.toString()}");
      return false; // Return error message if login fails
    }
  }

  // logout
  Future<void> logout(BuildContext context) async {
    try {
      showDialog(
          context: context,
          builder: ((context) => const Center(
                child: CircularProgressIndicator(),
              )));
      await auth.signOut();
      Navigator.pop(context);
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const SigninScreen()));
      log("User logged out successfully");
    } catch (e) {
      Navigator.pop(context);
      log("Error while logging out: ${e.toString()}");
    }
  }

  // reset password
  Future<bool> resetPassword(BuildContext context, String email) async {
    try {
      showDialog(
          context: context,
          builder: ((context) => const Center(
                child: CircularProgressIndicator(),
              )));
      await auth.sendPasswordResetEmail(email: email);
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: ((context) => AlertDialog(
                title: Text("Success"),
                content: Text("Password reset email sent successfully."),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("OK"))
                ],
              )));
      log("Password reset email sent");

      return true;
    } catch (e) {
      if (e.toString().contains("user-not-found")) {
        Navigator.pop(context);
        log("User entered unregistered or wrong email for reset password.");
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text("Error"),
                  content: const Text(
                      "No user found with this email. Please check your email and try again."),
                  actions: [
                    TextButton(
                        onPressed: () async {
                          Navigator.pop(context);
                        },
                        child: const Text("OK"))
                  ],
                ));
      } else {
        Navigator.pop(context);
        log("Error while resetting password: ${e.toString()}");
      }

      return false;
    }
  }

  // // getting login details of user just for testings purposes.
  // Future<void> getLoginDetails() async {
  //   try {
  //     await firestore
  //         .collection("users")
  //         .doc(auth.currentUser!.uid)
  //         .get()
  //         .then((value) {
  //       log("getLoginDetails value: ${value.data()}");
  //       final snapShotData = value.data() as Map<String, dynamic>;
  //       UserModel userModel = UserModel.fromMap(snapShotData);
  //       log("userModel: ${userModel.toMap().toString()}");
  //     });
  //   } catch (e) {
  //     print("error in getting login details ${e.toString()}");
  //   }
  // }
}

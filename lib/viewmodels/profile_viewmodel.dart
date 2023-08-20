import 'dart:developer';

import 'package:auctify/models/user_login_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileViewModel {
  Future<UserLoginModel?> getUserProfile(BuildContext context) async {
    try {
      showDialog(
          context: context,
          builder: (builder) =>
              const Center(child: CircularProgressIndicator()));

      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      if (snapshot.exists) {
        UserLoginModel user =
            UserLoginModel.fromMap(snapshot.data() as Map<String, dynamic>);
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
        return user;
      } else {
        Navigator.pop(context);
        return null;
      }
    } catch (e) {
      Navigator.pop(context);
      log(e.toString());
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
      return null;
    }
  }
}

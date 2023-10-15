import 'dart:developer';

import 'package:auctify/models/address_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddressViewModel {
  Future<String> addAddress(AddressModel addressModel) async {
    try {
      await FirebaseFirestore.instance
          .collection("address")
          .doc(addressModel.addressId)
          .set(addressModel.toJson());
      log("address uploaded successfully.");
      return "success";
    } catch (e) {
      return "error";
    }
  }

  Future<List<AddressModel>> getAddresses() async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("address")
          .where("userId", isEqualTo: uid)
          .get();

      List<AddressModel> addressList = [];
      querySnapshot.docs.forEach((element) {
        addressList
            .add(AddressModel.fromJson(element.data() as Map<String, dynamic>));
      });

      log("address list fetched successfully.");
      return addressList;
    } catch (e) {
      log("error while fetching address list.");
      return [];
    }
  }
}

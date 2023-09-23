import 'dart:developer';
import 'package:auctify/const/util_functions.dart';
import 'package:auctify/models/product_model.dart';
import 'package:auctify/viewmodels/control_bidding.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductListViewModel {
  Future<List<ProductUploadModel>> getActiveProductList(
    BuildContext context,
  ) async {
    try {
      log("inside get product list function.");

      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection("products")
          .where("status", isEqualTo: "start")
          .get();
      List<ProductUploadModel> productList = [];

      if (snapshot.docs.isNotEmpty) {
        for (DocumentSnapshot doc in snapshot.docs) {
          Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
          ProductUploadModel product = ProductUploadModel.fromMap(data!);

          // checking for deactivating.
          final now = DateTime.now().millisecondsSinceEpoch;
          final endTime = UtilFunctions()
              .dateTimeToTimestamp(product.endDate, product.endTime);

          if (now > endTime!) {
            ControlBiddingViewModel().turnOffBidding(product.id);
          }

          productList.add(product);
          log(product.name.toString());
        }
      }

      return productList;
    } catch (e) {
      log(" error in getting active product from backend: ${e.toString()}");
      return [];
    }
  }

  Future<List<ProductUploadModel>> getDeactiveProductList(
    BuildContext context,
  ) async {
    try {
      log("inside get product list function.");

      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection("products")
          .where("status", isEqualTo: "deactive")
          .get();
      List<ProductUploadModel> productList = [];

      if (snapshot.docs.isNotEmpty) {
        for (DocumentSnapshot doc in snapshot.docs) {
          Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
          ProductUploadModel product = ProductUploadModel.fromMap(data!);

          productList.add(product);
          log(product.name.toString());
        }
      }

      return productList;
    } catch (e) {
      log(" error in getting deactive product from backend: ${e.toString()}");
      return [];
    }
  }
}

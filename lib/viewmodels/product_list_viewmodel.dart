import 'dart:developer';
import 'package:auctify/models/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductListViewModel {
  Future<List<ProductUploadModel>> getProductList(
    BuildContext context,
  ) async {
    try {
      log("inside get product list function.");

      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection("products").get();
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
      log(" error in getProductList backend: ${e.toString()}");
      return [];
    }
  }
}

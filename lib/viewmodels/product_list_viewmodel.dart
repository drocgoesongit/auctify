import 'dart:developer';
import 'package:auctify/const/util_functions.dart';
import 'package:auctify/models/product_chat_model.dart';
import 'package:auctify/models/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
          log(doc.data().toString());
          Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
          log(data!.toString());
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

  Future<String> initiateChatPlusStatus(String productId) async {
    try {
      log("initiating trying to get chat and if not found then trying to initiate it.");
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection("chats")
          .where("productId", isEqualTo: productId)
          .get();

      if (snapshot.docs.isNotEmpty) {
        log("chat found for this product.");
        ProductChatModel chatModel = ProductChatModel.fromMap(
            snapshot.docs.first.data() as Map<String, dynamic>);
        return chatModel.chatId;
      } else {
        log("chat not found initiating chat.");
        String randomId = generateRandomId();
        ProductChatModel productChatModel = ProductChatModel(
            chatId: randomId, lastMessage: "", lastId: "", lastTime: "");
        await FirebaseFirestore.instance
            .collection("products")
            .doc(productId)
            .set(productChatModel.toMap(), SetOptions(merge: true));

        await FirebaseFirestore.instance.collection("chats").doc(randomId).set({
          "chatId": randomId,
          "productId": productId,
          "lastMessage": "",
          "lastId": "",
          "lastTime": "",
        });

        return randomId;
      }
    } catch (e) {
      log("error in initiateChatPlusStatus backend: ${e.toString()}");
      return "error";
    }
  }

  Future<String> addToWishlist(String productId) async {
    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;
      log("Adding product to wishlist for user: $userId");

      // Get the existing wishlist document for the user
      DocumentSnapshot wishlistSnapshot = await FirebaseFirestore.instance
          .collection("wishlist")
          .doc(userId)
          .get();

      if (wishlistSnapshot.exists) {
        await FirebaseFirestore.instance
            .collection("wishlist")
            .doc(userId)
            .update({
          "productIds": FieldValue.arrayUnion([productId]),
        });
      } else {
        await FirebaseFirestore.instance
            .collection("wishlist")
            .doc(userId)
            .set({
          "productIds": FieldValue.arrayUnion([productId]),
        });
      }

      log("Product(s) added to wishlist for user: $userId");
      return "success";
    } catch (e) {
      log("Error in addToWishlist backend: ${e.toString()}");
      return "error";
    }
  }

  Future<List<ProductUploadModel>> getProductListWithSearchQueryAndCategory(
      BuildContext context,
      String? searchQuery,
      String category // Add search query parameter
      ) async {
    try {
      log("Inside get product list function.");

      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection("products")
          .orderBy('name') // Order products by name
          .get();
      List<ProductUploadModel> productList = [];

      if (snapshot.docs.isNotEmpty) {
        for (DocumentSnapshot doc in snapshot.docs) {
          Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;

          ProductUploadModel product = ProductUploadModel.fromMap(data!);

          if (searchQuery == "all" && category == "all") {
            productList.add(product);
          } else if (searchQuery == "all" && category != "all") {
            if (!product.categories.contains(category)) {
              continue;
            }
          } else if (searchQuery != null && searchQuery.isNotEmpty) {
            String productName = product.name.toLowerCase();
            if (!productName.contains(searchQuery.toLowerCase())) {
              if (category != "all" && !product.categories.contains(category)) {
                continue;
              }
              continue; // Skip products that don't match he search query
            }
          }
          if (productList.contains(product)) {
            continue;
          } else {
            productList.add(product);
          }
        }
      }

      return productList;
    } catch (e) {
      log("Error in getProductList backend: ${e.toString()}");
      return [];
    }
  }
}

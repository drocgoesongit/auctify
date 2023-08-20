import 'dart:developer';
import 'package:auctify/models/bid_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BiddingBackend {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> placeBid(
    BidModel bidModel,
    BuildContext context,
  ) async {
    try {
      showDialog(
        context: context,
        builder: (context) => Container(
            height: 200,
            width: 200,
            padding: EdgeInsets.all(20),
            child: Center(
              child: CircularProgressIndicator(),
            )),
        barrierDismissible: false,
      );
      log("starting to place a bid");
      List<BidModel> bidList = await getAllBids(bidModel.productId, context);
      if (bidList.isNotEmpty) {
        if (double.parse(bidModel.bidAmount) >
            double.parse(bidList.first.bidAmount)) {
          log("bid amount is higher than the last bid placed.");
          // uploading into bid root node.
          // uploading into product bids list.
          // updating the current price of the product.

          await _firestore
              .collection("bids")
              .doc(bidModel.bidId)
              .set(bidModel.toJson());

          await _firestore
              .collection("products")
              .doc(bidModel.productId)
              .update({"currentPrice": int.parse(bidModel.bidAmount)});

          await _firestore
              .collection("products")
              .doc(bidModel.productId)
              .collection("bids")
              .doc(bidModel.bidId)
              .set({
            "bidId": bidModel.bidId,
          });
          await reorderBids(bidModel.productId);
          Navigator.pop(context);
          return true;
        } else {
          log("there is higher bid placed.");
          Navigator.pop(context);
          return false;
        }
      } else {
        await _firestore
            .collection("bids")
            .doc(bidModel.bidId)
            .set(bidModel.toJson());

        await _firestore
            .collection("products")
            .doc(bidModel.productId)
            .update({"currentPrice": int.parse(bidModel.bidAmount)});

        await _firestore
            .collection("products")
            .doc(bidModel.productId)
            .collection("bids")
            .doc(bidModel.bidId)
            .set({
          "bidId": bidModel.bidId,
        });

        await reorderBids(bidModel.productId);
        Navigator.pop(context);
        return true;
      }
    } catch (e) {
      log("Error in placing bid: $e");
      return false;
    }
  }

  Future<List<BidModel>> getAllBids(
      String productId, BuildContext context) async {
    List<BidModel> bidList = [];
    log("started getting bid functions.");
    try {
      QuerySnapshot snapshot = await _firestore
          .collection("bids")
          .where("productId", isEqualTo: productId)
          .orderBy("bidAmount", descending: true)
          .get();

      if (snapshot.docs.isNotEmpty) {
        for (DocumentSnapshot doc in snapshot.docs) {
          Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
          BidModel bidModel = BidModel.fromJson(data!);
          bidList.add(bidModel);
        }
      } else {
        log("no bids found for product id-$productId");
      }

      log("Bid list length for product id-$productId: ${bidList.length}");
      return bidList;
    } catch (e) {
      log("Error in getting all bids: $e");
      return [];
    }
  }

  Future<bool> reorderBids(String productId) async {
    try {
      log("started reordering bids");
      List<BidModel> bidList = [];

      // Fetch the bids from Firestore
      QuerySnapshot snapshot = await _firestore
          .collection("bids")
          .where("productId", isEqualTo: productId)
          .orderBy("bidAmount", descending: true)
          .get();

      if (snapshot.docs.isNotEmpty) {
        for (DocumentSnapshot doc in snapshot.docs) {
          Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
          BidModel bidModel = BidModel.fromJson(data!);
          bidList.add(bidModel);
        }

        if (bidList.length > 1) {
          // Sort the bids in descending order based on bid amount
          bidList.sort((a, b) => b.bidAmount.compareTo(a.bidAmount));

          for (int i = 0; i < bidList.length; i++) {
            String bidId = bidList[i].bidId;
            String status;

            if (i == 0) {
              status = "winning";
            } else if (i == 1) {
              status = "second";
            } else if (i == 2) {
              status = "third";
            } else {
              status = "outbid";
            }

            // Update the bid document with the new status
            await FirebaseFirestore.instance
                .collection("bids")
                .doc(bidId)
                .update({
              "bidStatus": status,
            });
          }
        } else {
          // If there's only one bid, set its status as "winning"
          await FirebaseFirestore.instance
              .collection("bids")
              .doc(bidList.first.bidId)
              .update({
            "status": "winning",
          });
          log("Only one bid found for reordering bids.");
        }

        log("first bid: ${bidList.first.bidAmount}, last bid: ${bidList.last.bidAmount}");
        log("second bid: ${bidList[1].bidAmount}, second last bid: ${bidList[bidList.length - 2].bidAmount}");

        return true;
      } else {
        log("found no bid for reordering bids.");
        return false;
      }
    } catch (e) {
      log("Error in reordering bids: $e");
      return false;
    }
  }
}

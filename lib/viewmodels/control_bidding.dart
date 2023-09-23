import 'dart:developer';
import 'package:auctify/const/util_functions.dart';
import 'package:auctify/models/bid_model.dart';
import 'package:auctify/models/notification_model.dart';
import 'package:auctify/models/portal_model.dart';
import 'package:auctify/models/product_model.dart';
import 'package:auctify/models/user_login_model.dart';
import 'package:auctify/models/user_model.dart';
import 'package:auctify/viewmodels/send_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ControlBiddingViewModel {
  // algorithm to turn off bidding once the time has passed.
  Future<void> turnOffBidding(String id) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      DocumentSnapshot snapshot =
          await firestore.collection("products").doc(id).get();

      Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
      ProductUploadModel product = ProductUploadModel.fromMap(data!);
      final now = DateTime.now().millisecondsSinceEpoch;
      final endTime =
          UtilFunctions().dateTimeToTimestamp(product.endDate, product.endTime);

      log("ControlBidding: now: $now, endTime: $endTime");

      if (now > endTime!) {
        final bids = await firestore
            .collection("bids")
            .where("productId", isEqualTo: id)
            .orderBy("bidAmount", descending: true)
            .get();
        List<BidModel> bidsList = [];

        for (var bidDocuments in bids.docs) {
          final bidData = bidDocuments.data();
          BidModel bid = BidModel.fromJson(bidData);
          bidsList.add(bid);
        }
        log("controlBidding: winner, bidsList[0].bidderId");
        await firestore.collection("products").doc(id).set(
            {"status": "deactive", "winner": bidsList[0].bidderId},
            SetOptions(merge: true));

        DocumentSnapshot snapshot =
            await firestore.collection("users").doc(bidsList[0].bidderId).get();
        UserLoginModel user =
            UserLoginModel.fromMap(snapshot.data() as Map<String, dynamic>);

        // start portal.
        int bid = int.parse(bidsList[0].bidAmount);
        String portalStatus = await startPortal(id, bidsList[0].bidderId, bid,
            bidsList.length, user.email, "${user.firstName} ${user.lastName}");

        log("ControlBidding: Bidding turned off");
      }
    } catch (e) {
      print("ControlBidding: error in turning off bidding: ${e.toString()}");
    }
  }

  // algorithm to start portal
  Future<String> startPortal(String productId, String bidderId, int winnerBid,
      int numberOfBidders, String userAddress, String userName) async {
    try {
      // check for already existing portal.
      QuerySnapshot snapshots = await FirebaseFirestore.instance
          .collection("portal")
          .where("productId", isEqualTo: productId)
          .get();

      if (snapshots.docs.isNotEmpty) {
        log("ControlBidding: portal already exist for this product.");
        return "exists";
      }

      String portalId = UtilFunctions().generateRandomId();
      String notificationId = UtilFunctions().generateRandomId();
      int endFutureTime = UtilFunctions().getFutureTimeMillis(3);
      int nowTime = DateTime.now().millisecondsSinceEpoch;
      Portal portal = Portal(
          portalId: portalId,
          startTime: nowTime,
          endTime: endFutureTime,
          productId: productId,
          portalStatus: "started",
          portalWinner: bidderId,
          portalWinnerBidAmount: winnerBid,
          portalCurrentWinner: bidderId,
          portalCurrentWinnerBidAmount: winnerBid,
          iterationCount: 1,
          notificationId: notificationId,
          totalNumberOfBidders: numberOfBidders);

      // create portal node start it .
      await FirebaseFirestore.instance
          .collection("portal")
          .doc(portalId)
          .set(portal.toJson());

      log("ControlBidding: portal node added successfully for the first time.");

      // update the product node.
      await FirebaseFirestore.instance
          .collection("products")
          .doc(productId)
          .set({
        "portal": portalId,
        "portalStatus": "started",
        "currentPortalUser": bidderId,
        "currentPortalPrice": winnerBid
      }, SetOptions(merge: true));
      log("ControlBidding: portal is updated on the product node.");

      // sending notifications.
      String status =
          await SendNotifications().sendWinnerEmail(userAddress, userName);

      if (status == "s") {
        NotificationModel notificationModel = NotificationModel(
            count: 1,
            notificationId: notificationId,
            portalId: portalId,
            productId: productId,
            notificationStatus: "sent",
            lastSentTime: DateTime.now().millisecondsSinceEpoch,
            senderId: bidderId);

        await FirebaseFirestore.instance
            .collection("notifications")
            .doc(notificationId)
            .set(notificationModel.toJson());

        log("ControlBidding: email sent successfully and also stored on the notification node.");
      } else {
        log("ControlBidding: email not sent");
      }

      return "success";
    } catch (e) {
      log("ControlBidding: error while starting portal: ${e.toString()}");
      return "error";
    }
  }
}

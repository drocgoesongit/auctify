import 'dart:developer';
import 'package:auctify/const/firebase_constant.dart';
import 'package:auctify/const/util_functions.dart';
import 'package:auctify/models/bid_model.dart';
import 'package:auctify/models/notification_model.dart';
import 'package:auctify/models/portal_model.dart';
import 'package:auctify/models/user_login_model.dart';
import 'package:auctify/viewmodels/send_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ManagePortalBackend {
  Future<String> checkForExistingPortals() async {
    try {
      QuerySnapshot snapshots = await FirebaseFirestore.instance
          .collection("portal")
          .where("portalStatus", isEqualTo: "started")
          .get();

      if (snapshots.docs.isNotEmpty) {
        log("${snapshots.docs.length} portal exist}");
        for (var doc in snapshots.docs) {
          manageExisitingPortal(doc.id);
        }
        return "${snapshots.docs.length}";
      } else {
        log("portal does not exist");
        return "not exists";
      }
    } catch (e) {
      log("error while checking for existing portal: ${e.toString()}");
      return "error";
    }
  }

  // algorithm to manage/finish the portal..
  Future<String> manageExisitingPortal(String portalId) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      log("looking into portal: $portalId");
      // check if it the time has ended then shift on to the next.
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection("portal")
          .doc(portalId)
          .get();

      Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
      Portal portal = Portal.fromJson(data!);

      final now = DateTime.now().millisecondsSinceEpoch;
      final endTime = portal.endTime;
      if (now > endTime) {
        if (portal.iterationCount > portal.totalNumberOfBidders) {
          log("total number of bidders has been reached.");
          log("turning the portal off and product unsold.");
          await FirebaseFirestore.instance
              .collection("portal")
              .doc(portalId)
              .set({"portalStatus": "failed"}, SetOptions(merge: true));

          await FirebaseFirestore.instance
              .collection("products")
              .doc(portal.productId)
              .set({
            "portalStatus": "failed",
            "status": "deactive",
            "currentPortalUser": "none"
          }, SetOptions(merge: true));
        }
        log("last user time has ended. now assigning the portal to the next bidder.");
        // get the next highest bidder and assign him the portal.
        QuerySnapshot snapshots = await FirebaseFirestore.instance
            .collection("bids")
            .where("productId", isEqualTo: portal.productId)
            .orderBy("bidAmount", descending: true)
            .get();

        List<BidModel> bidsList = [];

        for (var bidDocuments in snapshots.docs) {
          final bidData = bidDocuments.data();
          BidModel bid = BidModel.fromJson(bidData as Map<String, dynamic>);
          bidsList.add(bid);
        }

        int count = portal.iterationCount;
        for (int i = count; i < bidsList.length; i++) {
          if (bidsList[i].bidderId == portal.portalCurrentWinner) {
            count++;
            if (i == bidsList.length - 1) {
              log("total number of bidders has been reached.");
              log("turning the portal off and product unsold.");
              await FirebaseFirestore.instance
                  .collection("portal")
                  .doc(portalId)
                  .set({
                PortalFirebaseConstant().portalStatus: "failed",
                PortalFirebaseConstant().portalIterationCount: count++
              }, SetOptions(merge: true));

              await FirebaseFirestore.instance
                  .collection("products")
                  .doc(portal.productId)
                  .set({
                "portalStatus": "failed",
                "status": "deactive",
                "currentPortalUser": "none"
              }, SetOptions(merge: true));
            }
          } else {
            count++;
            break;
          }
        }
        int endTime = UtilFunctions().getFutureTimeMillis(3);
        int bidAmount = int.parse(bidsList[count - 1].bidAmount);
        if (count < bidsList.length) {
          log("assigning the portal to the next bidder.");
          await FirebaseFirestore.instance
              .collection("portal")
              .doc(portalId)
              .set({
            PortalFirebaseConstant().portalCurrentWinner:
                bidsList[count - 1].bidderId,
            PortalFirebaseConstant().portalCurrentWinnerBidAmount: bidAmount,
            PortalFirebaseConstant().portalIterationCount: count,
            PortalFirebaseConstant().portalStatus: "started",
            PortalFirebaseConstant().portalStartTime:
                DateTime.now().millisecondsSinceEpoch,
            PortalFirebaseConstant().portalEndTime: endTime,
          }, SetOptions(merge: true));

          await FirebaseFirestore.instance
              .collection("products")
              .doc(portal.productId)
              .set({
            "currentPortalUser": bidsList[count - 1].bidderId,
            "portalStatus": "started",
            "portalCount": count,
            "currentPortalPrice": bidAmount
          }, SetOptions(merge: true));
        }
        String notificationId = UtilFunctions().generateRandomId();

        DocumentSnapshot snapshot =
            await firestore.collection("users").doc(bidsList[0].bidderId).get();
        UserLoginModel user =
            UserLoginModel.fromMap(snapshot.data() as Map<String, dynamic>);

        // sending notifications.
        String status = await SendNotifications()
            .sendWinnerEmail(user.email, user.firstName);
        // TODO update notification node only when there is success email sent.

        NotificationModel notificationModel = NotificationModel(
            count: 1,
            notificationId: notificationId,
            portalId: portalId,
            productId: portal.productId,
            notificationStatus: "sent",
            lastSentTime: DateTime.now().millisecondsSinceEpoch,
            senderId: bidsList[count].bidderId);

        await FirebaseFirestore.instance
            .collection("notifications")
            .doc(notificationId)
            .set(notificationModel.toJson());

        return "updated";
      } else {
        log("portal is still running.");
        return "running";
      }
    } catch (e) {
      log("error while managing the portal: ${e.toString()}");
      return "error";
    }
  }
}

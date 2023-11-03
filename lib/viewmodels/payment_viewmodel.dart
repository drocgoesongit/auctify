import 'dart:developer';

import 'package:auctify/models/order_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PaymentViewModel {
  Future<String> createOrderAndFinishPortal(
      String portalId, OrderModel orderModel) async {
    try {
      // finish portal
      await FirebaseFirestore.instance
          .collection("portal")
          .doc(portalId)
          .update({
        "portalStatus": "finished",
      });
      // create new order
      await FirebaseFirestore.instance
          .collection("order")
          .doc(orderModel.id)
          .set(orderModel.toJson());
      // update product node
      await FirebaseFirestore.instance
          .collection("product")
          .doc(orderModel.productId)
          .update({"status": "sold", "portalStatus": "finished"});
      log("order created successfully.");
      return "success";
    } catch (e) {
      log(e.toString());
      return "error";
    }
  }
}

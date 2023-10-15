import 'dart:developer';
import 'package:auctify/models/portal_model.dart';
import 'package:auctify/models/product_model.dart';
import 'package:auctify/screens/add_address_screen.dart';
import 'package:auctify/screens/checkout_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AcceptPortalScreen extends StatelessWidget {
  AcceptPortalScreen({super.key, required this.portalId});

  final String portalId;
  late ProductUploadModel productModel;
  late Portal portalModel;

  Future<String> getBasicInfo() async {
    try {
      DocumentSnapshot portal = await FirebaseFirestore.instance
          .collection("portal")
          .doc(portalId)
          .get();
      if (portal.exists) {
        portalModel = Portal.fromJson(portal.data() as Map<String, dynamic>);
        DocumentSnapshot product = await FirebaseFirestore.instance
            .collection("products")
            .doc(portalModel.productId)
            .get();
        if (product.exists) {
          productModel = ProductUploadModel.fromMap(
              product.data() as Map<String, dynamic>);
          log("success in getting product and portal details in accept portal screen.");
          return "success";
        } else {
          return "";
        }
      } else {
        return "";
      }
    } catch (e) {
      log("error while getting product and portal details in accept portal screen.");
      return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(title: Text("Claim your bid.")),
        body: Column(
          children: [
            Expanded(
              child: Container(
                  child: FutureBuilder(
                builder: ((context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.data == "success") {
                      return Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                height: height * 0.2,
                                width: height * 0.2,
                                child: Image.network(productModel.imageList[0]),
                              ),
                              const SizedBox(
                                width: 20.0,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(productModel.name),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(productModel.description),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(productModel.currentPrice.toString()),
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            "Portal details",
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          ListTile(
                            title: Text(
                                "\$${portalModel.portalCurrentWinnerBidAmount} your bid amount"),
                            subtitle: Text(portalModel.portalId),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          ListTile(
                            title: Text(
                                "\$${portalModel.portalCurrentWinnerBidAmount} your bid amount"),
                            subtitle: Text(portalModel.portalId),
                          ),
                        ],
                      );
                    } else {
                      return Container(
                        child: Center(
                          child: Text("Error in getting product details."),
                        ),
                      );
                    }
                  } else {
                    return Container(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                }),
                future: getBasicInfo(),
              )),
            ),
            Container(
              height: height * 0.1,
              child: Row(children: [
                Expanded(
                  child: Container(
                    child: ElevatedButton(
                        onPressed: () {
                          // handle cancelling event.
                        },
                        child: Text("Cancel")),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Container(
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CheckOutScreen(
                                      portalModel: portalModel,
                                      productModel: productModel)));
                        },
                        child: Text("Proceed")),
                  ),
                ),
              ]),
            )
          ],
        ));
  }
}

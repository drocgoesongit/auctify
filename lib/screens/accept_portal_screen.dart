import 'dart:developer';
import 'package:auctify/const/constants.dart';
import 'package:auctify/models/bid_model.dart';
import 'package:auctify/models/portal_model.dart';
import 'package:auctify/models/product_model.dart';
import 'package:auctify/screens/add_address_screen.dart';
import 'package:auctify/screens/checkout_screen.dart';
import 'package:auctify/utils/product_detail_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AcceptPortalScreen extends StatefulWidget {
  AcceptPortalScreen(
      {super.key, required this.portalId, required this.productId});

  final String portalId;
  final String productId;

  @override
  State<AcceptPortalScreen> createState() => _AcceptPortalScreenState();
}

class _AcceptPortalScreenState extends State<AcceptPortalScreen> {
  late ProductUploadModel productModel;

  late Portal portalModel;

  Future<String> getBasicInfo() async {
    try {
      DocumentSnapshot portal = await FirebaseFirestore.instance
          .collection("portal")
          .doc(widget.portalId)
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

  Stream<List<BidModel>> getBidsStream(String productId) {
    return FirebaseFirestore.instance
        .collection('bids')
        .where('productId', isEqualTo: productId)
        .orderBy('bidAmount', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => BidModel.fromJson(doc.data())).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(title: Text("Claim your bid.")),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  child: FutureBuilder(
                builder: ((context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.data == "success") {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: height * 0.2,
                                  width: height * 0.2,
                                  child:
                                      Image.network(productModel.imageList[0]),
                                ),
                                const SizedBox(
                                  width: 20.0,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(productModel.name),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Text(
                                        productModel.description,
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Text(
                                          "\$${productModel.currentPrice.toString()}"),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            // Text(
                            //   "Portal details",
                            // ),
                            // SizedBox(
                            //   height: 10.0,
                            // ),
                            Container(
                              // padding: EdgeInsets.only(left: 20, right: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Your position",
                                        style: smallImportant,
                                      ),
                                      // SizedBox(height: 6),
                                      Text(
                                        "1st",
                                        style: normalImportant,
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Payment Time Remaining",
                                        style: smallImportant,
                                      ),
                                      Text(
                                        "30:50:01", // Replace with your real-time value
                                        style: smallImportant.copyWith(
                                            color: Colors.red),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Container(
                                width: 340.0,
                                height: 70.0,
                                decoration: BoxDecoration(
                                  color: Colors.blue.shade200,
                                  borderRadius: BorderRadius.circular(8.0),
                                  border: Border.all(
                                    color: Colors.blue, // Green border color
                                    width: 1.5, // Border width
                                  ),
                                ),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 16),
                                    ),
                                    Icon(Icons
                                        .info_outline_rounded), // Replace 'path_to_your_image' with the actual path to your image
                                    Padding(
                                      padding: EdgeInsets.only(left: 16),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                            padding: EdgeInsets.only(top: 8)),
                                        Text(
                                          'If you don’t want the product or if you fail to \nclaim the product within the stipulated time, \nit will be allocated to the next highest bidder.',
                                          style: smallImportant,
                                          // softWrap: true,
                                        ),
                                      ],
                                    )
                                  ],
                                )),
                            const SizedBox(height: 16),
                            Container(
                              // padding: EdgeInsets.only(left: 20, right: 20),
                              child: const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Top Bids",
                                        style: normalImportant,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Bid count",
                                            style: smallNormal,
                                          ),
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Text(
                                            "93",
                                            style: normalImportant,
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  Text(
                                    "see all bids",
                                    style: smallNormal,
                                  ),
                                ],
                              ),
                            ),
                            // const SizedBox(height: 16),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 60),
                            StreamBuilder<List<BidModel>>(
                              stream: getBidsStream(widget.productId),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                      child: CircularProgressIndicator());
                                } else if (snapshot.hasError) {
                                  return Center(child: Text('Error'));
                                } else if (snapshot.hasData) {
                                  List<BidModel> bidList = snapshot.data!;
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: bidList.length,
                                    itemBuilder: (context, index) {
                                      BidModel bid = bidList[index];
                                      return PreviousBids(
                                          name: bid.bidderId,
                                          username: bid.bidderId,
                                          bid: bid.bidAmount.toString(),
                                          status: bid.bidStatus,
                                          time: bid.timeStamp,
                                          profile:
                                              "https://images.unsplash.com/photo-1626301688449-1fa324d15bca?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=387&q=80");
                                    },
                                  );
                                } else {
                                  return Center(child: Text('No data'));
                                }
                              },
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
                        ),
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
              Container(
                height: height * 0.1,
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(164, 50.0),
                        backgroundColor: secondaryAccentColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Cancel",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(164, 50.0),
                        backgroundColor: primaryAccentColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                      onPressed: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CheckOutScreen(
                                    portalModel: portalModel,
                                    productModel: productModel)));
                      },
                      child: const Text(
                        "Proceed",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}






// Row(children: [
//                 Expanded(
//                   child: Container(
//                     child: ElevatedButton(
//                         onPressed: () {
//                           // handle cancelling event.
//                         },
//                         child: Text("Cancel")),
//                   ),
//                 ),
//                 SizedBox(
//                   width: 10,
//                 ),
//                 Expanded(
//                   child: Container(
//                     child: ElevatedButton(
//                         onPressed: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => CheckOutScreen(
//                                       portalModel: portalModel,
//                                       productModel: productModel)));
//                         },
//                         child: Text("Proceed")),
//                   ),
//                 ),
//               ]),
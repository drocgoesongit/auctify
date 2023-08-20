import 'package:auctify/const/constants.dart';
import 'package:auctify/const/util_functions.dart';
import 'package:auctify/models/bid_model.dart';
import 'package:auctify/models/product_model.dart';
import 'package:auctify/models/user_login_model.dart';
import 'package:auctify/screens/Place_Bid_Screen.dart';
import 'package:auctify/viewmodels/bidding_viewmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../utils/product_detail_tile.dart';

class ProductDetail extends StatelessWidget {
  const ProductDetail({super.key, required this.product});

  final ProductUploadModel product;

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

  Future<UserLoginModel> getUserDetails(String userId) async {
    DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    return UserLoginModel.fromMap(userDoc.data()! as Map<String, dynamic>);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          product.name,
          style: kAppbarTitle,
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width / 20),
          child: Column(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  enableInfiniteScroll: false,
                  viewportFraction: 1,
                  autoPlay: true,
                  aspectRatio: 16 / 9,
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                ),
                items: product.imageList.map((imageUrl) {
                  return Builder(
                    builder: (BuildContext context) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
              // filter part
              SizedBox(height: MediaQuery.of(context).size.height / 40),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  product.name,
                  style: const TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff000000),
                    height: 24 / 20,
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 80),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                Column(
                  children: [
                    Text(
                      "\$${product.startPrice}",
                      style: const TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff000000),
                        height: 45 / 30,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    const Padding(padding: EdgeInsets.only(top: 4)),
                    const Text(
                      "Initial bid",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff000000),
                        height: 24 / 16,
                      ),
                      // textAlign: TextAlign.left,
                    ),
                  ],
                ),
                Container(
                  // alignment: Alignment.centerRight,
                  width: 2.23, // Set the desired width
                  height: 75, // Set the desired height
                  color: Colors.black,
                ),
                Column(
                  children: [
                    Text(
                      "\$${product.currentPrice}",
                      style: const TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff000000),
                        height: 45 / 30,
                      ),
                      textAlign: TextAlign.right,
                    ),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 4)),
                    const Text(
                      "Highest bid",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff000000),
                        height: 20 / 16,
                      ),
                      textAlign: TextAlign.left,
                    )
                  ],
                ),
              ]),
              SizedBox(height: MediaQuery.of(context).size.height / 40),
              Container(
                alignment: Alignment.centerLeft,
                child: const Text(
                  "Description",
                  style: TextStyle(
                    fontFamily: "poppins",
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff545454),
                    height: 24 / 20,
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 40),
              Title(
                  color: Colors.grey.shade400,
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      product.description,
                      style:
                          const TextStyle(fontSize: 14, fontFamily: "poppins"),
                    ),
                  )),
              SizedBox(height: MediaQuery.of(context).size.height / 80),

              // list of products
              SizedBox(height: MediaQuery.of(context).size.height / 100),
              Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      "Previous bids",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff000000),
                        height: 24 / 20,
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 40),
                  StreamBuilder<List<BidModel>>(
                    stream: getBidsStream(product.id),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
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
                                bid: bid.bidAmount,
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
                  )
                ],
              ),
              Column(
                children: [
                  GestureDetector(
                    child: const Column(
                      children: [
                        Icon(Icons.add_circle_outline_rounded),
                        Text(
                          "Load more",
                          style: TextStyle(color: Color(0xff838181)),
                        ),
                      ],
                    ),
                    onTap: () {
                      // Add your onTap logic here
                    },
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 80),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size(164, 50.0),
                          backgroundColor: const Color(0xFFE2D784),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
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
                          backgroundColor: const Color(0xFF05595B),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        onPressed: () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PlaceBid(
                                        productUploadModel: product,
                                      )));

                          // String uid = FirebaseAuth.instance.currentUser!.uid;
                          // String bidId = FirebaseFirestore.instance
                          //     .collection("bids")
                          //     .doc()
                          //     .id;
                          // String timeStamp = DateTime.now().toString();
                          // String bidAmount = "6000";
                          // String bidStatus = "winner";
                          // BidModel bidModel = BidModel(
                          //     bidId: bidId,
                          //     bidderId: uid,
                          //     productId: product.id,
                          //     timeStamp: timeStamp,
                          //     bidAmount: bidAmount,
                          //     bidStatus: bidStatus,
                          //     );

                          // BiddingBackend().placeBid(bidModel, context);
                        },
                        child: const Text(
                          "Bid",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

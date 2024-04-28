import 'dart:async';
import 'dart:developer';
import 'package:auctify/const/constants.dart';
import 'package:auctify/const/util_functions.dart';
import 'package:auctify/models/bid_model.dart';
import 'package:auctify/models/product_model.dart';
import 'package:auctify/models/user_login_model.dart';
import 'package:auctify/screens/Place_Bid_Screen.dart';
import 'package:auctify/screens/group_chat_detail_screen.dart';
import 'package:auctify/utils/ticker_down.dart';
import 'package:auctify/viewmodels/product_list_viewmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../utils/product_detail_tile.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({super.key, required this.product});

  final ProductUploadModel product;

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  bool isInWishlist = false;
  bool ended = false;
  late Timer _timer;

  late Duration _remainingTime;
  Future<bool> isWishlisted() async {
    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;
      log("Checking if product is wishlisted for user: $userId");

      // Get the wishlist document for the user
      DocumentSnapshot wishlistSnapshot = await FirebaseFirestore.instance
          .collection("wishlist")
          .doc(userId)
          .get();

      if (wishlistSnapshot.exists) {
        var wishlistData = wishlistSnapshot.data();
        if (wishlistData != null && wishlistData is Map<String, dynamic>) {
          List<String>? productIds = wishlistData['productIds']?.cast<String>();
          if (productIds != null) {
            isInWishlist = productIds.contains(widget.product.id);
            log("Product is ${isInWishlist ? '' : 'not '}in wishlist");
            return isInWishlist;
          }
        }
      } else {
        isInWishlist = false;
        log("Wishlist document does not exist for user: $userId");
      }
      return false;
    } catch (e) {
      log("Error in checking wishlist status: ${e.toString()}");
      return false;
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

  Future<UserLoginModel> getUserDetails(String userId) async {
    DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    return UserLoginModel.fromMap(userDoc.data()! as Map<String, dynamic>);
  }

  List<Widget> generateIconTextList(List<IconData> icons, List<String> texts) {
    List<Widget> widgetList = [];

    for (int i = 0; i < icons.length; i++) {
      widgetList.add(
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icons[i],
              size: 30,
              color: Colors.grey.shade700,
            ), // Adjust the icon size as needed
            SizedBox(height: 8), // Add spacing between icon and text
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Text(
                texts[i],
                textAlign: TextAlign.center,
                style: smallImportant.copyWith(color: Colors.grey.shade800),
              ),
            ),
          ],
        ),
      );
    }

    return widgetList;
  }

  @override
  void initState() {
    super.initState();
    _remainingTime =
        calculateRemainingTime(widget.product.endDate, widget.product.endTime);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {});
    if (_remainingTime.isNegative) {
      ended = true;
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final days = _remainingTime.inDays.toString().padLeft(2, '0');
    final hours =
        _remainingTime.inHours.remainder(24).toString().padLeft(2, '0');
    final minutes =
        _remainingTime.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds =
        _remainingTime.inSeconds.remainder(60).toString().padLeft(2, '0');
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.product.name,
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
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Alexandra",
                  style: smallImportant,
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "@alexxxx",
                  style: smallNormal,
                ),
              ),
              Padding(padding: EdgeInsets.all(8.0)),
              CarouselSlider(
                options: CarouselOptions(
                  enableInfiniteScroll: false,
                  viewportFraction: 1,
                  autoPlay: true,
                  aspectRatio: 16 / 9,
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                ),
                items: widget.product.imageList.map((imageUrl) {
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
              SizedBox(height: MediaQuery.of(context).size.height / 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 86,
                    decoration: BoxDecoration(
                      // color: Colors.green,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: Colors.grey.shade500,
                        width: 0.5,
                      ),
                    ),
                    padding: EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Padding(padding: EdgeInsets.only(left: 6)),
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: ended ? Colors.red : Colors.green,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          ended ? "Ended" : "Active",
                          style:
                              smallNormal.copyWith(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: TickerDown(
                      endDate: widget.product.endDate,
                      endTime: widget.product.endTime,
                    ),
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.all(8)),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(widget.product.name, style: normalImportant),
              ),
              Padding(padding: EdgeInsets.only(left: 20, top: 4)),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "current bid",
                  // textAlign: TextAlign.left,
                  style: smallNormal.copyWith(
                    fontWeight: FontWeight.w500,
                    color: Color(0xff545454),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "\$${widget.product.currentPrice}",
                  maxLines: 1,
                  style: mediumTitle,
                  // textAlign: TextAlign.left,
                ),
              ),
              Divider(
                color: Colors.black,
              ),
              Container(
                  alignment: Alignment.centerLeft,
                  child: Text("Other info", style: normalImportant)),
              Padding(padding: EdgeInsets.all(4)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Initial bid",
                        style: normalText,
                        // textAlign: TextAlign.left,
                      ),
                      Text(
                        "\$${widget.product.startPrice}",
                        style: mediumTitle,
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "Minimum bid increment",
                        style: normalText,
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        "\$180",
                        maxLines: 1,
                        style: mediumTitle,
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ],
              ),
              Divider(
                color: Colors.black,
              ),
              Container(
                child: Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 14,
                    ), // Replace with your desired icon
                    SizedBox(width: 6), // Add spacing between icon and text
                    Text(
                      "Select delivery location - Enter pincode",
                      style: smallNormal,
                    ),
                  ],
                ),
              ),
              Padding(padding: EdgeInsets.all(4)),
              Container(
                alignment: Alignment.centerLeft,
                child: const Text(
                  "Product description:",
                  style: normalImportant,
                ),
              ),
              Padding(padding: EdgeInsets.all(4)),
              Title(
                  color: Colors.grey.shade400,
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.product.description,
                      style: smallNormal,
                    ),
                  )),
              Divider(
                color: Colors.black,
              ),
              // Generate Icon-Text List
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: generateIconTextList(
                    [
                      CupertinoIcons.cube_box,
                      Icons.money_off,
                      Icons.handshake_sharp,
                      CupertinoIcons.shield_lefthalf_fill,
                      CupertinoIcons.star
                    ], // Replace with your icon data
                    [
                      "7 days delivery",
                      "Non-refundable",
                      "Cash on Delivery",
                      "Quality assured",
                      "Top seller"
                    ], // Replace with your texts
                  ),
                ),
              ),
              Divider(
                color: Colors.black,
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 80),
              FutureBuilder(
                  future: ProductListViewModel()
                      .initiateChatPlusStatus(widget.product.id),
                  builder: ((context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error'));
                    } else if (snapshot.hasData) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => GroupChatDetialScreen(
                                      chatId: snapshot.data as String)));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            // Background color
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Colors.grey.shade600, // Border color
                              width: 0.5, // Border width
                            ), // Border radius
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Container(
                                  width: double.infinity,
                                  color: Colors.grey
                                      .shade200, // Background color for the heading
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 8),
                                  child: Text(
                                    "Chatroom", // Heading text
                                    style:
                                        smallImportant.copyWith(fontSize: 18),
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(8),
                                    child: CircleAvatar(
                                      backgroundImage: AssetImage(
                                          "assets/images/profile.png"),
                                    ),
                                  ),
                                  Padding(padding: EdgeInsets.only(left: 10)),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        // alignment: Alignment.centerLeft,
                                        child: Text(
                                          "@gojooo",
                                          style: smallImportant,
                                        ),
                                      ),
                                      Container(
                                        // alignment: Alignment.centerLeft,
                                        child: Text(
                                          "how can i bid on this product!",
                                          style: smallNormal,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  Container(
                                    child: Text(
                                      "01:45 am",
                                      style: smallNormal,
                                    ),
                                    padding: EdgeInsets.all(20),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  })),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8)),
              Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Ongoing bids",
                      style: normalImportant.copyWith(fontSize: 18),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 60),
                  StreamBuilder<List<BidModel>>(
                    stream: getBidsStream(widget.product.id),
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
                          style: TextStyle(
                              fontFamily: "Inter", color: Color(0xff838181)),
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
                      Expanded(
                        child: FutureBuilder(
                          future: isWishlisted(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            } else if (snapshot.connectionState ==
                                ConnectionState.done) {
                              return OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  minimumSize: const Size(164, 50.0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                  ),
                                ),
                                onPressed: () {
                                  if (FirebaseAuth.instance.currentUser ==
                                      null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            "Please login to add to wishlist."),
                                      ),
                                    );
                                    return;
                                  } else {
                                    if (isInWishlist) {
                                      // code to remove the item from wishlist.
                                    }
                                    {
                                      ProductListViewModel()
                                          .addToWishlist(widget.product.id);
                                      setState(() {
                                        isInWishlist = !isInWishlist;
                                      });
                                    }
                                  }
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      isInWishlist
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      size: 20,
                                      color: isInWishlist
                                          ? Colors.red
                                          : Colors.black,
                                    ),
                                    const SizedBox(
                                        width:
                                            8), // Add spacing between icon and text
                                    Text(
                                      isInWishlist ? "Wished" : "Wishlist",
                                      style: normalImportant.copyWith(
                                        color: isInWishlist
                                            ? Colors.red
                                            : Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              // Handle other connection states here
                              return Container(); // or any other appropriate widget
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            minimumSize: const Size(164, 50.0),
                            backgroundColor: ended ||
                                    FirebaseAuth.instance.currentUser == null
                                ? Colors.grey
                                : primaryAccentColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                          ),
                          onPressed: () async {
                            if (ended ||
                                FirebaseAuth.instance.currentUser == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("This auction has ended."),
                                ),
                              );
                            } else {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PlaceBid(
                                            productUploadModel: widget.product,
                                          )));
                            }
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

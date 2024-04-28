import 'dart:developer';
import 'package:auctify/const/constants.dart';
import 'package:auctify/models/product_model.dart';
import 'package:auctify/screens/accept_portal_screen.dart';
import 'package:auctify/screens/product_detail_screen.dart';
import 'package:auctify/screens/product_list_screen.dart';
import 'package:auctify/screens/track_order.dart';
import 'package:auctify/screens/wishlist_screen.dart';
import 'package:auctify/utils/product_list_tile.dart';
import 'package:auctify/viewmodels/product_list_viewmodel.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../utils/product_tile_home_screen.dart';

class HomeFragment extends StatefulWidget {
  const HomeFragment({super.key});

  @override
  State<HomeFragment> createState() => _HomeFragmentState();
}

class _HomeFragmentState extends State<HomeFragment> {
  late String productId;
  Future<List<String>> getPortalIfAny() async {
    try {
      List<String> portalIds = [];
      QuerySnapshot portalsDocs = await FirebaseFirestore.instance
          .collection("portal")
          .where("portalStatus", isEqualTo: "started")
          .where("portalCurrentWinner",
              isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();

      if (portalsDocs.docs.isNotEmpty) {
        for (DocumentSnapshot doc in portalsDocs.docs) {
          Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
          portalIds.add(data!["portalId"]);
          productId = data!["productId"];
        }
        return portalIds;
      } else {
        log("got empty portal doc");
        return ["none"];
      }
    } catch (e) {
      print("error in getPortalIfAny: ${e.toString()}");
      return ["none"];
    }
  }

  Future<List<ProductUploadModel>> getProductListFromBackend(
          BuildContext context) async =>
      await ProductListViewModel().getProductList(context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Auctify',
                style: kAppbarTitle,
              ),
              Row(
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Wishlist()));
                      },
                      child: Icon(Icons.favorite_border_rounded)),
                  SizedBox(
                    width: 16,
                  ),
                ],
              ),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder(
                  future: getPortalIfAny(),
                  builder: ((context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.connectionState ==
                        ConnectionState.done) {
                      if (snapshot.data![0] == "none") {
                        return Container();
                      } else {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AcceptPortalScreen(
                                          portalId: snapshot.data![0],
                                          productId: productId,
                                        )));
                          },
                          child: const ListTile(
                            mouseCursor: SystemMouseCursors.click,
                            leading: Icon(Icons.emoji_events_outlined),
                            title: Text("You are the winner of this portal."),
                            subtitle:
                                Text("Go to portal to claim the product."),
                          ),
                        );
                      }
                    } else {
                      return Container();
                    }
                  })),
              CarouselSlider(
                items: [
                  Container(
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage("assets/images/slide_one.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage("assets/images/slide_two.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage("assets/images/slide_three.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
                options: CarouselOptions(
                  enableInfiniteScroll: false,
                  viewportFraction: 1,
                  autoPlay: true,
                  aspectRatio: 16 / 9,
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: const Text(
                      "Categories",
                      style: normalImportant,
                    ),
                  ),
                  // Container(
                  //   padding: const EdgeInsets.all(20),
                  //   child: const Text(
                  //     "see all",
                  //     style: smallNormal,
                  //   ),
                  // ),
                ],
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Center(child: Padding(padding: EdgeInsets.only(left: 20))),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProductListScreen(
                                      category: "Designer",
                                    )));
                      },
                      child: CircleImageWithBorder(
                        imageAsset: "assets/images/nike.png",
                        name: "Designers",
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(left: 8)),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProductListScreen(
                                      category: "Automobile",
                                    )));
                      },
                      child: CircleImageWithBorder(
                        imageAsset: "assets/images/Mona_Lisa.png",
                        name: "Automobiles",
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(left: 8)),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProductListScreen(
                                      category: "ArtWork",
                                    )));
                      },
                      child: const CircleImageWithBorder(
                        imageAsset: "assets/images/pearl.png",
                        name: "Rare items",
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(left: 8)),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ProductListScreen(
                                      category: "RealEstate",
                                    )));
                      },
                      child: CircleImageWithBorder(
                        imageAsset: "assets/images/nike.png",
                        name: "Real Estates",
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(left: 8)),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProductListScreen(
                                      category: "ArtWork",
                                    )));
                      },
                      child: CircleImageWithBorder(
                        imageAsset: "assets/images/coins.png",
                        name: "Nike",
                      ),
                    ),
                    Padding(
                        padding:
                            EdgeInsets.only(left: 8)), // Add end padding of 20
                  ],
                ),
              ),
              // Padding(padding: EdgeInsets.all(8)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      "Trending right now 🔥",
                      style: normalImportant,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: const Text(
                      "see all",
                      style: smallNormal,
                    ),
                  ),
                ],
              ),
              FutureBuilder(
                future: getProductListFromBackend(context),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData && snapshot.data != false) {
                      List<ProductUploadModel> productList = snapshot.data!;
                      return Container(
                        height: MediaQuery.of(context).size.height * 0.3,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: productList.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ProductDetail(
                                              product: productList[index],
                                            )));
                              },
                              child: ProductCard(
                                imageAsset: productList[index].imageList[0],
                                name: productList[index].name,
                                price:
                                    productList[index].currentPrice.toString(),
                                iconData: Icons.favorite_border_outlined,
                                uname: 'by Alex009', // Use any desired icon
                              ),
                            );
                          },
                        ),
                      );
                    } else {
                      return const Center(child: Text("No data found"));
                    }
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),

              SizedBox(height: 60),
              // Usage
            ],
          ),
        ));
  }
}

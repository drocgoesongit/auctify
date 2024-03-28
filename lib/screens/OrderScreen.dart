import 'package:auctify/const/constants.dart';
import 'package:auctify/utils/order_screen_lists.dart';
import 'package:auctify/utils/product_tile_home_screen.dart';
import 'package:flutter/material.dart';

class MyOrders extends StatelessWidget {
  const MyOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Orders",
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
        padding: EdgeInsets.all(MediaQuery.of(context).size.width / 20),
        child: const Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Current orders",
                  style: normalImportant,
                ),
                Text(
                  "view all",
                  style: smallNormal,
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  OrderCard(
                      image: "assets/images/clock.png",
                      title: "Clock",
                      description: "description",
                      day: "This is a very nice daY"),
                  OrderCard(
                      image: "assets/images/lamp.png",
                      title: "Lamp",
                      description: "description",
                      day: "Today"),
                  OrderCard(
                      image: "assets/images/pearl.png",
                      title: "Pearl",
                      description: "description",
                      day: "Today"),
                  OrderCard(
                      image: "assets/images/nike.png",
                      title: "Nike MAG",
                      description: "description",
                      day: "Today"),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Past bids",
                  style: normalImportant,
                ),
                Text(
                  "view all",
                  style: smallNormal,
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  PastOrder(
                      image: "assets/images/coins.png",
                      title: "Coins",
                      description: "description",
                      day: "Today"),
                  PastOrder(
                      image: "assets/images/lamp.png",
                      title: "Lamp",
                      description: "description",
                      day: "Today"),
                  PastOrder(
                      image: "assets/images/pearl.png",
                      title: "Pearl",
                      description: "description",
                      day: "Today"),
                  PastOrder(
                      image: "assets/images/nike.png",
                      title: "Nike MAG",
                      description: "description",
                      day: "Today"),
                ],
              ),
            ),
            SizedBox(
              height: 18,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Recommended for you",
                  style: normalImportant,
                ),
                Text(
                  "see all",
                  style: smallNormal,
                )
              ],
            ),
            SizedBox(
              height: 18,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ProductCard(
                    imageAsset: "assets/images/clock.png",
                    name: "Vinatge Clock",
                    price: 2000,
                    iconData: Icons.favorite_border_outlined,
                    uname: 'by Alex009', // Use any desired icon
                  ),
                  Padding(padding: EdgeInsets.only(left: 12)),
                  ProductCard(
                    imageAsset: "assets/images/coins.png",
                    name: "Old Coins",
                    price: 3200,
                    iconData: Icons.favorite_border_outlined,
                    uname: 'by Alex009', // Use any desired icon
                  ),
                  Padding(padding: EdgeInsets.only(left: 12)),
                  ProductCard(
                    imageAsset: "assets/images/nike.png",
                    name: "Nike Shoes",
                    price: 3211,
                    iconData: Icons.favorite_border_outlined,
                    uname: 'by Alex009', // Use any desired icon
                  ),
                  Padding(padding: EdgeInsets.only(left: 12)),
                  ProductCard(
                    imageAsset: "assets/images/art.png",
                    name: "Artwork",
                    price: 1298,
                    iconData: Icons.favorite_border_outlined,
                    uname: 'by Alex009', // Use any desired icon
                  ),
                  Padding(padding: EdgeInsets.only(right: 20)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

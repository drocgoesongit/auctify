import 'package:auctify/const/constants.dart';
import 'package:auctify/utils/wishlist_card.dart';
import 'package:flutter/material.dart';

class Wishlist extends StatelessWidget {
  const Wishlist({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Wishlist",
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Active bids",
              style: normalImportant.copyWith(
                  fontSize: 24, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 12,
            ),
            const WishlistCard(
                pname: "Pearl",
                uname: "by @johndoe.871",
                price: "\$27.05",
                image: "assets/images/pearl.png"),
            SizedBox(
              height: 4,
            ),
            const WishlistCard(
                pname: "Clock",
                uname: "by @johndoe.871",
                price: "\$27.05",
                image: "assets/images/clock.png"),
            SizedBox(
              height: 4,
            ),
            const WishlistCard(
                pname: "Lamp",
                uname: "by @johndoe.871",
                price: "\$27.05",
                image: "assets/images/lamp.png"),
            SizedBox(
              height: 4,
            ),
            const WishlistCard(
                pname: "Coins",
                uname: "by @johndoe.871",
                price: "\$27.05",
                image: "assets/images/coins.png"),
          ],
        ),
      ),
    );
  }
}

import 'package:auctify/const/constants.dart';
import 'package:auctify/screens/product_detail_screen.dart';
import 'package:auctify/utils/product_list_tile.dart';
import 'package:flutter/material.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  // variables and all

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Product list",
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
          child: Column(children: [
            // search bar container
            Container(
              // i want container with 12 radius border on all sides
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(
                color: secondaryAccentColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(children: [
                const Icon(
                  Icons.search_outlined,
                ),
                const SizedBox(
                  width: 12,
                ),
                Flexible(
                    child: TextFormField(
                  decoration: InputDecoration(hintText: "search"),
                )),
              ]),
            ),

            // filter part
            SizedBox(height: MediaQuery.of(context).size.height / 40),
            GestureDetector(
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.filter_list_rounded,
                    color: primaryAccentColor,
                  ),
                  SizedBox(width: MediaQuery.of(context).size.height / 60),
                  Text("Filter")
                ],
              ),
            ),

            // list of products
            SizedBox(height: MediaQuery.of(context).size.height / 80),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProductDetail()));
              },
              child: ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  ProductListTile(
                      pname: "Pearl",
                      price: "\$12K",
                      time: "1:20:00",
                      image: "assets/images/pearl.png"),
                  Container(
                    // alignment: Alignment.centerRight,
                    width: 350, // Set the desired width
                    height: 2, // Set the desired height
                    color: Colors.grey.shade400,
                  ),
                  ProductListTile(
                      pname: "Telephone",
                      price: "\$13K",
                      time: "1:20:00",
                      image: "assets/images/image.png"),
                  Container(
                    // alignment: Alignment.centerRight,
                    width: 350, // Set the desired width
                    height: 2, // Set the desired height
                    color: Colors.grey.shade400,
                  ),
                  ProductListTile(
                      pname: "Magic Lamp",
                      // description: "xyz",
                      price: "\$20K",
                      time: "1:20:00",
                      image: "assets/images/lamp.png"),
                  Container(
                    // alignment: Alignment.centerRight,
                    width: 350, // Set the desired width
                    height: 2, // Set the desired height
                    color: Colors.grey.shade400,
                  ),
                  ProductListTile(
                      pname: "Old Coins",
                      price: "\$3200",
                      time: "1:20:00",
                      image: "assets/images/coins.png"),
                  Container(
                    // alignment: Alignment.centerRight,
                    width: 350, // Set the desired width
                    height: 2, // Set the desired height
                    color: Colors.grey.shade400,
                  ),
                  ProductListTile(
                      pname: "Vintage Clock",
                      price: "\$2K",
                      time: "1:20:00",
                      image: "assets/images/clock.png"),
                  Container(
                    // alignment: Alignment.centerRight,
                    width: 350, // Set the desired width
                    height: 2, // Set the desired height
                    color: Colors.grey.shade400,
                  ),
                  ProductListTile(
                      pname: "Christie’s Art",
                      price: "\$500M",
                      time: "1:20:00",
                      image: "assets/images/art.png"),
                  Container(
                    // alignment: Alignment.centerRight,
                    width: 350, // Set the desired width
                    height: 2, // Set the desired height
                    color: Colors.grey.shade400,
                  ),
                  ProductListTile(
                      pname: "Pearl",
                      price: "\$12K",
                      time: "1:20:00",
                      image: "assets/images/pearl.png"),
                  Container(
                    // alignment: Alignment.centerRight,
                    width: 350, // Set the desired width
                    height: 2, // Set the desired height
                    color: Colors.grey.shade400,
                  ),
                  ProductListTile(
                      pname: "Pearl",
                      price: "\$12K",
                      time: "1:20:00",
                      image: "assets/images/pearl.png"),
                  Container(
                    // alignment: Alignment.centerRight,
                    width: 350, // Set the desired width
                    height: 2, // Set the desired height
                    color: Colors.grey.shade400,
                  ),
                  ProductListTile(
                      pname: "Pearl",
                      price: "\$12K",
                      time: "1:20:00",
                      image: "assets/images/pearl.png"),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}

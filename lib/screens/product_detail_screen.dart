import 'package:auctify/const/constants.dart';
import 'package:auctify/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../utils/product_detail_tile.dart';

class ProductDetail extends StatelessWidget {
  const ProductDetail({super.key, required this.product});

  final ProductUploadModel product;

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

              // const Text(
              //   "Looking for a way to add some vintage charm to your home decor? Look no further than this antique desk telephone! While it may not be functional, it can still serve as an excellent home decor item. The sleek black color and metallic finish make it suitable for almost any type of interior decor.\n\n"
              //   "This antique telephone measures 7' in height, 7.5' in diameter, and 9.3' in width, making it the perfect size to attract the attention of all visitors. And the best part? No assembly is required! Simply set it up on your desk and enjoy the classic beauty it brings to your home.\n"
              //   "Don't miss your chance to own this unique piece of vintage decor. Bid now and make it yours!",
              //   style: TextStyle(
              //     fontFamily: "Poppins",
              //     fontSize: 14,
              //     fontWeight: FontWeight.w400,
              //     color: Color(0xff000000),
              //   ),
              // ),

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
                  ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      const PreviousBids(
                          name: "Alex Jones",
                          username: "@alexj0563",
                          bid: "\$1300",
                          status: "winning",
                          time: "05m 45s ago",
                          profile: "assets/images/profile.png"),
                      Container(
                        // alignment: Alignment.centerRight,
                        width: 350, // Set the desired width
                        height: 2, // Set the desired height
                        color: Colors.grey.shade400,
                      ),
                      const PreviousBids(
                          name: "Lucas Murphy",
                          username: "@wong10",
                          bid: "\$1950",
                          status: "losing",
                          time: "07m 01s ago",
                          profile: "assets/images/profile.png"),
                      Container(
                        // alignment: Alignment.centerRight,
                        width: 350, // Set the desired width
                        height: 2, // Set the desired height
                        color: Colors.grey.shade400,
                      ),
                      const PreviousBids(
                          name: "Emma Wong",
                          username: "@wong10",
                          bid: "\$12800",
                          status: "losing",
                          time: "09m 41s ago",
                          profile: "assets/images/profile.png"),
                      Container(
                        // alignment: Alignment.centerRight,
                        width: 350, // Set the desired width
                        height: 2, // Set the desired height
                        color: Colors.grey.shade400,
                      ),
                      const PreviousBids(
                          name: "Jason Lee",
                          username: "@0307jason",
                          bid: "\$12750",
                          status: "losing",
                          time: "09m 50s ago",
                          profile: "assets/images/profile.png"),
                      Container(
                        // alignment: Alignment.centerRight,
                        width: 350, // Set the desired width
                        height: 2, // Set the desired height
                        color: Colors.grey.shade400,
                      ),
                      const PreviousBids(
                          name: "Rebecca Singh",
                          username: "@flying_ranger",
                          bid: "\$12400",
                          status: "losing",
                          time: "10m 30s ago",
                          profile: "assets/images/profile.png"),
                      Container(
                        // alignment: Alignment.centerRight,
                        width: 350, // Set the desired width
                        height: 2, // Set the desired height
                        color: Colors.grey.shade400,
                      ),
                      const PreviousBids(
                          name: "Gabriel Chen",
                          username: "@techwizard",
                          bid: "\$12000",
                          status: "outbid",
                          time: "11m 04s ago",
                          profile: "assets/images/profile.png"),
                      Container(
                        // alignment: Alignment.centerRight,
                        width: 350, // Set the desired width
                        height: 2, // Set the desired height
                        color: Colors.grey.shade400,
                      ),
                      const PreviousBids(
                          name: "Olivia Kim",
                          username: "@oliviaaaa",
                          bid: "\$11950",
                          status: "outbid",
                          time: "15m 34s ago",
                          profile: "assets/images/profile.png"),
                      Container(
                        // alignment: Alignment.centerRight,
                        width: 350, // Set the desired width
                        height: 2, // Set the desired height
                        color: Colors.grey.shade400,
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height / 40),
                    ],
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
                        onPressed: () {},
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

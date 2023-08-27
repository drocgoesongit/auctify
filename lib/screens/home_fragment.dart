import 'package:auctify/const/constants.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../utils/product_tile_home_screen.dart';

class HomeFragment extends StatelessWidget {
  const HomeFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Auctify',
          style: kAppbarTitle,
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CarouselSlider(
              items: [
                Container(
                  margin: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(
                      color: Colors.black,
                      width: 0.5,
                    ),
                    image: DecorationImage(
                      image: NetworkImage(
                          "https://static.vecteezy.com/system/resources/previews/004/491/043/non_2x/auction-business-concept-for-web-banner-woman-bidding-in-online-auction-auctioneer-sells-art-painting-modern-person-scene-illustration-in-flat-cartoon-design-with-people-characters-vector.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  width: 350,
                  height: 180,
                ),
                Container(
                  margin: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(
                      color: Colors.black,
                      width: 0.5,
                    ),
                    image: DecorationImage(
                      image: NetworkImage(
                          "https://static.vecteezy.com/system/resources/previews/004/491/043/non_2x/auction-business-concept-for-web-banner-woman-bidding-in-online-auction-auctioneer-sells-art-painting-modern-person-scene-illustration-in-flat-cartoon-design-with-people-characters-vector.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  width: 350,
                  height: 180,
                ),
                Container(
                  margin: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(
                      color: Colors.black,
                      width: 0.5,
                    ),
                    image: DecorationImage(
                      image: NetworkImage(
                          "https://static.vecteezy.com/system/resources/previews/004/491/043/non_2x/auction-business-concept-for-web-banner-woman-bidding-in-online-auction-auctioneer-sells-art-painting-modern-person-scene-illustration-in-flat-cartoon-design-with-people-characters-vector.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  width: 350,
                  height: 180,
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
                  padding: EdgeInsets.all(20),
                  child: Text(
                    "Categories",
                    style: normalImportant,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    "see all",
                    style: smallNormal,
                  ),
                ),
              ],
            ),
            const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(padding: EdgeInsets.only(left: 20)),
                  CircleImageWithBorder(
                    imageAsset: "assets/images/nike.png",
                    name: "Sneakers",
                  ),
                  Padding(padding: EdgeInsets.only(left: 8)),
                  CircleImageWithBorder(
                    imageUrl: "assets/images/car.png",
                    name: "Automobiles",
                  ),
                  Padding(padding: EdgeInsets.only(left: 8)),
                  CircleImageWithBorder(
                    imageAsset: "assets/images/Mona_Lisa.png",
                    name: "Art",
                  ),
                  Padding(padding: EdgeInsets.only(left: 8)),
                  CircleImageWithBorder(
                    imageUrl: "assets/images/real_estate.png",
                    name: "Real Estates",
                  ),
                  Padding(padding: EdgeInsets.only(left: 8)),
                  CircleImageWithBorder(
                    imageAsset: "assets/images/nike.png",
                    name: "Nike",
                  ),
                  Padding(padding: EdgeInsets.only(left: 8)),
                  CircleImageWithBorder(
                    imageAsset: "assets/images/nike.png",
                    name: "Nike",
                  ),
                  Padding(padding: EdgeInsets.only(left: 8)),
                  Padding(
                      padding:
                          EdgeInsets.only(right: 20)), // Add end padding of 20
                ],
              ),
            ),
            // Padding(padding: EdgeInsets.all(8)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    "Trending right now",
                    style: normalImportant,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    "see all",
                    style: smallNormal,
                  ),
                ),
              ],
            ),
            // Usage
            const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Padding(padding: EdgeInsets.only(left: 20)),
                  ProductCard(
                    imageAsset: "assets/images/clock.png",
                    name: "Vinatge Clock",
                    price: 2000,
                    iconData:
                        Icons.favorite_border_outlined, // Use any desired icon
                  ),
                  Padding(padding: EdgeInsets.only(left: 12)),
                  ProductCard(
                    imageAsset: "assets/images/coins.png",
                    name: "Old Coins",
                    price: 3200,
                    iconData:
                        Icons.favorite_border_outlined, // Use any desired icon
                  ),
                  Padding(padding: EdgeInsets.only(left: 12)),
                  ProductCard(
                    imageAsset: "assets/images/nike.png",
                    name: "Nike Shoes",
                    price: 3211,
                    iconData:
                        Icons.favorite_border_outlined, // Use any desired icon
                  ),
                  Padding(padding: EdgeInsets.only(left: 12)),
                  ProductCard(
                    imageAsset: "assets/images/art.png",
                    name: "Artwork",
                    price: 1298,
                    iconData:
                        Icons.favorite_border_outlined, // Use any desired icon
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

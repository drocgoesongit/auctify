import 'package:auctify/const/constants.dart';
import 'package:auctify/screens/home_screen.dart';
import 'package:auctify/utils/product_tile_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class TrackOrder extends StatefulWidget {
  const TrackOrder({
    super.key,
  });

  @override
  State<TrackOrder> createState() => _TrackOrderState();
}

class _TrackOrderState extends State<TrackOrder> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        'Track Order',
        style: kAppbarTitle,
      )),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width / 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    width: height * 0.2,
                    height: height * 0.2,
                    child: Image.network(
                      "//www.google.com/imgres?imgurl=https%3A%2F%2Fwww.graygroupintl.com%2Fhubfs%2FGray%2520Group%2520International%2FGGI%2520-%2520Assign%2520and%2520Sort%2520%2528WebP%2529%2FVintage%2520Cars%2520More%2520Than%2520Metal%2520and%2520Chrome.webp%23keepProtocol&tbnid=w3coUI0TQmolXM&vet=12ahUKEwiehbnh0-SDAxUwl2MGHfCiDeUQMygEegQIARB7..i&imgrefurl=https%3A%2F%2Fwww.graygroupintl.com%2Fblog%2Fvintage-cars&docid=-9Zdt0uVHgfy8M&w=1024&h=512&q=vintage%20car&ved=2ahUKEwiehbnh0-SDAxUwl2MGHfCiDeUQMygEegQIARB7",
                      // fit: BoxFit.cover,
                    )),
                const SizedBox(
                  width: 8,
                ),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment
                        .start, // Align children to the start (top) of the column
                    children: [
                      Text(
                        "These 2 lines are for product description till the end of the line.......",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Inter"),
                      ),
                      SizedBox(height: 19),
                      Text("product seller username", style: smallNormal),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Text(
                            "\$190",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: mediumTitle,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            "Paid",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                                fontFamily: "Inter"),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Arriving by Saturday",
                        style: normalImportant,
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Container(
              width: double.infinity,
              height: 4,
              color: Colors.grey.shade400,
            ),
            const SizedBox(
              height: 16,
            ),
            const Text(
              "Current Status",
              style: normalImportant,
            ),
            SizedBox(
              height: 100,
              child: TimelineTile(
                isFirst: true,
                isLast: false,
                indicatorStyle: IndicatorStyle(
                    width: 30,
                    color: primaryAccentColor,
                    iconStyle: IconStyle(
                        iconData: Icons.done_rounded,
                        color: secondaryAccentColor)),
                afterLineStyle: const LineStyle(
                  color: primaryAccentColor,
                ),
                endChild: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Placed",
                        style: normalImportant,
                      ),
                      Text(
                        "12:32 am, 05/07/2023",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontFamily: "Inter",
                            color: Colors.grey),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 100,
              child: TimelineTile(
                isFirst: false,
                isLast: false,
                indicatorStyle: IndicatorStyle(
                    width: 30,
                    color: primaryAccentColor,
                    iconStyle: IconStyle(
                        iconData: Icons.done_rounded,
                        color: secondaryAccentColor)),
                beforeLineStyle: const LineStyle(
                  color: primaryAccentColor,
                ),
                endChild: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Under Process",
                        style: normalImportant,
                      ),
                      Text(
                        "12:59 am, 05/07/2023",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontFamily: "Inter",
                            color: Colors.grey),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 100,
              child: TimelineTile(
                isFirst: false,
                isLast: false,
                indicatorStyle: IndicatorStyle(
                    width: 30,
                    color: primaryAccentColor,
                    iconStyle: IconStyle(
                        iconData: Icons.done_rounded,
                        color: secondaryAccentColor)),
                beforeLineStyle: const LineStyle(
                  color: primaryAccentColor,
                ),
                endChild: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Shipped",
                        style: normalImportant,
                      ),
                      Text(
                        "5:45 pm, 08/07/2023",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontFamily: "Inter",
                            color: Colors.grey),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 100,
              child: TimelineTile(
                isFirst: false,
                isLast: false,
                indicatorStyle: IndicatorStyle(
                    width: 30,
                    color: Colors.grey,
                    iconStyle: IconStyle(
                        iconData: Icons.done_rounded, color: Colors.grey)),
                endChild: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Out for Delivery",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Inter",
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        "7:00 pm, 09/07/2023",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontFamily: "Inter",
                            color: Colors.grey),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 100,
              child: TimelineTile(
                isFirst: false,
                isLast: true,
                indicatorStyle: IndicatorStyle(
                    width: 30,
                    color: Colors.grey,
                    iconStyle: IconStyle(
                        iconData: Icons.done_rounded, color: Colors.grey)),
                endChild: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Arriving by Saturday",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Inter",
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 4,
              color: Colors.grey.shade400,
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Delivering to",
                  style: normalImportant,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.home_rounded,
                      size: 12,
                      color: Colors.grey.shade600,
                    ),
                    Text(
                      "Home",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.shade600,
                          fontSize: 12,
                          fontFamily: "Inter"),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              width: 260,
              child: Text(
                "Room no 405, 4th floor, C wing, Trevor Heights Sector-D, FT lane Columbus, Ohio, 43004 United States",
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
                style: TextStyle(
                    color: Colors.grey.shade600,
                    fontFamily: "Inter",
                    fontSize: 12,
                    fontWeight: FontWeight.w400),
              ),
            ),
            const SizedBox(
              height: 18,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Similar bids",
                  style: normalImportant,
                ),
                Text(
                  "see all",
                  style: smallNormal,
                )
              ],
            ),
            const SizedBox(
              height: 18,
            ),
            const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ProductCard(
                    imageAsset: "assets/images/clock.png",
                    name: "Vinatge Clock",
                    price: "200",
                    iconData: Icons.favorite_border_outlined,
                    uname: 'by Alex009', // Use any desired icon
                  ),
                  ProductCard(
                    imageAsset: "assets/images/coins.png",
                    name: "Old Coins",
                    price: "200",
                    iconData: Icons.favorite_border_outlined,
                    uname: 'by Alex009', // Use any desired icon
                  ),
                  Padding(padding: EdgeInsets.only(left: 12)),
                  ProductCard(
                    imageAsset: "assets/images/nike.png",
                    name: "Nike Shoes",
                    price: "200",
                    iconData: Icons.favorite_border_outlined,
                    uname: 'by Alex009', // Use any desired icon
                  ),
                  Padding(padding: EdgeInsets.only(left: 12)),
                  ProductCard(
                    imageAsset: "assets/images/art.png",
                    name: "Artwork",
                    price: "200",
                    iconData: Icons.favorite_border_outlined,
                    uname: 'by Alex009', // Use any desired icon
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(164, 50.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                  onPressed: () async {
                    Navigator.pop(
                        context); //add logic to redirect to customer care page
                  },
                  child: const Row(
                    children: [
                      Icon(
                        Icons.headset_mic_outlined,
                        size: 20,
                        color: Colors.black,
                      ),
                      SizedBox(width: 4), // Add spacing between icon and text
                      Text(
                        "Help",
                        style: normalImportant,
                      ),
                    ],
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
                            builder: (context) =>
                                const HomeScreen())); //add logic to redirect to product detail page
                  },
                  child: const Text(
                    "View product",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

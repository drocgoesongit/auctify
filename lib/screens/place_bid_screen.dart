import 'package:auctify/const/util_functions.dart';
import 'package:auctify/models/bid_model.dart';
import 'package:auctify/models/product_model.dart';
import 'package:auctify/viewmodels/bidding_viewmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../const/constants.dart';

class PlaceBid extends StatefulWidget {
  const PlaceBid({super.key, required this.productUploadModel});
  final ProductUploadModel productUploadModel;

  @override
  State<PlaceBid> createState() => _PlaceBidState();
}

class _PlaceBidState extends State<PlaceBid> {
  String bidAmount = "";
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Place a bid",
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
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    width: height * 0.2,
                    height: height * 0.2,
                    child: Image.network(
                      widget.productUploadModel.imageList[0],
                      // fit: BoxFit.cover,
                    )),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment
                        .start, // Align children to the start (top) of the column
                    children: [
                      Text(
                        widget.productUploadModel.name,
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Inter"),
                      ),
                      const SizedBox(height: 19),
                      const Text("product seller username", style: smallNormal),
                      const SizedBox(height: 8),
                      Text(
                        "\$${widget.productUploadModel.currentPrice}",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: mediumTitle,
                      ),
                      const Text(
                        "Current bid",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                            fontFamily: "Inter"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
              // padding: EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Your position",
                        style: smallNormal,
                      ),
                      // SizedBox(height: 6),
                      Text(
                        "1st",
                        style: normalImportant,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Time Remaining",
                        style: smallImportant,
                      ),
                      Text(
                        "30:50:01", // Replace with your real-time value
                        style: smallImportant.copyWith(color: Colors.red),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(
                  child: Column(
                    children: [
                      Text(
                        "Initial Bid",
                        style: smallNormal,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "\$ 90",
                        style: mediumTitle,
                      )
                    ],
                  ),
                ),
                Container(
                  width: 1, // Set the desired width
                  height: 51, // Set the desired height
                  color: Colors.grey.shade400,
                ),
                const Expanded(
                  child: Column(
                    children: [
                      Text(
                        "Minimum bid increment",
                        style: smallNormal,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "\$ 5",
                        style: mediumTitle,
                      )
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
                width: 350.0,
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
                      padding: EdgeInsets.only(left: 12),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding: EdgeInsets.only(
                            top: 8,
                          )),
                          Text(
                            'The amount keeps updating all the time with new bids getting placed. So please make sure to quickly bid as if other person bids the same amount then you won’t be able to bid with that amount.',
                            style: smallImportant,
                            maxLines: 3,
                            // softWrap: true,
                          ),
                        ],
                      ),
                    )
                  ],
                )),
            const Divider(
              thickness: 2,
            ),
            const SizedBox(
              height: 4,
            ),
            Container(
              alignment: Alignment.topLeft,
              child: const Text(
                "Bid Amount",
                style: normalImportant,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                GestureDetector(
                  onTap: () {},
                  child: const Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Icon(
                      CupertinoIcons.minus_circle_fill,
                      color: primaryAccentColor,
                      size: 30,
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(left: 10)),
                Container(
                  width: 200,
                  height: 40,
                  decoration: BoxDecoration(
                    color: secondaryAccentColor,
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(
                      color: Colors.black.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText:
                          '\$${widget.productUploadModel.currentPrice + widget.productUploadModel.startPrice * (widget.productUploadModel.increment * 0.01)}',
                      contentPadding:
                          const EdgeInsets.only(left: 10, bottom: 10),
                    ),
                    onChanged: (val) {
                      setState(() {
                        bidAmount = val;
                      });
                    },
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: const Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Icon(
                      CupertinoIcons.add_circled_solid,
                      color: primaryAccentColor,
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 4),
            Row(
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
                      fontFamily: "Inter",
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
                    int minAmount = widget.productUploadModel.currentPrice +
                        widget.productUploadModel.increment;
                    ;
                    String bidId = generateRandomId();
                    if (int.parse(bidAmount) > minAmount) {
                      BidModel bidModel = BidModel(
                        bidAmount: int.parse(bidAmount),
                        productId: widget.productUploadModel.id,
                        bidderId: FirebaseAuth.instance.currentUser!.uid,
                        timeStamp: DateTime.now().toString(),
                        bidStatus: "winning",
                        bidId: bidId,
                      );
                      bool isBidPlaced =
                          await BiddingBackend().placeBid(bidModel, context);
                      if (isBidPlaced) {
                        Navigator.pop(context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Bid amount should be greater than current bid amount. Or some error occured.",
                            ),
                          ),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Bid amount should be greater than current bid amount",
                          ),
                        ),
                      );
                    }
                  },
                  child: const Text(
                    "Bid",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Inter",
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

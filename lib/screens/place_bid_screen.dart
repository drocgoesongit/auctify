import 'package:auctify/const/util_functions.dart';
import 'package:auctify/models/bid_model.dart';
import 'package:auctify/models/product_model.dart';
import 'package:auctify/viewmodels/bidding_viewmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../const/constants.dart';
import '../models/product_model.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text(
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
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: SizedBox(
                      width: 205,
                      height: 198,
                      child: Image.network(
                        widget.productUploadModel.imageList[0],
                        fit: BoxFit.cover,
                      )),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment
                      .start, // Align children to the start (top) of the column
                  children: [
                    Container(
                      // decoration: BoxDecoration(color: Colors.grey),
                      // alignment: Alignment.topRight,
                      child: Text(
                        widget.productUploadModel.name,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 20),
                    Text(
                      "\$${widget.productUploadModel.currentPrice}",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    const Text("Current bid"),
                  ],
                ),
              ],
            ),
            // SizedBox(height: MediaQuery.of(context).size.height / 80),
            Padding(padding: EdgeInsets.all(10.0)),
            Container(
              width: 300, // Set the desired width
              height: 2, // Set the desired height
              color: Colors.grey.shade400,
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 60),
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 20.0),
              child: Text(
                "Time remaining",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 20.0),
              child: Text(
                "08:19:42 seconds",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff575757),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.all(10.0)),
            Container(
              width: 300, // Set the desired width
              height: 2, // Set the desired height
              color: Colors.grey.shade400,
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 60),
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 20.0),
              child: Text(
                "Fixed bid increment",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 20.0),
              child: Text(
                "\$${widget.productUploadModel.currentPrice + widget.productUploadModel.startPrice * (widget.productUploadModel.increment * 0.01)}",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff575757),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.all(10.0)),
            Container(
              width: 300, // Set the desired width
              height: 2, // Set the desired height
              color: Colors.grey.shade400,
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 60),
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 20.0),
              child: Text(
                "Select bid amount",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 60),
            Row(
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Icon(
                      CupertinoIcons.minus_circle_fill,
                      color: primaryAccentColor,
                      size: 30,
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(left: 10)),
                Container(
                  width: 120,
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
                      contentPadding: EdgeInsets.only(left: 10, bottom: 10),
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
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Icon(
                      CupertinoIcons.add_circled_solid,
                      color: primaryAccentColor,
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 25),
            Text(
                "The bid amount must be greater than the current bid amount: \$${widget.productUploadModel.currentPrice + widget.productUploadModel.startPrice * (widget.productUploadModel.increment * 0.01)}"),
            SizedBox(height: MediaQuery.of(context).size.height / 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(164, 50.0),
                    backgroundColor: secondaryAccentColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
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
                    backgroundColor: primaryAccentColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onPressed: () async {
                    int minAmount = widget.productUploadModel.currentPrice +
                        widget.productUploadModel.increment;
                    ;
                    String bidId = generateRandomId();
                    if (int.parse(bidAmount) > minAmount) {
                      BidModel bidModel = BidModel(
                        bidAmount: int.parse(bidAmount).toString(),
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
                  child: Text(
                    "Place bid",
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
      ),
    );
  }
}

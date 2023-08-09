import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../const/constants.dart';

class PlaceBid extends StatelessWidget {
  const PlaceBid({super.key});

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
                Container(
                  width: 205,
                  height: 198,
                  child: Image.asset("assets/images/image.png"),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment
                      .start, // Align children to the start (top) of the column
                  children: [
                    Container(
                      // decoration: BoxDecoration(color: Colors.grey),
                      // alignment: Alignment.topRight,
                      child: const Text(
                        "Telephone",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 20),
                    const Text(
                      "\$13K",
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
                "\$50",
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
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: '\$50',
                      contentPadding: EdgeInsets.only(left: 10, bottom: 10),
                    ),
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
            SizedBox(height: MediaQuery.of(context).size.height / 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(164, 50.0),
                    backgroundColor: Color(0xFFE2D784),
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
                    backgroundColor: Color(0xFF05595B),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onPressed: () {},
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

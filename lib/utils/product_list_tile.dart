import 'package:flutter/material.dart';

class ProductListTile extends StatelessWidget {
  const ProductListTile(
      {super.key,
      required this.pname,
      // required this.description,
      required this.price,
      required this.time,
      required this.image});
  final String pname;
  // final String description;
  final String price;
  final String time;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // image
        Container(height: 88, width: 88, child: Image.asset(image)),

        // name column
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: SizedBox(
            width: 150,
            // height: 75,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(padding: EdgeInsets.only(top: 3.0)),
                Text(
                  pname,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 5.0)),
                Text("current bid"),
                Text(
                  price,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ),

        // time left column
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(padding: EdgeInsets.only(top: 30.0)),
            Text("Time left"),
            Text(
              time.toString(),
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

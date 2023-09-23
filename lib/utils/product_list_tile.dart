import 'package:auctify/const/constants.dart';
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
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // image
              Container(height: 88, width: 88, child: Image.network(image)),

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
                        style: mediumTitle,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Padding(padding: EdgeInsets.only(top: 5.0)),
                      Text(
                        "current bid",
                        style: smallNormal,
                      ),
                      Text("\$$price", style: normalImportant),
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
                  Text(time.toString(), style: smallImportant),
                ],
              ),
            ],
          ),
          Divider(
            // thickness: 8,
            color: Colors.black,
          )
        ],
      ),
    );
  }
}

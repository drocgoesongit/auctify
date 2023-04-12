import 'package:flutter/material.dart';

class ProductListTile extends StatelessWidget {
  const ProductListTile(
      {super.key,
      required this.name,
      required this.description,
      required this.price,
      required this.time,
      required this.imageLink});
  final String name;
  final String description;
  final String price;
  final int time;
  final String imageLink;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // image
        Container(height: 120, width: 120, child: Image.network(imageLink)),

        // name column
        Column(
          children: [
            Text(name),
            Text(description),
            Text(price),
          ],
        ),

        // time left column
        Column(
          children: [
            Text("Time left"),
            Text(time.toString()),
          ],
        )
      ],
    );
  }
}

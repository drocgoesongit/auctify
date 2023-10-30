import 'package:auctify/const/constants.dart';
import 'package:flutter/material.dart';

class OrderCard extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final String day;

  const OrderCard({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    required this.day,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12.0),
      child: SizedBox(
        width: 180,
        height: 240,
        child: Card(
          color: Colors.white,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(8),
                child: Container(
                  width: 160,
                  height: 130,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    image: DecorationImage(
                      image: AssetImage(image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: mediumTitle,
                    ),
                    SizedBox(height: 2),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('expected delivery by',
                            style: smallNormal.copyWith(fontSize: 10)),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Expanded(
                                child: Text(
                              day,
                              style: normalImportant,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            )),
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Stack(
                                children: [
                                  Container(
                                    width: 60,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      color: Colors.green
                                          .shade200, // Adjust the color as needed
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  Positioned(
                                    left: 8,
                                    top: 7,
                                    child: Container(
                                      width: 6,
                                      height: 6,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors
                                            .green, // Adjust the color as needed
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 18,
                                    top: 3,
                                    child: Text(
                                      'placed',
                                      style: TextStyle(
                                          fontSize: 8,
                                          fontWeight: FontWeight
                                              .w600), // Adjust the style as needed
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PastOrder extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final String day;

  const PastOrder({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    required this.day,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12.0),
      child: SizedBox(
        width: 180,
        height: 240,
        child: Card(
          color: Colors.white,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(8),
                child: Container(
                  width: 160,
                  height: 130,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    image: DecorationImage(
                      image: AssetImage(image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: mediumTitle,
                    ),
                    SizedBox(height: 2),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('delivered on',
                            style: smallNormal.copyWith(fontSize: 10)),
                        SizedBox(height: 4),
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(day, style: normalImportant),
                            SizedBox(width: 50),
                            Stack(
                              children: [
                                Container(
                                  width: 60,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    color: Colors.green
                                        .shade200, // Adjust the color as needed
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                Positioned(
                                  left: 8,
                                  top: 7,
                                  child: Container(
                                    width: 6,
                                    height: 6,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors
                                          .green, // Adjust the color as needed
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 18,
                                  top: 3,
                                  child: Text(
                                    'placed',
                                    style: TextStyle(
                                        fontSize: 8,
                                        fontWeight: FontWeight
                                            .w600), // Adjust the style as needed
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

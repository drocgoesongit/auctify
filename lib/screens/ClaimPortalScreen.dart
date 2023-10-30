import 'package:auctify/utils/product_detail_tile.dart';
import 'package:flutter/material.dart';
import '../const/constants.dart';

class ClaimPortal extends StatelessWidget {
  const ClaimPortal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Claim",
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
              Container(
                  width: 350.0,
                  height: 60.0,
                  decoration: BoxDecoration(
                    color: Colors.green.shade200,
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(
                      color: Colors.green, // Green border color
                      width: 1.5, // Border width
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 16),
                      ),
                      Image.asset(
                          'assets/images/star.png'), // Replace 'path_to_your_image' with the actual path to your image
                      const Padding(
                        padding: EdgeInsets.only(left: 16),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Woah!',
                            style: mediumTitle,
                          ),
                          // Padding(
                          //     padding: EdgeInsets.all(
                          //         MediaQuery.of(context).size.height / 8)),
                          RichText(
                            text: const TextSpan(
                              children: [
                                TextSpan(
                                  text: 'You have won the bid for \$',
                                  style: normalText,
                                ),
                                TextSpan(
                                  text: '76',
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  )),
              const SizedBox(height: 16),
              Row(
                children: [
                  Image.asset("assets/images/clock.png"),
                  const Padding(padding: EdgeInsets.only(right: 10)),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "These 3 lines are for product \ndescription till the end of the line.",
                        style: smallNormal,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        '@alexj0563',
                        style: TextStyle(fontSize: 12.0),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Row(
                        children: [
                          Text(
                            '\$',
                            style: TextStyle(
                                fontSize: 12.0, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            '76',
                            style: TextStyle(
                                fontSize: 24.0, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            ' to claim',
                            style: TextStyle(fontSize: 12.0),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 18,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Your position",
                        style: smallImportant,
                      ),
                      // SizedBox(height: 6),
                      Text(
                        "2nd",
                        style: normalImportant,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Payment Time Remaining",
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
              const SizedBox(
                height: 24,
              ),
              Container(
                  width: 340.0,
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
                        padding: EdgeInsets.only(left: 16),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(padding: EdgeInsets.only(top: 8)),
                          Text(
                            'If you don’t want the product or if you fail to \nclaim the product within the stipulated time, \nit will be allocated to the next highest bidder.',
                            style: smallImportant,
                            // softWrap: true,
                          ),
                        ],
                      )
                    ],
                  )),
              const SizedBox(height: 16),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        "Top Bids",
                        style: normalImportant,
                      ),
                      Row(
                        children: [
                          Text(
                            "Bid count",
                            style: smallNormal,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            "93",
                            style: normalImportant,
                          )
                        ],
                      )
                    ],
                  ),
                  Text(
                    "see all bids",
                    style: smallNormal,
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

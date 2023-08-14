import 'package:auctify/const/constants.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Dashboard',
          style: kAppbarTitle,
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(child: const BidCards()),
    );
  }
}

class BidCardItem extends StatelessWidget {
  final String imagePath;
  final String title;
  final String totalBids;
  final String bidDetails;

  const BidCardItem({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.totalBids,
    required this.bidDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: secondaryAccentColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: SizedBox(
          width: 350,
          height: 130,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: Image.asset(
                        imagePath,
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 5),
                          Text(
                            title,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'total bids: $totalBids',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            bidDetails,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
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

class BidCards extends StatelessWidget {
  const BidCards({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 20, top: 20),
          child: Title(
            color: Colors.black,
            child: const Text(
              "Ongoing bids",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        const SizedBox(height: 12),
        BidCardItem(
          imagePath: "assets/images/pearl.png",
          title: "Pearl",
          totalBids: "12",
          bidDetails: "Current bid: \$12K",
        ),
        const SizedBox(height: 20),
        BidCardItem(
          imagePath: "assets/images/image.png",
          title: "Telephone",
          totalBids: "22",
          bidDetails: "Current bid: \$13K",
        ),
        const SizedBox(height: 20),
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 20, top: 20),
          child: Title(
            color: Colors.black,
            child: const Text(
              "Previous bids",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        const SizedBox(height: 12),
        BidCardItem(
          imagePath: "assets/images/lamp.png",
          title: "Magic Lamp",
          totalBids: "22",
          bidDetails: "Bid closed @ \$13K",
        ),
        const SizedBox(height: 20),
        BidCardItem(
          imagePath: "assets/images/nike.png",
          title: "Nike MAG",
          totalBids: "22",
          bidDetails: "Bid closed @ \$13K",
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}

import 'package:auctify/const/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class WishlistCard extends StatelessWidget {
  final String pname;
  final String uname;
  final String image;
  final String price;
  const WishlistCard(
      {super.key,
      required this.pname,
      required this.uname,
      required this.price,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: const ValueKey(0),
      endActionPane: ActionPane(
        dismissible: DismissiblePane(onDismissed: () {}),
        motion: const BehindMotion(),
        children: [
          SlidableAction(
            icon: Icons.delete_outline_rounded,
            backgroundColor: Colors.red,
            borderRadius: BorderRadius.circular(8),
            onPressed: (context) => {},
          )
        ],
      ),
      child: Card(
        elevation: 4,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              // Left side: Image
              Container(
                width: 80.0,
                height: 80.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0),
                  image: DecorationImage(
                    image: AssetImage(image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Right side: Details
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(pname,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: smallNormal.copyWith(
                              fontWeight: FontWeight.w500, fontSize: 16)),
                      const SizedBox(height: 2.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            uname,
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                fontFamily: "Inter"),
                          ),
                          const Text(
                            "2d 14h remaining",
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                      const SizedBox(height: 4.0),
                      const Text(
                        "current bid",
                        style: TextStyle(
                            fontSize: 8,
                            fontWeight: FontWeight.w400,
                            fontFamily: "Inter"),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            price,
                            style: normalImportant.copyWith(fontSize: 20),
                          ),
                          OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                // minimumSize: const Size(72, 24.0),
                                backgroundColor: primaryAccentColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              onPressed:
                                  () {}, //Logic to redirect to place bid screen
                              child: Text(
                                "Bid",
                                style: smallImportant.copyWith(
                                    color: secondaryAccentColor, fontSize: 14),
                              ))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

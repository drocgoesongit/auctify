import 'dart:async';

import 'package:auctify/const/constants.dart';
import 'package:auctify/const/util_functions.dart';
import 'package:flutter/material.dart';

class ProductListTile extends StatefulWidget {
  const ProductListTile(
      {super.key,
      required this.pname,
      // required this.description,
      required this.price,
      required this.time,
      required this.endDate,
      required this.image});
  final String pname;
  // final String description;
  final String price;
  final String time;
  final String endDate;
  final String image;

  @override
  State<ProductListTile> createState() => _ProductListTileState();
}

class _ProductListTileState extends State<ProductListTile> {
  late Duration _remainingTime;
  late Timer _timer;
  bool ended = false;

  @override
  void initState() {
    super.initState();
    _remainingTime = calculateRemainingTime(widget.endDate, widget.time);
    if (_remainingTime.isNegative) {
      ended = true;
    }
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _remainingTime = calculateRemainingTime(widget.endDate, widget.time);
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final days = _remainingTime.inDays.toString().padLeft(2, '0');
    final hours =
        _remainingTime.inHours.remainder(24).toString().padLeft(2, '0');
    final minutes =
        _remainingTime.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds =
        _remainingTime.inSeconds.remainder(60).toString().padLeft(2, '0');
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // image
              Container(
                  height: 88, width: 88, child: Image.network(widget.image)),

              // name column
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: SizedBox(
                    width: 150,
                    // height: 75,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(padding: EdgeInsets.only(top: 3.0)),
                        Text(
                          widget.pname,
                          style: mediumTitle,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Padding(padding: EdgeInsets.only(top: 5.0)),
                        Text(
                          "current bid",
                          style: smallNormal,
                        ),
                        Text("\$${widget.price}", style: normalImportant),
                      ],
                    ),
                  ),
                ),
              ),

              // time left column
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(padding: EdgeInsets.only(top: 30.0)),
                  Text("Time left"),
                  ended == true
                      ? Text(
                          "Ended",
                          style: normalImportant,
                        )
                      : Text(
                          "$days Days $hours:$minutes:$seconds",
                          style: normalImportant,
                        ),
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

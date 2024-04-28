import 'dart:async';

import 'package:auctify/const/constants.dart';
import 'package:auctify/const/util_functions.dart';
import 'package:flutter/material.dart';

class TickerDown extends StatefulWidget {
  const TickerDown({super.key, required this.endTime, required this.endDate});

  final String endTime;
  final String endDate;
  @override
  State<TickerDown> createState() => _TickerDownState();
}

class _TickerDownState extends State<TickerDown> {
  late Duration _remainingTime;
  late Timer _timer;
  bool ended = false;

  @override
  void initState() {
    super.initState();
    _remainingTime = calculateRemainingTime(widget.endDate, widget.endTime);
    if (_remainingTime.isNegative) {
      ended = true;
    }
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _remainingTime = calculateRemainingTime(widget.endDate, widget.endTime);
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    // TODO: implement dispose
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Time Remaining",
          style: smallImportant,
        ),
        SizedBox(height: 6),
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
    );
  }
}

import 'package:flutter/material.dart';
import 'dart:async';

class CountdownOrDaysLeftWidget extends StatefulWidget {
  final DateTime targetDate;

  CountdownOrDaysLeftWidget({required this.targetDate});

  @override
  _CountdownOrDaysLeftWidgetState createState() =>
      _CountdownOrDaysLeftWidgetState();
}

class _CountdownOrDaysLeftWidgetState extends State<CountdownOrDaysLeftWidget> {
  late Timer _timer;
  bool _showCountdown = true;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String formatDuration(Duration duration) {
    return duration.toString().split('.').first.padLeft(8, "0");
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final difference = widget.targetDate.difference(now);

    if (difference.isNegative) {
      // Time has already passed
      return Text('Time has already passed.');
    }

    if (difference.inDays > 0) {
      // More than a day left
      return Text(
          '${difference.inDays} day${difference.inDays > 1 ? "s" : ""} left');
    }

    // Less than a day left, show countdown timer
    return Text(formatDuration(difference));
  }
}

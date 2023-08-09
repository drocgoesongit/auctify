import 'package:flutter/material.dart';

class PreviousBids extends StatelessWidget {
  final String name;
  final String username;
  final String bid;
  final String status;
  final String time;
  final String profile;

  const PreviousBids({
    Key? key,
    required this.name,
    required this.username,
    required this.bid,
    required this.status,
    required this.time,
    required this.profile,
  }) : super(key: key);

  Color getStatusColor(String status) {
    if (status == "winning") {
      return Colors.green;
    } else if (status == "outbid") {
      return Colors.yellow.shade300;
    } else if (status == "losing") {
      return Colors.red;
    } else {
      // Default color if status doesn't match any of the above conditions
      return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //profile
        SizedBox(height: 45, width: 45, child: Image.asset(profile)),

        //name column
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: SizedBox(
            width: 150,
            height: 35,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  username,
                  style: TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade400,
                  ),
                ),
              ],
            ),
          ),
        ),

        //bid & status
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: SizedBox(
            width: 50,
            // height: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  bid,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                Text(
                  status,
                  style: TextStyle(color: getStatusColor(status), fontSize: 10),
                ),
              ],
            ),
          ),
        ),

        //time
        Text(
          time.toString(),
          style: TextStyle(
            fontSize: 10,
            color: Color(0xff545454),
          ),
          textAlign: TextAlign.left,
        ),
      ],
    );
  }
}

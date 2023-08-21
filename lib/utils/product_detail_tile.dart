import 'package:auctify/const/util_functions.dart';
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
      return Colors.red;
    } else if (status == "losing") {
      return Colors.red;
    } else if (status == "second") {
      return Colors.blue;
    } else if (status == "third") {
      return Colors.orange;
    } else {
      // Default color if status doesn't match any of the above conditions
      return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    String timeOfTheDay = getTimeInAMPMFormat(DateTime.parse(time));
    return Column(children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //profile
          SizedBox(
            height: 50,
          ),
          CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(
              profile,
            ),
          ),

          //name column
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      username,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ],
                ),
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
                    "\$$bid",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  Text(
                    status,
                    style:
                        TextStyle(color: getStatusColor(status), fontSize: 10),
                  ),
                ],
              ),
            ),
          ),

          //time
          Text(
            timeOfTheDay,
            style: const TextStyle(
              fontSize: 10,
              color: Color(0xff545454),
            ),
            textAlign: TextAlign.left,
          ),
        ],
      ),
      SizedBox(
        height: 8.0,
      ),
    ]);
  }
}

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

  Color getStatusBorderColor(String status) {
    if (status == "winning") {
      return Colors.green.shade700;
    } else if (status == "second") {
      return Colors.blue;
    } else if (status == "third") {
      return Colors.orange;
    } else if (status == "outbid") {
      return Colors.red;
    } else if (status == "losing") {
      return Colors.red;
    } else {
      return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    String timeOfTheDay = getTimeInAMPMFormat(DateTime.parse(time));
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(
              color: getStatusBorderColor(
                  status), // Define a function to get the color based on the status
              width: 2.0, // Border width
            ),
            borderRadius: BorderRadius.circular(8), // Border radius
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(profile),
              ),
              // Name column
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        username,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: "Inter",
                          color: Colors.grey.shade400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Bid & status
              Container(
                padding: EdgeInsets.only(top: 4),
                width: 70,
                child: Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "\$$bid",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          status,
                          style: TextStyle(
                            fontFamily: "Inter",
                            color: getStatusColor(status),
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Time
              Container(
                padding: EdgeInsets.only(top: 12),
                width: 50,
                alignment: Alignment.centerLeft,
                child: Text(
                  timeOfTheDay,
                  style: const TextStyle(
                    fontSize: 10,
                    fontFamily: "Inter",
                    color: Color(0xff545454),
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 8.0,
        ),
      ],
    );
  }
}

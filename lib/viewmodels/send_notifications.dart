import 'dart:convert';
import 'dart:developer';
import 'package:auctify/const/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SendNotifications {
  Future<String> sendWinnerEmail(String email, String name) async {
    log("sendNotificationVM: started sending email to $email");
    Uri url = Uri.parse("https://api.courier.com/send");
    final jsonData = {
      "message": {
        "to": {"email": email},
        "template": kThanksTemplate,
        "data": {"name": name},
        "routing": {
          "method": "single",
          "channels": ["email"]
        }
      }
    };
    final jsonBody = json.encode(jsonData);
    const authorization = "Bearer $kCourierApiKey";

    http.Response response = await http.post(url,
        headers: {
          'authorization': authorization,
          'Content-type': "application/json",
        },
        body: jsonBody);

    var body = response.body;
    var data = jsonDecode(body);

    if (response.statusCode == 200) {
      log("email sent Successfully.");
      return "s";
    } else {
      log("email not sent. Error: ${data['error']}");
      return "e";
    }
  }
}

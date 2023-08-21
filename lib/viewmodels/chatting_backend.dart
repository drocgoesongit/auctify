import 'dart:developer';

import 'package:auctify/models/group_message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChattingBackend {
  Future<void> sendMessage(GroupMessageModel messageModel, BuildContext context,
      String chatId) async {
    try {
      log("sending message to backend.");
      await FirebaseFirestore.instance
          .collection("chats")
          .doc(chatId)
          .collection("messages")
          .doc(messageModel.id)
          .set(messageModel.toMap());
    } catch (e) {
      log(e.toString());
      log("error while sending the message.");
    }
  }
}

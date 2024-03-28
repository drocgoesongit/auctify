import 'dart:developer';

import 'package:auctify/const/constants.dart';
import 'package:auctify/const/util_functions.dart';
import 'package:auctify/models/group_message_model.dart';
import 'package:auctify/models/user_login_model.dart';
import 'package:auctify/viewmodels/chatting_backend.dart';
import 'package:auctify/viewmodels/profile_viewmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class GroupChatDetialScreen extends StatefulWidget {
  const GroupChatDetialScreen({super.key, required this.chatId});
  final String chatId;

  @override
  State<GroupChatDetialScreen> createState() => _GroupChatDetialScreenState();  
}

class _GroupChatDetialScreenState extends State<GroupChatDetialScreen> {
  late TextEditingController _messageController;
  FocusNode _messageFocusNode = FocusNode();

  String message = "";
  late UserLoginModel? userLoginModel;

  Stream<List<GroupMessageModel>> getGroupChat(String productId) {
    return FirebaseFirestore.instance
        .collection('chats')
        .doc(widget.chatId)
        .collection("messages")
        .orderBy('timeStamp', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => GroupMessageModel.fromMap(doc.data()))
          .toList();
    });
  }

  Future<void> getUserDetail() async {
    userLoginModel = await ProfileViewModel().getUserProfile(context);
    log("user login model infor found");
  }

  @override
  void initState() {
    super.initState();
    _messageController = TextEditingController();
    _messageFocusNode.addListener(() {
      if (!_messageFocusNode.hasFocus) {
        // Clear the input field after losing focus
      }
    });

    Future.delayed(Duration.zero, () {
      getUserDetail();
    });
  }

  // stream function to get chats.

  // send Message functions.

  Future<void> sendMessage(BuildContext context) async {
    if (message.isNotEmpty && userLoginModel != null) {
      log("starting to send message and message is not empty.");
      String randomId = generateRandomId();
      int timeStamp = DateTime.now().millisecondsSinceEpoch;
      GroupMessageModel messageModel = GroupMessageModel(
          content: message,
          senderId: FirebaseAuth.instance.currentUser!.uid,
          senderImage: "",
          senderName: userLoginModel!.firstName,
          id: randomId,
          timeStamp: timeStamp,
          type: 0);
      log("model created successfully. ");
      ChattingBackend().sendMessage(messageModel, context, widget.chatId);
      _messageController.clear();
    } else {
      log(" error while sending message either empty message or userinfo not retrieved.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Group Chat",
          style: kAppbarTitle,
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height - 100,
        child: Column(children: [
          Expanded(
            child: StreamBuilder<List<GroupMessageModel>>(
              stream: getGroupChat(widget.chatId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.data!.isEmpty) {
                  return Center(child: Text('No messages available.'));
                } else if (snapshot.hasData) {
                  List<GroupMessageModel> messages = snapshot.data!;

                  return ListView.builder(
                    reverse:
                        true, // To display the latest messages at the bottom
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      GroupMessageModel message = messages[index];
                      String time = formatTimestampToAmPm(message.timeStamp);
                      return Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: ListTile(
                            leading: CircleAvatar(
                                backgroundImage:
                                    AssetImage("assets/images/profile.png")),
                            subtitle: Text(message.content,
                                style: TextStyle(fontFamily: "Inter")),
                            title: Text(message.senderName,
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "Inter")),
                            trailing: Text(
                              time,
                              style: TextStyle(fontFamily: "Inter"),
                            )
                            // You can display the sender's image and other information here
                            ),
                      );
                    },
                  );
                } else {
                  return Center(child: Text('No messages available.'));
                }
              },
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _messageController,
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 16,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                          color: Colors.black, // Border color
                          width: 1, // Border width
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                          color: Colors.black, // Focused border color
                          width: 1, // Border width
                        ),
                      ),
                      hintText: 'Type a message...',
                      hintStyle: TextStyle(fontFamily: "Inter"),
                    ),
                    focusNode: _messageFocusNode,
                    onChanged: (value) {
                      setState(() {
                        message = value;
                      });
                    },
                    maxLines: null,
                    minLines: 1,
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    sendMessage(context);
                    _messageController.clear();
                  },
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    backgroundColor: Colors.black,
                    padding: EdgeInsets.all(16),
                  ),
                  child: Icon(
                    Icons.send_rounded,
                    color: Colors.white,
                    size: 25,
                  ),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}

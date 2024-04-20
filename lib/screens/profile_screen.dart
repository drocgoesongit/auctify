import 'package:auctify/screens/dashboard_screen.dart';
import 'package:auctify/screens/faqs_screen.dart';
import 'package:auctify/screens/settings_screen.dart';
import 'package:auctify/screens/signin_screen.dart';
import 'package:auctify/viewmodels/profile_viewmodel.dart';
import 'package:auctify/viewmodels/signin_viewmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../const/constants.dart';
import '../models/user_login_model.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late String numberOfBidPlaced;
  late UserLoginModel? userLoginModel;

  Future<UserLoginModel?> getUserInfo(BuildContext context) async {
    try {
      userLoginModel = await ProfileViewModel().getUserProfile(context);
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection("bids")
          .where("bidderId", isEqualTo: userLoginModel!.uid)
          .get();
      if (userLoginModel == null) {
        return UserLoginModel(
            email: "error",
            firstName: "error",
            lastName: "error",
            registerTime: "error",
            uid: "error");
      } else {
        numberOfBidPlaced = snapshot.docs.length.toString();
      }

      return userLoginModel;
    } catch (e) {
      return UserLoginModel(
          email: "error",
          firstName: "error",
          lastName: "error",
          registerTime: "error",
          uid: "error");
    }
  }

  void showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout'),
          content: Text('Are you sure you want to logout?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Call your backend logout function here
                SignInBackend().logout(context);
                // Example: AuthService.logout();
                Navigator.of(context).pop(); // Close the dialog
                // You can navigate to another screen after logout if needed
                // Example: Navigator.pushReplacementNamed(context, '/login');
              },
              child: Text('Logout'),
            ),
          ],
        );
      },
    );
  }

  Widget buildInfoRow(String text, String subtext) {
    return Column(
      children: [
        Text(
          text,
          style: const TextStyle(
            fontFamily: "Inter",
            fontSize: 30,
            fontWeight: FontWeight.w600,
            color: Color(0xff000000),
            height: 45 / 30,
          ),
          textAlign: TextAlign.left,
        ),
        const Padding(padding: EdgeInsets.only(top: 4)),
        Text(
          subtext,
          style: const TextStyle(
            fontFamily: "Inter",
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color(0xff000000),
            height: 24 / 16,
          ),
        ),
      ],
    );
  }

  Widget buildMenuItem(IconData icon, String title) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon),
            const Padding(padding: EdgeInsets.only(left: 15)),
            Text(title),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          width: 350,
          height: 2,
          color: Colors.grey.shade400,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Profile",
                style: kAppbarTitle,
              ),
              Icon(Icons.mode_edit_outline_outlined)
            ],
          ),
          backgroundColor: Colors.white,
        ),
        body: FutureBuilder(
            future: getUserInfo(context),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                    child: Center(child: CircularProgressIndicator()));
              } else if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData &&
                  snapshot.data!.email != "error") {
                return SingleChildScrollView(
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.width / 20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 130,
                            height: 130,
                            child: Image.asset("assets/images/profile.png"),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${snapshot.data!.firstName} ",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              Text("${snapshot.data!.lastName}"),
                              const SizedBox(height: 10),
                              OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  minimumSize: const Size(164, 37.0),
                                  backgroundColor: primaryAccentColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                onPressed: () {},
                                child: const Text(
                                  "Become a seller",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          buildInfoRow(numberOfBidPlaced, "Bid placed"),
                          Container(
                            width: 2.23,
                            height: 75,
                            color: Colors.black,
                          ),
                          buildInfoRow("0", "Bid won"),
                        ],
                      ),
                      const SizedBox(height: 20),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SettingPage()));
                        },
                        child: Row(
                          children: [
                            Title(
                              color: Colors.black,
                              child: Text(
                                "Settings",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500),
                              ),
                            ),
                            const Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Colors.black,
                              size: 18,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height / 40),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Dashboard()));
                          },
                          child: buildMenuItem(
                              Icons.dashboard_outlined, "Dashboard")),
                      SizedBox(height: MediaQuery.of(context).size.height / 40),
                      GestureDetector(
                          onTap: () {},
                          child: buildMenuItem(
                              CupertinoIcons.exclamationmark_circle,
                              "About us")),
                      SizedBox(height: MediaQuery.of(context).size.height / 40),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FAQsScreen()));
                          },
                          child: buildMenuItem(
                              CupertinoIcons.question_circle, "FAQs")),
                      SizedBox(height: MediaQuery.of(context).size.height / 40),
                      GestureDetector(
                          onTap: () {
                            showLogoutConfirmationDialog(context);
                            // alert box to ask whether to confirm logout or not and then logout
                          },
                          child: buildMenuItem(Icons.logout_rounded, "Logout")),
                      SizedBox(height: MediaQuery.of(context).size.height / 40),
                    ],
                  ),
                );
              } else if (snapshot.data!.email == "error") {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SigninScreen()));
                  },
                  child: Center(
                      child:
                          Text("You are not logged in. Click here to login.")),
                );
              } else {
                return Center(child: Text("Error"));
              }
            }));
  }
}

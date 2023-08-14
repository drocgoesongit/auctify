import 'package:auctify/screens/dashboard_screen.dart';
import 'package:auctify/screens/settings_screen.dart';
import 'package:auctify/screens/signin_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../const/constants.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  Widget buildInfoRow(String text, String subtext) {
    return Column(
      children: [
        Text(
          text,
          style: const TextStyle(
            fontFamily: "Poppins",
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
            fontFamily: "Poppins",
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
      body: SingleChildScrollView(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width / 20),
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
                    const Text(
                      "Zelda fitz",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const Text("Purrfect"),
                    const SizedBox(height: 10),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(164, 37.0),
                        backgroundColor: Color(0xFF05595B),
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
                buildInfoRow("37", "Bid placed"),
                Container(
                  width: 2.23,
                  height: 75,
                  color: Colors.black,
                ),
                buildInfoRow("27", "Bid won"),
              ],
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SettingPage()));
              },
              child: Row(
                children: [
                  Title(
                    color: Colors.black,
                    child: Text(
                      "Settings",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
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
                onTap: () {},
                child: buildMenuItem(Icons.edit_outlined, "Edit profile")),
            SizedBox(height: MediaQuery.of(context).size.height / 40),
            GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Dashboard()));
                },
                child: buildMenuItem(Icons.dashboard_outlined, "Dashboard")),
            SizedBox(height: MediaQuery.of(context).size.height / 40),
            GestureDetector(
                onTap: () {},
                child: buildMenuItem(
                    CupertinoIcons.exclamationmark_circle, "About us")),
            SizedBox(height: MediaQuery.of(context).size.height / 40),
            GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SigninScreen()));
                },
                child: buildMenuItem(Icons.logout_rounded, "Logout")),
            SizedBox(height: MediaQuery.of(context).size.height / 40),
            GestureDetector(
                onTap: () {},
                child: buildMenuItem(Icons.edit_outlined, "Edit profile")),
            SizedBox(height: MediaQuery.of(context).size.height / 40),
            GestureDetector(
                onTap: () {},
                child: buildMenuItem(Icons.edit_outlined, "Edit profile")),
          ],
        ),
      ),
    );
  }
}

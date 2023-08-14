import 'package:flutter/material.dart';
import 'package:auctify/const/constants.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Settings",
          style: kAppbarTitle,
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 16, right: 16),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Container(
              height: 65,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 243, 233, 198),
                  borderRadius: BorderRadius.circular(16)),
              child: Center(
                child: TextFormField(
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: 'Search for a setting',
                      border: InputBorder.none),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            image("assets/images/Lang n country.png", "Language and Country",
                "assets/images/side arrow.png"),
            image("assets/images/Notification.png", "Notification",
                "assets/images/side arrow.png"),
            image("assets/images/legal n About.png", "Legal & About",
                "assets/images/side arrow.png"),
            image(
                "assets/images/FAQ.png", "FAQ", "assets/images/side arrow.png"),
            image("assets/images/Rate our App.png", "Rate our App",
                "assets/images/side arrow.png"),
          ],
        ),
      ),
    );
  }

  Widget image(String firstIcon, String text, String secondIcon) {
    return Column(
      children: [
        Row(
          children: [
            Image.asset(firstIcon),
            SizedBox(
              width: 20,
              height: 40,
            ),
            Text(text),
            Spacer(),
            Image.asset(secondIcon),
          ],
        ),
        Divider(
          color: Colors.black,
        )
      ],
    );
  }
}

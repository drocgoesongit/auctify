import 'package:auctify/const/constants.dart';
// import 'package:auctify/screens/product_detail_screen.dart';
import 'package:auctify/screens/product_list_screen.dart';
import 'package:auctify/screens/signin_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
          bottomNavigationBar: BottomNavigationBar(items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "home"),
            BottomNavigationBarItem(
                icon: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductListScreen()));
                    },
                    child: Icon(Icons.search)),
                label: "search"),
          ]),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                    width: double.infinity,
                    child: InkWell(
                      child: Text(
                        "Keep calm and \nBid on!",
                        style: kPageTitle,
                      ),
                    )),
                Container(
                  height: MediaQuery.of(context).size.height / 5,
                ),
                Text("Categories"),
                Container(
                  height: MediaQuery.of(context).size.height / 6,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    children: [
                      CircleAvatar(
                        radius: 50.0,
                      ),
                      CircleAvatar(
                        radius: 50.0,
                      ),
                      CircleAvatar(
                        radius: 50.0,
                      ),
                      CircleAvatar(
                        radius: 50.0,
                      ),
                    ],
                  ),
                ),
                Text("Trending right now"),
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SigninScreen()));
                    },
                    child: Container(
                        width: double.infinity,
                        child: InkWell(
                          child: Text(
                            "Log Out",
                            style: kPageTitle,
                          ),
                        ))),
                Container(
                  height: MediaQuery.of(context).size.height / 2,
                  child: ListView(
                      scrollDirection: Axis.horizontal,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: [
                        Container(
                          child: Column(children: [
                            Container(
                                width: MediaQuery.of(context).size.width / 3,
                                height: MediaQuery.of(context).size.width / 3)
                          ]),
                        )
                      ]),
                ),
              ],
            ),
          )),
    );
  }
}

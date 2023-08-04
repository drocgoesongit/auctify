import 'package:auctify/admin_screens/add_product.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: Column(
        children: [
          Text(
            "Profile Fragment",
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddProductScreenAdmin()));
            },
            child: Text("Add Product"),
          )
        ],
      )),
    );
  }
}

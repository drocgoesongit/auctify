import 'package:flutter/material.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Categories"),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Text("All categories in one place."),
          SizedBox(
            height: 20,
          ),
        ]),
      ),
    );
  }
}

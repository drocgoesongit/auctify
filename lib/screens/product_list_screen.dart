// import 'package:auctify/const/constants.dart';
// import 'package:auctify/utils/product_list_tile.dart';
// import 'package:flutter/material.dart';

// class ProductListScreen extends StatelessWidget {
//   const ProductListScreen({super.key});

//   // variables and all

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "Trending bids",
//           style: kAppbarTitle,
//         ),
//         leading: GestureDetector(
//           onTap: () {
//             Navigator.pop(context);
//           },
//           child: const Icon(
//             Icons.arrow_back,
//             color: Colors.black,
//           ),
//         ),
//         backgroundColor: Colors.white,
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           padding: EdgeInsets.all(MediaQuery.of(context).size.width / 20),
//           child: Column(children: [
//             // search bar container
//             Container(
//               // i want container with 12 radius border on all sides
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: secondaryAccentColor,
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Row(children: [
//                 const Icon(
//                   Icons.search,
//                 ),
//                 const SizedBox(
//                   width: 16,
//                 ),
//                 Flexible(child: TextFormField()),
//               ]),
//             ),

//             // filter part
//             SizedBox(height: MediaQuery.of(context).size.height / 40),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 Icon(Icons.filter),
//                 SizedBox(width: MediaQuery.of(context).size.height / 40),
//                 Text("Filter")
//               ],
//             ),

//             // list of products
//             SizedBox(height: MediaQuery.of(context).size.height / 80),
//             ListView(
//               shrinkWrap: true,
//               physics: NeverScrollableScrollPhysics(),
//               children: [
//                 ProductListTile(
//                     name: "Pearl",
//                     description: "xyz",
//                     price: "Infinite",
//                     time: 123,
//                     imageLink:
//                         "https://plus.unsplash.com/premium_photo-1669741908308-5ca216f3fcd1?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2069&q=80"),
//                 ProductListTile(
//                     name: "Pearl",
//                     description: "xyz",
//                     price: "Infinite",
//                     time: 123,
//                     imageLink:
//                         "https://plus.unsplash.com/premium_photo-1669741908308-5ca216f3fcd1?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2069&q=80"),
//                 ProductListTile(
//                     name: "Pearl",
//                     description: "xyz",
//                     price: "Infinite",
//                     time: 123,
//                     imageLink:
//                         "https://plus.unsplash.com/premium_photo-1669741908308-5ca216f3fcd1?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2069&q=80"),
//                 ProductListTile(
//                     name: "Pearl",
//                     description: "xyz",
//                     price: "Infinite",
//                     time: 123,
//                     imageLink:
//                         "https://plus.unsplash.com/premium_photo-1669741908308-5ca216f3fcd1?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2069&q=80"),
//                 ProductListTile(
//                     name: "Pearl",
//                     description: "xyz",
//                     price: "Infinite",
//                     time: 123,
//                     imageLink:
//                         "https://plus.unsplash.com/premium_photo-1669741908308-5ca216f3fcd1?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2069&q=80"),
//                 ProductListTile(
//                     name: "Pearl",
//                     description: "xyz",
//                     price: "Infinite",
//                     time: 123,
//                     imageLink:
//                         "https://plus.unsplash.com/premium_photo-1669741908308-5ca216f3fcd1?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2069&q=80"),
//                 ProductListTile(
//                     name: "Pearl",
//                     description: "xyz",
//                     price: "Infinite",
//                     time: 123,
//                     imageLink:
//                         "https://plus.unsplash.com/premium_photo-1669741908308-5ca216f3fcd1?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2069&q=80"),
//                 ProductListTile(
//                     name: "Pearl",
//                     description: "xyz",
//                     price: "Infinite",
//                     time: 123,
//                     imageLink:
//                         "https://plus.unsplash.com/premium_photo-1669741908308-5ca216f3fcd1?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2069&q=80"),
//                 ProductListTile(
//                     name: "Pearl",
//                     description: "xyz",
//                     price: "Infinite",
//                     time: 123,
//                     imageLink:
//                         "https://plus.unsplash.com/premium_photo-1669741908308-5ca216f3fcd1?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2069&q=80"),
//               ],
//             )
//           ]),
//         ),
//       ),
//     );
//   }
// }

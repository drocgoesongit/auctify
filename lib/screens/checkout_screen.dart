import 'package:auctify/models/address_model.dart';
import 'package:auctify/models/portal_model.dart';
import 'package:auctify/models/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CheckOutScreen extends StatelessWidget {
  CheckOutScreen(
      {super.key, required this.portalModel, required this.productModel});

  final ProductUploadModel productModel;
  final Portal portalModel;

  List<AddressModel> addressList = [];

  Future<String> getAddresses() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection("address")
          .where("userId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();
      if (snapshot.docs.length > 0) {
        for (var doc in snapshot.docs) {
          AddressModel addressModel =
              AddressModel.fromJson(doc.data() as Map<String, dynamic>);
          addressList.add(addressModel);
        }
        return "success";
      } else {
        return "none";
      }
    } catch (e) {
      return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Checkout")),
        body: SingleChildScrollView(
          child: Column(children: [
            FutureBuilder(
                future: getAddresses(),
                builder: ((context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.data == "success") {
                      return Column(children: [
                        Container(
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Select Address",
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(height: 10.0),
                              ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: addressList.length,
                                  itemBuilder: ((context, index) {
                                    return Container(
                                      padding: EdgeInsets.all(10.0),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.grey.shade300)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("${addressList[index].name}"),
                                          Text(
                                              "${addressList[index].completeAddress}"),
                                          Text(
                                              "${addressList[index].city}, ${addressList[index].state}"),
                                          Text("${addressList[index].pincode}"),
                                          Text(
                                              "${addressList[index].phoneNumber}"),
                                        ],
                                      ),
                                    );
                                  }))
                            ],
                          ),
                        ),
                        Container(
                            padding: EdgeInsets.all(10.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Payment Method",
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(height: 10.0),
                                  Container(
                                    padding: EdgeInsets.all(10.0),
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey)),
                                    child: Row(
                                      children: [
                                        Icon(Icons.credit_card),
                                        SizedBox(width: 10.0),
                                        Text("Credit/Debit Card")
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(10.0),
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey)),
                                    child: Row(
                                      children: [
                                        Icon(Icons.credit_card),
                                        SizedBox(width: 10.0),
                                        Text("Net Banking")
                                      ],
                                    ),
                                  ),
                                  Container(
                                      padding: EdgeInsets.all(10.0),
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.grey)),
                                      child: Row(children: [
                                        Icon(Icons.credit_card),
                                      ]))
                                ])),
                        SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          width: double.infinity,
                          child: Text("Invoice",
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.bold)),
                        ),
                        SizedBox(height: 10.0),
                        Table(
                          border: TableBorder.all(),
                          children: [
                            TableRow(
                              children: [
                                TableCell(
                                    child: Center(child: Text('Product Name'))),
                                TableCell(child: Center(child: Text('Price'))),
                                TableCell(
                                    child: Center(
                                        child: Text('Delivery Charges'))),
                                TableCell(
                                    child: Center(child: Text('Subtotal'))),
                              ],
                            ),
                            TableRow(
                              children: [
                                TableCell(
                                    child: Center(child: Text('Product A'))),
                                TableCell(
                                    child: Center(child: Text('\$50.00'))),
                                TableCell(child: Center(child: Text('\$5.00'))),
                                TableCell(
                                    child: Center(child: Text('\$55.00'))),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text(
                            'Delivery Info: Your product will be delivered within 3-5 business days.'),
                        SizedBox(height: 10),
                        Text('Total: \$55.00'),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    // Code to be executed when the first button is pressed
                                  },
                                  child: Text('Cancel'),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    // Code to be executed when the second button is pressed
                                  },
                                  child: Text('Pay Now'),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ]);
                    } else {
                      return Container(
                        child: Center(
                          child: Text("No address found."),
                        ),
                      );
                    }
                  } else {
                    return Container(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                }))
          ]),
        ));
  }
}

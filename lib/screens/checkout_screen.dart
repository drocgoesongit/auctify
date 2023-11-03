import 'dart:math';
import 'package:auctify/const/util_functions.dart';
import 'package:auctify/models/address_model.dart';
import 'package:auctify/models/order_model.dart';
import 'package:auctify/models/portal_model.dart';
import 'package:auctify/models/product_model.dart';
import 'package:auctify/screens/add_address_screen.dart';
import 'package:auctify/screens/home_screen.dart';
import 'package:auctify/viewmodels/payment_viewmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class CheckOutScreen extends StatefulWidget {
  CheckOutScreen(
      {super.key, required this.portalModel, required this.productModel});

  final ProductUploadModel productModel;
  final Portal portalModel;

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  List<AddressModel> addressList = [];
  String amount = "100";

  Razorpay _razorpay = Razorpay();
  late String order_id;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _razorpay.clear();
  }

  int getRandom() {
    Random random = Random();
    int randomNumber = random.nextInt(10000);
    return randomNumber; // from 0 upto 99 included
  }

  @override
  initState() {
    super.initState();

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

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
                                    var options = {
                                      'key': 'rzp_test_uj5csPT8ukw8hI',
                                      'amount': int.parse(amount) *
                                          100, //in the smallest currency sub-unit.
                                      'name': 'Billable',
                                      'retry': {
                                        'enabled': true,
                                        'max_count': 2,
                                      },
                                      'send_sms_hash': true,
                                      // 'order_id': 'order_EMBFqjDHEEn80l', // Generate order_id using Orders API
                                      'description': 'Complete order',
                                      'timeout': 60, // in seconds
                                    };

                                    _razorpay.open(options);
                                  },
                                  child: Text('Pay Now'),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ]);
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddAddressScreen()));
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddAddressScreen()));
                        },
                        child: Container(
                          child: Center(
                            child: Text("No address found."),
                          ),
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

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    OrderModel orderModel = OrderModel(
        id: generateRandomId(),
        productId: widget.productModel.id,
        timeCreated: DateTime.now().millisecondsSinceEpoch.toString(),
        status: "ordered",
        address: addressList[0].toString(),
        userId: FirebaseAuth.instance.currentUser!.uid,
        amount: widget.portalModel.portalCurrentWinnerBidAmount,
        paid: true,
        expectedDelivery: DateTime.now()
            .add(Duration(days: 5))
            .millisecondsSinceEpoch
            .toString());

    String status = await PaymentViewModel()
        .createOrderAndFinishPortal(widget.portalModel.portalId, orderModel);

    if (status == "success") {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Payment successful."),
        duration: Duration(milliseconds: 3000),
      ));
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Payment successful."),
        duration: Duration(milliseconds: 3000),
      ));
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Error: ${response.message}"),
      duration: const Duration(milliseconds: 2000),
    ));
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
  }
}

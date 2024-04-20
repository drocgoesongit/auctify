import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _activeStepIndex = 0;

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController pincode = TextEditingController();

  List<Step> stepList() => [
        Step(
          state: _activeStepIndex <= 0 ? StepState.editing : StepState.complete,
          isActive: _activeStepIndex >= 0,
          title: const Text('Address'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Select Delivery Address",
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10.0),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Kathleen",
                            style: TextStyle(
                                fontFamily: "Inter",
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.home_rounded,
                                size: 13,
                                color: Colors.grey.shade600,
                              ),
                              Text(
                                "Home",
                                style: TextStyle(
                                    fontFamily: "Inter",
                                    fontSize: 12,
                                    color: Colors.grey.shade600,
                                    fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ],
                      ),
                      const Text("981919191"),
                      const Padding(
                        padding: EdgeInsets.only(top: 4),
                        child: Text(
                            "Room no 405, 4th floor, C wing, Trevor Heights \nSector-D, FT lane \nColumbus, Ohio, 43004\nUnited States"),
                      ),
                      const SizedBox(height: 8.0),
                      OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            minimumSize: const Size(326, 50.0),
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                          ),
                          onPressed: () {},
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.edit_rounded,
                                size: 16,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text("Edit Address",
                                  style: TextStyle(
                                      fontFamily: "Inter",
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black)),
                            ],
                          )),
                      const SizedBox(
                        height: 8.0,
                      ),
                      OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            minimumSize: const Size(326, 50.0),
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                          ),
                          onPressed: () {},
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.edit_note_rounded,
                                size: 24,
                              ),
                              SizedBox(width: 4),
                              Text("Add delivery instructions",
                                  style: TextStyle(
                                      fontFamily: "Inter",
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black)),
                            ],
                          )),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(326, 50.0),
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                    ),
                    onPressed: () {},
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add,
                          size: 16,
                        ),
                        SizedBox(width: 4),
                        Text("Add new address",
                            style: TextStyle(
                                fontFamily: "Inter",
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.black)),
                      ],
                    )),
              ],
            ),
          ),
        ),
        Step(
            state:
                _activeStepIndex <= 1 ? StepState.editing : StepState.complete,
            isActive: _activeStepIndex >= 1,
            title: const Text('Invoice'),
            content: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Invoice",
                      style: TextStyle(
                        fontFamily: "Inter",
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      )),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Container(
                        height: 72,
                        width: 76,
                        child: Image.network(
                            "//www.digitalartgallery.in/wp-content/uploads/2021/08/DAF048-2-600x600.jpg"),
                      ),
                      const SizedBox(
                        width: 20.0,
                      ),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                "Vintage Wall Hanging Car (Brown Color) \nCedar and Cherry Wood",
                                style: TextStyle(
                                  fontFamily: "Inter",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                )),
                            SizedBox(
                              height: 4.0,
                            ),
                            Text(
                              "by @ameliadavies991",
                              style: TextStyle(
                                fontFamily: "Inter",
                                fontSize: 8,
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(
                              height: 4.0,
                            ),
                            Text("\$ 674.2",
                                style: TextStyle(
                                  fontFamily: "Inter",
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                )),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  const Text("Offers & Coupon Codes",
                      style: TextStyle(
                        fontFamily: "Inter",
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      )),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(8.0)),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                // Prefix icon for offer
                                Icon(
                                  Icons.local_offer,
                                  color: Colors.black,
                                  size: 16,
                                ), // Change the icon as needed
                                SizedBox(
                                    width:
                                        5), // Add some space between the icon and text
                                Text(
                                  "AUC250",
                                  style: TextStyle(
                                      fontFamily: "Inter",
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            Text(
                              "Apply",
                              style: TextStyle(
                                  fontFamily: "Inter",
                                  fontSize: 8,
                                  fontWeight: FontWeight.w500),
                              // textAlign: TextAlign.end,
                            ),
                          ],
                        ),
                        Text("Save 250 cents on your first order ",
                            style: TextStyle(
                                fontFamily: "Inter",
                                fontSize: 8,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey)),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("View more coupons",
                                style: TextStyle(
                                  fontFamily: "Inter",
                                  fontSize: 8,
                                  fontWeight: FontWeight.w500,
                                )),
                            Icon(
                              Icons.navigate_next_outlined,
                              size: 12,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text("Delivery Instructions",
                      style: TextStyle(
                        fontFamily: "Inter",
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      )),
                  const SizedBox(
                    height: 8,
                  ),
                  const SizedBox(
                    width: double.infinity,
                    height: 24,
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Add shipping or delivery instructions',
                        labelStyle: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 8,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text("Billing Details",
                      style: TextStyle(
                        fontFamily: "Inter",
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      )),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(8.0)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Item total",
                                style: TextStyle(
                                  fontFamily: "Inter",
                                  fontSize: 8,
                                  fontWeight: FontWeight.w500,
                                )),
                            Text("\$87.2",
                                style: TextStyle(
                                  fontFamily: "Inter",
                                  fontSize: 8,
                                  fontWeight: FontWeight.w500,
                                ))
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Delivery fee",
                                style: TextStyle(
                                  fontFamily: "Inter",
                                  fontSize: 8,
                                  fontWeight: FontWeight.w500,
                                )),
                            Text("\$5",
                                style: TextStyle(
                                  fontFamily: "Inter",
                                  fontSize: 8,
                                  fontWeight: FontWeight.w500,
                                ))
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Delivery tip",
                                style: TextStyle(
                                  fontFamily: "Inter",
                                  fontSize: 8,
                                  fontWeight: FontWeight.w500,
                                )),
                            GestureDetector(
                              child: const Text("Add tip",
                                  style: TextStyle(
                                    fontFamily: "Inter",
                                    fontSize: 8,
                                    fontWeight: FontWeight.w500,
                                  )),
                              onTap: () {},
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("GST & Platform Charges",
                                style: TextStyle(
                                  fontFamily: "Inter",
                                  fontSize: 8,
                                  fontWeight: FontWeight.w500,
                                )),
                            Text("\$22.9",
                                style: TextStyle(
                                  fontFamily: "Inter",
                                  fontSize: 8,
                                  fontWeight: FontWeight.w500,
                                ))
                          ],
                        ),
                        const Divider(),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("To pay",
                                style: TextStyle(
                                  fontFamily: "Inter",
                                  fontSize: 8,
                                  fontWeight: FontWeight.w500,
                                )),
                            Text("\$115.1",
                                style: TextStyle(
                                  fontFamily: "Inter",
                                  fontSize: 8,
                                  fontWeight: FontWeight.w500,
                                ))
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                      width: double.infinity,
                      height: 58.0,
                      decoration: BoxDecoration(
                        color: Colors.blue.shade200,
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                          color: Colors.blue, // Green border color
                          width: 1.5, // Border width
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 16),
                          ),
                          Icon(Icons
                              .info_outline_rounded), // Replace 'path_to_your_image' with the actual path to your image
                          Padding(
                            padding: EdgeInsets.only(left: 16),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(padding: EdgeInsets.only(top: 8)),
                              Text(
                                'Avoid cancellations by reviewing your order & address details \nthoroughly. If you cancel the order within 15 minutes of placing your \norder, 100% refund will be issued. No refund for cancellations \nmade after 15 minutes.',
                                style: TextStyle(
                                  fontFamily: "Inter",
                                  fontSize: 8,
                                  fontWeight: FontWeight.w500,
                                ),
                                // softWrap: true,
                              ),
                            ],
                          )
                        ],
                      )),
                ],
              ),
            )),
        Step(
            state: StepState.complete,
            isActive: _activeStepIndex >= 2,
            title: const Text('Confirm'),
            content: Container(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Payment'),
              ],
            )))
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Stepper'),
      ),
      body: Stepper(
        type: StepperType.horizontal,
        currentStep: _activeStepIndex,
        steps: stepList(),
        onStepContinue: () {
          if (_activeStepIndex < (stepList().length - 1)) {
            setState(() {
              _activeStepIndex += 1;
            });
          } else {
            print('Submited');
          }
        },
        onStepCancel: () {
          if (_activeStepIndex == 0) {
            return;
          }

          setState(() {
            _activeStepIndex -= 1;
          });
        },
        onStepTapped: (int index) {
          setState(() {
            _activeStepIndex = index;
          });
        },
      ),
    );
  }
}

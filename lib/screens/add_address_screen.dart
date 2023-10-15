import 'package:auctify/const/constants.dart';
import 'package:auctify/const/util_functions.dart';
import 'package:auctify/models/address_model.dart';
import 'package:auctify/screens/checkout_screen.dart';
import 'package:auctify/viewmodels/address_viewmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddAddressScreen extends StatefulWidget {
  @override
  _AddAddressScreenState createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _streetController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _stateController = TextEditingController();
  TextEditingController _postalCodeController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Address'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _phoneNumberController,
                  decoration: InputDecoration(
                    fillColor: secondaryAccentColor,
                    filled: true,
                    prefixIcon: const Icon(
                      Icons.email_rounded,
                      color: Colors.black,
                    ),
                    labelText: "Phone number",
                    hintText: "Enter your phone number",
                    prefix: const Text("+91 "),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1,
                          color: Colors.black.withOpacity(0.3)), //<-- SEE HERE
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1,
                          color: Colors.black.withOpacity(0.3)), //<-- SEE HERE
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter phone number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    fillColor: secondaryAccentColor,
                    filled: true,
                    prefixIcon: const Icon(
                      Icons.email_rounded,
                      color: Colors.black,
                    ),
                    labelText: "Name",
                    hintText: "Enter your addressee name",
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1,
                          color: Colors.black.withOpacity(0.3)), //<-- SEE HERE
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1,
                          color: Colors.black.withOpacity(0.3)), //<-- SEE HERE
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter addressee name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _streetController,
                  decoration: InputDecoration(
                    fillColor: secondaryAccentColor,
                    filled: true,
                    prefixIcon: const Icon(
                      Icons.email_rounded,
                      color: Colors.black,
                    ),
                    labelText: "Street Address",
                    hintText: "Enter your street name",
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1,
                          color: Colors.black.withOpacity(0.3)), //<-- SEE HERE
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1,
                          color: Colors.black.withOpacity(0.3)), //<-- SEE HERE
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter street address';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _cityController,
                  decoration: InputDecoration(
                    fillColor: secondaryAccentColor,
                    filled: true,
                    prefixIcon: const Icon(
                      Icons.email_rounded,
                      color: Colors.black,
                    ),
                    labelText: "City Name",
                    hintText: "Enter your city name",
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1,
                          color: Colors.black.withOpacity(0.3)), //<-- SEE HERE
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1,
                          color: Colors.black.withOpacity(0.3)), //<-- SEE HERE
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter city';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _stateController,
                  decoration: InputDecoration(
                    fillColor: secondaryAccentColor,
                    filled: true,
                    prefixIcon: const Icon(
                      Icons.email_rounded,
                      color: Colors.black,
                    ),
                    labelText: "State name",
                    hintText: "Enter your state name",
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1,
                          color: Colors.black.withOpacity(0.3)), //<-- SEE HERE
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1,
                          color: Colors.black.withOpacity(0.3)), //<-- SEE HERE
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter state';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _postalCodeController,
                  decoration: InputDecoration(
                    fillColor: secondaryAccentColor,
                    filled: true,
                    prefixIcon: const Icon(
                      Icons.email_rounded,
                      color: Colors.black,
                    ),
                    labelText: "Postal code",
                    hintText: "Enter your postal code",
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1,
                          color: Colors.black.withOpacity(0.3)), //<-- SEE HERE
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1,
                          color: Colors.black.withOpacity(0.3)), //<-- SEE HERE
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter postal code';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      String addressId = generateRandomId();
                      String userId = FirebaseAuth.instance.currentUser!.uid;
                      AddressModel model = AddressModel(
                        addressId: addressId,
                        userId: userId,
                        completeAddress: _streetController.text,
                        city: _cityController.text,
                        state: _stateController.text,
                        pincode: _postalCodeController.text,
                        name: _nameController.text,
                        phoneNumber: _phoneNumberController.text,
                      );
                      showDialog(
                          context: context,
                          builder: ((context) {
                            return AlertDialog(
                              title: Text('Adding address'),
                              content: Text('Please wait...'),
                            );
                          }));
                      String status =
                          await AddressViewModel().addAddress(model);
                      if (status == "success") {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      } else {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Error while adding address.'),
                        ));
                      }
                    }
                  },
                  child: Text('Submit Form'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

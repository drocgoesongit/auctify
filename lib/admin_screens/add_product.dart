import 'dart:developer';
import 'dart:io';

import 'package:auctify/const/lists.dart';
import 'package:auctify/models/product_model.dart';
import 'package:auctify/viewmodels/upload_product_viewmodel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddProductScreenAdmin extends StatefulWidget {
  const AddProductScreenAdmin({super.key});

  @override
  State<AddProductScreenAdmin> createState() => _AddProductScreenAdminState();
}

class _AddProductScreenAdminState extends State<AddProductScreenAdmin> {
  final _formKey = GlobalKey<FormState>();
  String productName = "";
  String uid = "";
  String description = "";
  String sellerName = "";
  String categories = "";
  List<File> images = [];
  int initialPrice = 0;
  int incrementPercentage = 0;
  String startTime = "";
  String endTime = "";
  String endDate = "";
  String startDate = "";
  String status = "start";

  String? amPm;

  String? _hour, _minute, _time;

  String? dateTime;

  DateTime selectedDate = DateTime.now();

  TimeOfDay selectedTime = const TimeOfDay(hour: 00, minute: 00);

  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _dateController.text = "${selectedDate.toString().substring(0, 10)}";
    _timeController.text = "${selectedTime.hour} : ${selectedTime.minute}";
  }

  Future<Null> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null) {
      setState(() {
        selectedDate = picked;
        _dateController.text =
            "${selectedDate.toString().substring(0, 10)}"; // Update the text in the TextFormField
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a date'),
        ),
      );
    }
  }

  Future<Null> _selectTime(BuildContext context) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null) {
      setState(() {
        selectedTime = picked;
        log("selected time is $selectedTime");
        _hour = selectedTime.hour.toString();
        _minute = selectedTime.minute.toString();
        amPm = selectedTime.period.toString();
        _time = _hour! + ' : ' + _minute! + " ";
        _timeController.text = _time!;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a time'),
        ),
      );
    }
  }

  // function for picking images
  Future<List<File>> pickMultipleImages(BuildContext context) async {
    List<File> selectedImages = [];

    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: true,
      );

      if (result != null) {
        List<File> files = result.paths.map((path) => File(path!)).toList();
        selectedImages.addAll(files);
      }
      log("image added as files in add product screen length is ${selectedImages.length}");
    } catch (e) {
      print('Error picking multiple images: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error picking multiple images'),
        ),
      );
    }

    return selectedImages;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Product"),
      ),
      body: SingleChildScrollView(
          child: Column(children: [
        Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
              child: Column(
                children: [
                  TextForms(
                      icon: const Icon(Icons.abc),
                      inputType: TextInputType.name,
                      label: "Product name",
                      hintText: "Name of your product",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your productName";
                        }
                        if (value == "") {
                          return 'Please enter a valid product name.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        productName = value!;
                      }),
                  TextForms(
                      icon: const Icon(Icons.abc),
                      inputType: TextInputType.name,
                      label: "Description",
                      hintText: "Enter product description",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your description";
                        }
                        if (value == "") {
                          return 'Please enter a valid product description.';
                        }
                        return null;
                      },
                      onSaved: (value) => description = value!),
                  TextForms(
                      icon: const Icon(Icons.currency_bitcoin),
                      label: "Initial price",
                      hintText: "Enter initial price",
                      inputType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your initial price";
                        }
                        if (value == "") {
                          return 'Please enter a valid initial price.';
                        }
                        return null;
                      },
                      onSaved: (value) => initialPrice = int.parse(value!)),
                  InkWell(
                    onTap: () {
                      _selectDate(context);
                    },
                    child: TextFormField(
                      controller: _dateController,
                      readOnly: true,
                      textCapitalization: TextCapitalization.words,
                      decoration: const InputDecoration(
                        enabled: false,
                        hintText: "Select end date",
                        labelText: "End date",
                        prefixIcon: Icon(Icons.date_range),
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your end date";
                        }
                        if (value == "") {
                          return 'Please enter a valid end date.';
                        }
                        return null;
                      },
                      onSaved: (value) => endDate = selectedDate.toString(),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      _selectTime(context);
                    },
                    child: TextFormField(
                      controller: _timeController,
                      readOnly: true,
                      textCapitalization: TextCapitalization.words,
                      decoration: const InputDecoration(
                        enabled: false,
                        hintText: "Select end time",
                        labelText: "End time",
                        prefixIcon: Icon(Icons.watch),
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your end time";
                        }
                        if (value == "") {
                          return 'Please enter a valid end time.';
                        }
                        return null;
                      },
                      onSaved: (value) => endTime = selectedTime.toString(),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 100,
                    child: ListView.builder(
                      itemCount: images.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Container(
                          child: Row(
                            children: [
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.file(
                                    images[index],
                                    fit: BoxFit.cover,
                                  )),
                              const SizedBox(width: 10),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                      width: double.infinity,
                      child: MaterialButton(
                          child: const Text("Add images"),
                          onPressed: () async {
                            List<File> selectedImages =
                                await pickMultipleImages(context);
                            setState(() {
                              images.addAll(selectedImages);
                            });
                          })),
                  const SizedBox(
                    height: 10,
                  ),
                  DropdownButtonFormField(
                    decoration: const InputDecoration(
                      hintText: "Select category",
                      prefixIcon: Icon(Icons.category),
                      border: OutlineInputBorder(),
                    ),
                    items: categoriesList,
                    onChanged: (value) {
                      setState(() {
                        categories =
                            value!; // Update the categories variable when a value is selected.
                      });
                    },
                    onSaved: (value) {
                      categories = value ??
                          ''; // Save the selected value when the form is saved.
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MaterialButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (images.length == 0) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please select images'),
                            ),
                          );
                        } else {
                          if (categories == "") {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please select category'),
                              ),
                            );
                          } else {
                            _formKey.currentState!.save();
                            uid = FirebaseAuth.instance.currentUser!.uid;
                            DateTime timeNow = DateTime.now();
                            startDate = timeNow.toString().substring(0, 11);
                            startTime = timeNow.toString().substring(11, 19);
                            List<String> categoriesList = [categories];

                            showDialog(
                                context: (context),
                                builder: (builder) {
                                  return AlertDialog(
                                    title: const Text("Confirm"),
                                    content: const Text(
                                        "Are you sure you want to upload this product?"),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text("No")),
                                      TextButton(
                                          onPressed: () {
                                            log("${startDate}, ${startTime}");
                                            log("${endTime.toString().substring(10, 15)}");
                                            Navigator.pop(context);
                                            UploadProductViewModel()
                                                .uploadProduct(
                                              context,
                                              ProductUploadModel(
                                                  name: productName,
                                                  id:
                                                      "${productName.substring(0, 7).replaceAll(" ", "")}${timeNow.toString().substring(0, 7).replaceAll(" ", "")}",
                                                  description: description,
                                                  imageList: [],
                                                  categories: categoriesList,
                                                  sellerId: uid,
                                                  status: status,
                                                  endDate:
                                                      endDate.substring(0, 11),
                                                  endTime:
                                                      endTime.substring(10, 15),
                                                  startDate: startDate,
                                                  startTime: startTime,
                                                  startPrice: initialPrice,
                                                  currentPrice: initialPrice,
                                                  buyNowPrice: initialPrice * 2,
                                                  increment: 20),
                                              images,
                                            );
                                          },
                                          child: const Text("Yes")),
                                    ],
                                  );
                                });
                            log(productName);
                            log(description);
                            log(initialPrice.toString());
                          }
                        }
                      }
                    },
                    child: const Text("Upload product"),
                  )
                ],
              ),
            ))
      ])),
    );
  }
}

class TextForms extends StatefulWidget {
  const TextForms(
      {super.key,
      required this.icon,
      required this.inputType,
      required this.label,
      required this.hintText,
      required this.validator,
      required this.onSaved});
  final Icon icon;
  final TextInputType inputType;
  final String label;
  final String hintText;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;

  @override
  State<TextForms> createState() => _TextFormsState();
}

class _TextFormsState extends State<TextForms> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          keyboardType: widget.inputType,
          decoration: InputDecoration(
              prefixIcon: widget.icon,
              labelText: widget.label,
              hintText: widget.hintText,
              border: const OutlineInputBorder()),
          validator: widget.validator,
          onSaved: widget.onSaved,
        ),
        const SizedBox(
          height: 10.0,
        ),
      ],
    );
  }
}

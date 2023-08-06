import 'dart:developer';
import 'dart:io';
import 'dart:isolate';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../models/product_model.dart';

class UploadProductViewModel {
  Future<bool> uploadProduct(BuildContext context,
      ProductUploadModel productUploadModel, List<File> images) async {
    try {
      showDialog(
          context: context,
          builder: (builder) => const CircularProgressIndicator());
      List<String> imageUrls = await _uploadImagesToStorage(
          images, productUploadModel.name, productUploadModel.id);
      log("casting all the values in image list: ${imageUrls.length}");
      productUploadModel.imageList = imageUrls;
      log("got this much images: " + imageUrls.length.toString());

      await FirebaseFirestore.instance
          .collection('products')
          .doc(productUploadModel.id)
          .set(productUploadModel.toMap());
      Navigator.pop(context);
      return true;
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
      Navigator.pop(context);
      return false;
    }
  }
}

// Helper function to upload images to Firebase Storage and get their URLs
Future<List<String>> _uploadImagesToStorage(
    List<File> imageList, String productName, String id) async {
  List<String> imageUrls = [];
  log("started uploading images.");
  log("received number of images file: [${imageList.length}]]");
  int index = 0;
  try {
    for (File imagePath in imageList) {
      Reference ref =
          FirebaseStorage.instance.ref().child('product_images/$id/$index');
      UploadTask uploadTask = ref.putFile(imagePath);
      TaskSnapshot storageSnapshot = await uploadTask.whenComplete(() => null);
      String downloadUrl = await storageSnapshot.ref.getDownloadURL();
      log("got image url: $downloadUrl");
      imageUrls.add(downloadUrl);
      index++;
    }
  } catch (e) {
    log("error uploading images: ${e.toString()}");
  }
  log("finished uploading images.");
  log("image urls: ${imageUrls.length}");
  return imageUrls;
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class ProductUploadModel {
  String name;
  String id;
  String description;
  List<String> imageList;
  List<String> categories;
  String sellerId;
  String status;
  String endDate;
  String endTime;
  String startDate;
  String startTime;
  int startPrice;
  int currentPrice;
  int buyNowPrice;
  int increment;
  ProductUploadModel({
    required this.id,
    required this.name,
    required this.description,
    required this.imageList,
    required this.categories,
    required this.sellerId,
    required this.status,
    required this.endDate,
    required this.endTime,
    required this.startDate,
    required this.startTime,
    required this.startPrice,
    required this.currentPrice,
    required this.buyNowPrice,
    required this.increment,
  });

  ProductUploadModel copyWith({
    String? name,
    String? description,
    List<String>? imageList,
    List<String>? categories,
    String? sellerId,
    String? status,
    String? endDate,
    String? endTime,
    String? startDate,
    String? startTime,
    int? startPrice,
    int? currentPrice,
    int? buyNowPrice,
    int? increment,
    String? id,
  }) {
    return ProductUploadModel(
      name: name ?? this.name,
      id: id ?? this.id,
      description: description ?? this.description,
      imageList: imageList ?? this.imageList,
      categories: categories ?? this.categories,
      sellerId: sellerId ?? this.sellerId,
      status: status ?? this.status,
      endDate: endDate ?? this.endDate,
      endTime: endTime ?? this.endTime,
      startDate: startDate ?? this.startDate,
      startTime: startTime ?? this.startTime,
      startPrice: startPrice ?? this.startPrice,
      currentPrice: currentPrice ?? this.currentPrice,
      buyNowPrice: buyNowPrice ?? this.buyNowPrice,
      increment: increment ?? this.increment,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'description': description,
      'imageList': imageList,
      'categories': categories,
      'sellerId': sellerId,
      'status': status,
      'endDate': endDate,
      'endTime': endTime,
      'startDate': startDate,
      'startTime': startTime,
      'startPrice': startPrice,
      'currentPrice': currentPrice,
      'buyNowPrice': buyNowPrice,
      'increment': increment,
    };
  }

  factory ProductUploadModel.fromMap(Map<String, dynamic> map) {
    return ProductUploadModel(
      name: map['name'] as String,
      id: map['id'] as String,
      description: map['description'] as String,
      imageList: List<String>.from((map['imageList'] as List<dynamic>)),
      categories: List<String>.from((map['categories'] as List<dynamic>)),
      sellerId: map['sellerId'] as String,
      status: map['status'] as String,
      endDate: map['endDate'] as String,
      endTime: map['endTime'] as String,
      startDate: map['startDate'] as String,
      startTime: map['startTime'] as String,
      startPrice: map['startPrice'] as int,
      currentPrice: map['currentPrice'] as int,
      buyNowPrice: map['buyNowPrice'] as int,
      increment: map['increment'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductUploadModel.fromJson(String source) =>
      ProductUploadModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProductUploadModel(name: $name, description: $description, imageList: $imageList, categories: $categories, sellerId: $sellerId, status: $status, endDate: $endDate, endTime: $endTime, startDate: $startDate, startTime: $startTime, startPrice: $startPrice, currentPrice: $currentPrice, buyNowPrice: $buyNowPrice, increment: $increment)';
  }

  @override
  bool operator ==(covariant ProductUploadModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.description == description &&
        listEquals(other.imageList, imageList) &&
        listEquals(other.categories, categories) &&
        other.sellerId == sellerId &&
        other.status == status &&
        other.endDate == endDate &&
        other.endTime == endTime &&
        other.startDate == startDate &&
        other.startTime == startTime &&
        other.startPrice == startPrice &&
        other.currentPrice == currentPrice &&
        other.buyNowPrice == buyNowPrice &&
        other.increment == increment;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        description.hashCode ^
        imageList.hashCode ^
        categories.hashCode ^
        sellerId.hashCode ^
        status.hashCode ^
        endDate.hashCode ^
        endTime.hashCode ^
        startDate.hashCode ^
        startTime.hashCode ^
        startPrice.hashCode ^
        currentPrice.hashCode ^
        buyNowPrice.hashCode ^
        increment.hashCode;
  }
}

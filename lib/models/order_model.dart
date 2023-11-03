class OrderModel {
  final String id;
  final String productId;
  final String timeCreated;
  final String status;
  final String address;
  final String userId;
  final int amount;
  final bool paid;
  final String expectedDelivery;

  OrderModel({
    required this.id,
    required this.productId,
    required this.timeCreated,
    required this.status,
    required this.address,
    required this.userId,
    required this.amount,
    required this.paid,
    required this.expectedDelivery,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      productId: json['productId'],
      timeCreated: json['timeCreated'],
      status: json['status'],
      address: json['address'],
      userId: json['userId'],
      amount: json['amount'],
      paid: json['paid'],
      expectedDelivery: json['expectedDelivery'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'productId': productId,
        'timeCreated': timeCreated,
        'status': status,
        'address': address,
        'userId': userId,
        'amount': amount,
        'paid': paid,
        'expectedDelivery': expectedDelivery,
      };
}

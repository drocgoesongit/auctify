class BidModel {
  final String bidId;
  final String bidderId;
  final String productId;
  final String timeStamp;
  final String bidAmount;
  final String bidStatus;

  BidModel({
    required this.bidId,
    required this.bidderId,
    required this.productId,
    required this.timeStamp,
    required this.bidAmount,
    required this.bidStatus,
  });

  factory BidModel.fromJson(Map<String, dynamic> json) {
    return BidModel(
      bidId: json['bidId'],
      bidderId: json['bidderId'],
      productId: json['productId'],
      timeStamp: json['timeStamp'],
      bidAmount: json['bidAmount'],
      bidStatus: json['bidStatus'],
    );
  }

  Map<String, dynamic> toJson() => {
        'bidId': bidId,
        'bidderId': bidderId,
        'productId': productId,
        'timeStamp': timeStamp,
        'bidAmount': bidAmount,
        'bidStatus': bidStatus,
      };
}

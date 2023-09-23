class NotificationModel {
  final String notificationId;
  final String portalId;
  final String productId;
  final String senderId;
  final int lastSentTime;
  final String notificationStatus;
  final int count;

  NotificationModel({
    required this.notificationId,
    required this.portalId,
    required this.productId,
    required this.senderId,
    required this.notificationStatus,
    required this.count,
    required this.lastSentTime,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      notificationId: json['notificationId'],
      portalId: json['portalId'],
      productId: json['productId'],
      senderId: json['senderId'],
      notificationStatus: json['notificationStatus'],
      count: json['count'],
      lastSentTime: json['lastSentTime'],
    );
  }

  Map<String, dynamic> toJson() => {
        'notificationId': notificationId,
        'portalId': portalId,
        'productId': productId,
        'senderId': senderId,
        'notificationStatus': notificationStatus,
        'count': count,
        'lastSentTime': lastSentTime,
      };
}

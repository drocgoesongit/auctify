class Portal {
  final String portalId;
  final String productId;
  final int startTime; // start time for current iteration.
  final int endTime; // end time for current iteration.
  final String portalStatus; // started, success, failed.
  final String portalWinner; // first winner
  final int portalWinnerBidAmount;
  final String portalCurrentWinner; // current iteration bidder.
  final int portalCurrentWinnerBidAmount;
  final int iterationCount; // How many time this portal has ran.
  final String notificationId; // changes to the current portal winner.
  final int totalNumberOfBidders;

  Portal({
    required this.portalId,
    required this.productId,
    required this.startTime,
    required this.endTime,
    required this.portalStatus,
    required this.portalWinner,
    required this.portalWinnerBidAmount,
    required this.portalCurrentWinner,
    required this.portalCurrentWinnerBidAmount,
    required this.iterationCount,
    required this.notificationId,
    required this.totalNumberOfBidders,
  });

  factory Portal.fromJson(Map<String, dynamic> json) {
    return Portal(
      portalId: json['portalId'],
      productId: json['productId'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      portalStatus: json['portalStatus'],
      portalWinner: json['portalWinner'],
      portalWinnerBidAmount: json['portalWinnerBidAmount'],
      portalCurrentWinner: json['portalCurrentWinner'],
      portalCurrentWinnerBidAmount: json['portalCurrentWinnerBidAmount'],
      iterationCount: json['iterationCount'],
      notificationId: json['notificationId'],
      totalNumberOfBidders: json['totalNumberOfBidders'],
    );
  }

  Map<String, dynamic> toJson() => {
        'portalId': portalId,
        'productId': productId,
        'startTime': startTime,
        'endTime': endTime,
        'portalStatus': portalStatus,
        'portalWinner': portalWinner,
        'portalWinnerBidAmount': portalWinnerBidAmount,
        'portalCurrentWinner': portalCurrentWinner,
        'portalCurrentWinnerBidAmount': portalCurrentWinnerBidAmount,
        'iterationCount': iterationCount,
        'notificationId': notificationId,
        'totalNumberOfBidders': totalNumberOfBidders,
      };
}

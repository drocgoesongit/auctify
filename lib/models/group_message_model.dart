class GroupMessageModel {
  final String id;
  final String senderId;
  final String senderName;
  final String senderImage;
  final int timeStamp;
  final String content;
  final int type;

  GroupMessageModel({
    required this.id,
    required this.senderId,
    required this.senderName,
    required this.senderImage,
    required this.timeStamp,
    required this.content,
    required this.type,
  });

  GroupMessageModel copyWith({
    String? id,
    String? senderId,
    String? senderName,
    String? senderImage,
    int? timeStamp,
    String? content,
    int? type,
  }) {
    return GroupMessageModel(
      id: id ?? this.id,
      senderId: senderId ?? this.senderId,
      senderName: senderName ?? this.senderName,
      senderImage: senderImage ?? this.senderImage,
      timeStamp: timeStamp ?? this.timeStamp,
      content: content ?? this.content,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'senderId': senderId,
      'senderName': senderName,
      'senderImage': senderImage,
      'timeStamp': timeStamp,
      'content': content,
      'type': type,
    };
  }

  factory GroupMessageModel.fromMap(Map<String, dynamic> map) {
    return GroupMessageModel(
      id: map['id'],
      senderId: map['senderId'],
      senderName: map['senderName'],
      senderImage: map['senderImage'],
      timeStamp: map['timeStamp'],
      content: map['content'],
      type: map['type'],
    );
  }
}

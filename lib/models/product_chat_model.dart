class ProductChatModel {
  String chatId;
  String lastMessage;
  String lastId;
  String lastTime;

  ProductChatModel({
    required this.chatId,
    required this.lastMessage,
    required this.lastId,
    required this.lastTime,
  });

  ProductChatModel copyWith({
    String? chatId,
    String? productId,
    String? lastMessage,
    String? lastId,
    String? lastTime,
  }) {
    return ProductChatModel(
      chatId: chatId ?? this.chatId,
      lastMessage: lastMessage ?? this.lastMessage,
      lastId: lastId ?? this.lastId,
      lastTime: lastTime ?? this.lastTime,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'chatId': chatId,
      'lastMessage': lastMessage,
      'lastId': lastId,
      'lastTime': lastTime,
    };
  }

  factory ProductChatModel.fromMap(Map<String, dynamic> map) {
    return ProductChatModel(
      chatId: map['chatId'],
      lastMessage: map['lastMessage'],
      lastId: map['lastId'],
      lastTime: map['lastTime'],
    );
  }
}

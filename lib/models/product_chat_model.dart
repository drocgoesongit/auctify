class ProductChatModel {
  String chatId;
  String productId;
  String lastMessage;
  String lastId;
  String lastTime;

  ProductChatModel({
    required this.chatId,
    required this.productId,
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
      productId: productId ?? this.productId,
      lastMessage: lastMessage ?? this.lastMessage,
      lastId: lastId ?? this.lastId,
      lastTime: lastTime ?? this.lastTime,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'chatId': chatId,
      'productId': productId,
      'lastMessage': lastMessage,
      'lastId': lastId,
      'lastTime': lastTime,
    };
  }

  factory ProductChatModel.fromMap(Map<String, dynamic> map) {
    return ProductChatModel(
      chatId: map['chatId'],
      productId: map['productId'],
      lastMessage: map['lastMessage'],
      lastId: map['lastId'],
      lastTime: map['lastTime'],
    );
  }
}

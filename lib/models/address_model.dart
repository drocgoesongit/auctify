class AddressModel {
  final String addressId;
  final String userId;
  final String name;
  final String phoneNumber;
  final String completeAddress;
  final String pincode;
  final String city;
  final String state;

  AddressModel({
    required this.addressId,
    required this.userId,
    required this.name,
    required this.phoneNumber,
    required this.completeAddress,
    required this.pincode,
    required this.city,
    required this.state,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      addressId: json['addressId'],
      userId: json['userId'],
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      completeAddress: json['completeAddress'],
      pincode: json['pincode'],
      city: json['city'],
      state: json['state'],
    );
  }

  Map<String, dynamic> toJson() => {
        'addressId': addressId,
        'userId': userId,
        'name': name,
        'phoneNumber': phoneNumber,
        'completeAddress': completeAddress,
        'pincode': pincode,
        'city': city,
        'state': state,
      };
}

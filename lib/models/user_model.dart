class User {
  final String name;
  final String address;
  User({required this.address, required this.name});

  factory User.fromMap(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      address: json['address'],
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'address': address,
      };
}

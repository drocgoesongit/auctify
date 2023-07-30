class UserLoginModel {
  final String email;
  final String firstName;
  final String lastName;
  final String registerTime;
  final String uid;

  UserLoginModel({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.registerTime,
    required this.uid,
  });

  factory UserLoginModel.fromMap(Map<String, dynamic> map) {
    return UserLoginModel(
      email: map['email'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      registerTime: map['registerTime'],
      uid: map['uid'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'registerTime': registerTime,
      'uid': uid,
    };
  }
}

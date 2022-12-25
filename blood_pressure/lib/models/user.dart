import 'dart:convert';

class User {
  final String id;
  final String username;
  final String email;
  final String password;
  final String address;
  final String phonenumber;
  final String token;
  final String birthday;
  final String gender;
  User({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.address,
    required this.phonenumber,
    required this.token,
    required this.birthday,
    required this.gender,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'password': password,
      'address': address,
      'phonenumber': phonenumber,
      'birthday': birthday,
      'token': token,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] ?? '',
      username: map['username'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      address: map['address'] ?? '',
      phonenumber: map['phonenumber'] ?? '',
      birthday: map['birthday'] ?? '',
      gender: map['gender'] ?? '',
      token: map['token'] ?? '',
    );
  }
  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}

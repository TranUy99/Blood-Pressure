import 'dart:convert';

class doctor {
  String? doctorName;
  String? email;
  String? password;
  String? address;
  String? phonenumber;
  String? gender;
  String? doctorId;

  doctor({
    required this.doctorName,
    required this.email,
    required this.password,
    required this.address,
    required this.phonenumber,
    required this.gender,
    required this.doctorId,
  });
  Map<String, dynamic> toMap() {
    return {
      'doctorName': doctorName,
      'email': email,
      'password': password,
      'address': address,
      'phonenumber': phonenumber,
      'gender': gender,
      'doctorId': doctorId,
    };
  }

  doctor.fromJson(Map<String, dynamic> json) {
    if (json["doctorName"] is String) {
      doctorName = json["doctorName"];
    }
    if (json["email"] is String) {
      email = json["email"];
    }
    if (json["password"] is String) {
      password = json["password"];
    }
    if (json["address"] is String) {
      address = json["address"];
    }
    if (json["phonenumber"] is String) {
      phonenumber = json["phonenumber"];
    }
    if (json["gender"] is String) {
      gender = json["gender"];
    }
    if (json["_id"] is String) {
      doctorId = json["_id"];
    }
  }

  String toJson() => json.encode(toMap());
}

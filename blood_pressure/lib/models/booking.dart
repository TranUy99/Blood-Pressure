import 'dart:convert';

class Booking {
  String doctorId;
  String timeType;
  String date;
  bool isAvailable;

  Booking({
    required this.doctorId,
    required this.timeType,
    required this.date,
    required this.isAvailable,
  });
  Map<String, dynamic> toMap() {
    return {
      'doctorId': doctorId,
      'timeType': timeType,
      'date': date,
      'isAvailable': isAvailable,
    };
  }

  factory Booking.fromMap(Map<String, dynamic> map) {
    return Booking(
      doctorId: map['doctorId'] ?? '',
      timeType: map['timeType'] ?? '',
      date: map['date'] ?? '',
      isAvailable: map['isAvailable'] ?? '',
    );
  }
  String toJson() => json.encode(toMap());

  factory Booking.fromJson(String source) =>
      Booking.fromMap(json.decode(source));
}

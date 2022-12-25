import 'dart:convert';
import 'dart:ffi';

class Schedule {
  String? timeType;
  String? date;
  bool? isAvailable;
  String? doctorId;
  Schedule({
    required this.timeType,
    required this.date,
    required this.isAvailable,
    required this.doctorId,
  });
  Map<String, dynamic> toMap() {
    return {
      'timeType': timeType,
      'date': date,
      'isAvailable': isAvailable,
      'doctorId': doctorId,
    };
  }

  Schedule.fromJson(Map<String, dynamic> json) {
    if (json["timeType"] is String) {
      timeType = json["timeType"];
    }
    if (json["date"] is String) {
      date = json["date"];
    }
    if (json["isAvailable"] is String) {
      isAvailable = json["isAvailable"];
    }
    if (json["doctorId"] is String) {
      doctorId = json["doctorId"];
    }
  }

  String toJson() => json.encode(toMap());
}

import 'dart:convert';

class ChartData {
  int? sys;
  int? dia;
  int? pulse;
  String? date;
  String? userId;

  ChartData({
    required this.sys,
    required this.dia,
    required this.pulse,
    required this.date,
    required this.userId,
  });
  ChartData.fromJson(Map<String, dynamic> json) {
    if (json["sys"] is int) {
      sys = json["sys"];
    }
    if (json["dia"] is int) {
      dia = json["dia"];
    }
    if (json["pulse"] is int) {
      pulse = json["pulse"];
    }
    if (json["date"] is String) {
      date = json["date"];
    }
    if (json["userId"] is String) {
      userId = json["userId"];
    }
  }
  Map<String, dynamic> toJon() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["sys"] = sys;
    data["dia"] = dia;
    data["pulse"] = pulse;
    data["date"] = date;
    data["userId"] = userId;
    return data;
  }
}

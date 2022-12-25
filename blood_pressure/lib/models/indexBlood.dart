import 'dart:convert';

class IndexBlood {
  double sys;
  double dia;
  double pulse;

  IndexBlood({
    required this.sys,
    required this.dia,
    required this.pulse,
    
  });
  Map<String, dynamic> toMap() {
    return {
      'sys': sys,
      'dia': dia,
      'pulse': pulse,
      
    };
  }

  factory IndexBlood.fromMap(Map<String, dynamic> map) {
    return IndexBlood(
      sys: map['sys'] ?? '',
      dia: map['dia'] ?? '',
      pulse: map['pulse'] ?? '',
      
    );
  }
  String toJson() => json.encode(toMap());

  factory IndexBlood.fromJson(String source) =>
      IndexBlood.fromMap(json.decode(source));
}

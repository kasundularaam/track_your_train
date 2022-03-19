import 'dart:convert';

class Station {
  final String value;
  final String name;
  Station({
    required this.value,
    required this.name,
  });

  Station copyWith({
    String? value,
    String? name,
  }) {
    return Station(
      value: value ?? this.value,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'value': value,
      'name': name,
    };
  }

  factory Station.fromMap(Map<String, dynamic> map) {
    return Station(
      value: map['value'] ?? '',
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Station.fromJson(String source) =>
      Station.fromMap(json.decode(source));

  @override
  String toString() => 'Station(value: $value, name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Station && other.value == value && other.name == name;
  }

  @override
  int get hashCode => value.hashCode ^ name.hashCode;
}

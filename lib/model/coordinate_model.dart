import 'dart:convert';

class Coordinate {
  final double x;
  final double y;
  final double z;
  Coordinate({
    required this.x,
    required this.y,
    required this.z,
  });

  Coordinate copyWith({
    double? x,
    double? y,
    double? z,
  }) {
    return Coordinate(
      x: x ?? this.x,
      y: y ?? this.y,
      z: z ?? this.z,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'x': x,
      'y': y,
      'z': z,
    };
  }

  factory Coordinate.fromMap(Map<String, dynamic> map) {
    return Coordinate(
      x: map['x']?.toDouble() ?? 0.0,
      y: map['y']?.toDouble() ?? 0.0,
      z: map['z']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Coordinate.fromJson(String source) => Coordinate.fromMap(json.decode(source));

  @override
  String toString() => 'Coordinate(x: $x, y: $y, z: $z)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Coordinate &&
      other.x == x &&
      other.y == y &&
      other.z == z;
  }

  @override
  int get hashCode => x.hashCode ^ y.hashCode ^ z.hashCode;
}

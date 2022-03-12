class RouteException implements Exception {
  final String message;

  const RouteException(this.message);
}

class Failure {
  final String message;
  Failure({
    required this.message,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Failure && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;

  @override
  String toString() => message;
}

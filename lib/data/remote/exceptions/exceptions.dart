class InternalServerException implements Exception {
  @override
  String toString() {
    return 'InternalServerException';
  }

  String get message => 'Something went wrong. Please try again';
}

class ApiException implements Exception {
  final String message;
  final int code;

  ApiException(this.message, this.code);

  @override
  String toString() {
    return 'AppException: ($code), $message';
  }
}

class CustomException implements Exception {
  final _message;
  final _prefix;

  CustomException([this._message, this._prefix]);

  String toString() {
    return '$_prefix$_message';
  }
}

class FetchDataException extends CustomException {
  FetchDataException([String? message])
      : super(message!, 'Error During communication with server: ');
}

class BadRequestException extends CustomException {
  BadRequestException([String? message]) : super(message!, 'Invalid Request: ');
}

class UnauthorizedException extends CustomException {
  UnauthorizedException([String? message]) : super(message!, 'Unauthorized: ');
}

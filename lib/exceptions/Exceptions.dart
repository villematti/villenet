class CompletedException implements Exception {}

class BaseException implements Exception {
  final String message;
  BaseException({this.message});

  String toString() {
    return message == null ? "Something failes!" : "Error: ${message}";
  }
}

class PushException extends BaseException {
  final String message;
  PushException({this.message}) : super(message: message);
}

class AddException extends BaseException {
  final String message;
  AddException({this.message}) : super(message: message);
}

class UnknownMethodException extends BaseException {
  static final String msg = "Unknown method found! Can't continue!";
  UnknownMethodException() : super(message: msg);
}

class MulException extends BaseException {
  final String message;
  MulException({this.message}) : super(message: message);
}

class DivException extends BaseException {
  final String message;
  DivException({this.message}) : super(message: message);
}

class SubException extends BaseException {
  final String message;
  SubException({this.message}) : super(message: message);
}

class MissingValueException extends BaseException {
  static const String msg =
      "There has to be two values to make this calculation.";
  MissingValueException() : super(message: msg);
}

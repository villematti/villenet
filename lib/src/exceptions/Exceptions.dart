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
  static const String msg = "Missing values in stack.";
  MissingValueException() : super(message: msg);
}

class MissingConditionCheckException extends BaseException {
  final String message;
  MissingConditionCheckException({this.message}) : super(message: message);
}

class NoDestinationException extends BaseException {
  static const String msg = "Missing jump destination!";
  NoDestinationException() : super(message: msg);
}

class InvalidDestinationException extends BaseException {
  static const String msg = "Jump destination is out of range!";
  InvalidDestinationException() : super(message: msg);
}

class FalseDestinationException extends BaseException {
  static const String msg = "Unable to jump to given position.";
  FalseDestinationException() : super(message: msg);
}

class IncorrectValueException extends BaseException {
  final String message;
  IncorrectValueException({this.message}) : super(message: message);
}

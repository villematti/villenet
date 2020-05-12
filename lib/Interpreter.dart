import 'Operation.dart';
import 'State.dart';
import 'exceptions/Exceptions.dart';
import 'package:meta/meta.dart';

class Interpreter {
  State state = State();
  String errorMessage;

  Interpreter();

  runCode(List<dynamic> code) {
    this.state.code = code;

    while (this.state.programCunter < this.state.code.length) {
      final opCode = state.code[state.programCunter];

      try {
        switch (opCode) {
          case Operation.STOP:
            throw new CompletedException();
          case Operation.PUSH_INT:
            this._onPush();
            break;
          case Operation.ADD:
            this._onAdd();
            break;
          case Operation.MUL:
            this._onMul();
            break;
          case Operation.DIV:
            this._onDiv();
            break;
          case Operation.SUB:
            this._onSub();
            break;
          case Operation.LT:
            this._onLt();
            break;
          case Operation.GT:
            this._onGt();
            break;
          default:
            throw UnknownMethodException();
        }
      } on CompletedException {
        return state.stack.length == 0 ? 0 : state.stack.removeLast();
      } on PushException {
        throw PushException(message: errorMessage);
      } on UnknownMethodException {
        throw UnknownMethodException();
      } on DivException {
        throw DivException(message: errorMessage);
      } on MissingValueException {
        throw MissingValueException();
      }

      state.programCunter++;
    }
  }

  void _onGt() {
    try {
      final val =
          _getFromStack(this.state.stack) > _getFromStack(this.state.stack)
              ? 1
              : 0;
      this.state.stack.add(val);
    } on RangeError {
      throw MissingValueException();
    }
  }

  void _onLt() {
    try {
      final val =
          _getFromStack(this.state.stack) < _getFromStack(this.state.stack)
              ? 1
              : 0;
      this.state.stack.add(val);
    } on RangeError {
      throw MissingValueException();
    }
  }

  void _onSub() {
    try {
      num val1 = _getFromStack(this.state.stack);
      num val2 = _getFromStack(this.state.stack);
      this.state.stack.add(val1 - val2);
    } on RangeError {
      throw MissingValueException();
    }
  }

  void _onDiv() {
    try {
      num val1 = _getFromStack(this.state.stack);
      num val2 = _getFromStack(this.state.stack);
      if (val1 == 0 || val2 == 0) {
        errorMessage = "Can't do division with zero!";
        throw DivException();
      }
      this.state.stack.add(val1 / val2);
    } on RangeError {
      throw MissingValueException();
    }
  }

  num _getFromStack(List<num> stateStack) {
    try {
      return stateStack.removeLast();
    } on RangeError {
      throw RangeError("");
    }
  }

  void _onMul() {
    try {
      num sum = _getFromStack(this.state.stack);
      sum *= _getFromStack(this.state.stack);
      this.state.stack.add(sum);
    } on RangeError {
      throw MissingValueException();
    }
  }

  void _onPush() {
    state.programCunter++;
    try {
      final int value = state.code[state.programCunter];
      state.stack.add(value);
    } on TypeError {
      errorMessage = "PUSH_INT value need to be an integer!";
      throw PushException();
    }
  }

  void _onAdd() {
    try {
      num sum = 0;
      for (var x = 0; x < 2; x++) {
        sum += _getFromStack(this.state.stack);
      }
      this.state.stack.add(sum);
    } on RangeError {
      throw MissingValueException();
    }
  }
}

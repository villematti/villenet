import 'Operation.dart';
import 'State.dart';
import 'exceptions/Exceptions.dart';

class Interpreter {
  StateImpl state = StateImpl();
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
          case Operation.EQ:
            this._onEq();
            break;
          case Operation.AND:
            this._onAnd();
            break;
          case Operation.OR:
            this._onOr();
            break;
          case Operation.JUMP:
            this._onJump();
            break;
          case Operation.JUMP_S:
            this._onJumpS();
            break;
          case Operation.JUMP_I:
            this._onJumpI();
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
      } on InvalidDestinationException {
        throw InvalidDestinationException();
      } on IncorrectValueException {
        throw IncorrectValueException();
      }

      state.programCunter++;
    }
  }

  void _onJumpI() {
    try {
      int jumpCondition = _getNumFromStack(this.state.stack);
      if (jumpCondition == 0 || jumpCondition == 1) {
        state.programCunter++;
        final jumpTarget = state.code[state.programCunter];
        if (jumpTarget is! int) {
          throw InvalidDestinationException();
        } else if (state.code[state.programCunter + jumpTarget] is! String) {
          throw FalseDestinationException();
        }

        if (jumpCondition == 1) {
          state.programCunter += jumpTarget - 1;
        }
      } else {
        throw IncorrectValueException();
      }
    } on RangeError {
      throw MissingValueException();
    }
  }

  void _onJumpS() {
    try {
      num val = _getNumFromStack(this.state.stack);
      int jumpTarget = state.programCunter + val;
      if (jumpTarget > state.code.length - 1 || jumpTarget < 0) {
        throw InvalidDestinationException();
      }
      if (state.code[jumpTarget] is! String) {
        throw FalseDestinationException();
      }

      state.programCunter = jumpTarget - 1;
    } on RangeError {
      throw MissingValueException();
    }
  }

  void _onJump() {
    state.programCunter++;
    final val = state.code[state.programCunter];
    if (val is int) {
      if ((state.programCunter + val) > state.code.length - 1) {
        throw InvalidDestinationException();
      } else {
        state.programCunter += val;
        if (state.code[state.programCunter] is! String) {
          throw FalseDestinationException();
        }
        state.programCunter--;
      }
    } else {
      throw NoDestinationException();
    }
  }

  void _checkConditionCheckingFormat(List<dynamic> code) {
    const validCommands = [Operation.EQ, Operation.GT, Operation.LT];
    if (code.length < 7) {
      throw MissingConditionCheckException();
    }
    final lastCommand = code[state.programCunter - 1];
    final previousCommand = code[state.programCunter - 6];

    if (lastCommand is String && previousCommand is String) {
      if (validCommands.indexOf(lastCommand) == -1 &&
          validCommands.indexOf(previousCommand) == -1) {
        throw MissingConditionCheckException();
      }
    } else {
      throw MissingConditionCheckException();
    }
  }

  void _onAnd() {
    _checkConditionCheckingFormat(state.code);
    if (_getNumFromStack(this.state.stack) == 1 &&
        _getNumFromStack(this.state.stack) == 1) {
      this.state.stack.add(1);
    } else {
      this.state.stack.add(0);
    }
  }

  void _onOr() {
    _checkConditionCheckingFormat(state.code);
    if (_getNumFromStack(this.state.stack) == 1 ||
        _getNumFromStack(this.state.stack) == 1) {
      this.state.stack.add(1);
    } else {
      this.state.stack.add(0);
    }
  }

  void _onEq() {
    try {
      final val = _getNumFromStack(this.state.stack) ==
              _getNumFromStack(this.state.stack)
          ? 1
          : 0;
      this.state.stack.add(val);
    } on RangeError {
      throw MissingValueException();
    }
  }

  void _onGt() {
    try {
      final val = _getNumFromStack(this.state.stack) >
              _getNumFromStack(this.state.stack)
          ? 1
          : 0;
      this.state.stack.add(val);
    } on RangeError {
      throw MissingValueException();
    }
  }

  void _onLt() {
    try {
      final val = _getNumFromStack(this.state.stack) <
              _getNumFromStack(this.state.stack)
          ? 1
          : 0;
      this.state.stack.add(val);
    } on RangeError {
      throw MissingValueException();
    }
  }

  void _onSub() {
    try {
      num val1 = _getNumFromStack(this.state.stack);
      num val2 = _getNumFromStack(this.state.stack);
      this.state.stack.add(val1 - val2);
    } on RangeError {
      throw MissingValueException();
    }
  }

  void _onDiv() {
    try {
      num val1 = _getNumFromStack(this.state.stack);
      num val2 = _getNumFromStack(this.state.stack);
      if (val1 == 0 || val2 == 0) {
        errorMessage = "Can't do division with zero!";
        throw DivException();
      }
      this.state.stack.add(val1 / val2);
    } on RangeError {
      throw MissingValueException();
    }
  }

  num _getNumFromStack(List<num> stateStack) {
    try {
      return stateStack.removeLast();
    } on RangeError {
      throw RangeError("");
    }
  }

  void _onMul() {
    try {
      num sum = _getNumFromStack(this.state.stack);
      sum *= _getNumFromStack(this.state.stack);
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
        sum += _getNumFromStack(this.state.stack);
      }
      this.state.stack.add(sum);
    } on RangeError {
      throw MissingValueException();
    }
  }
}

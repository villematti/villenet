import 'package:test/test.dart';
import 'package:villenet/Interpreter.dart';
import 'package:villenet/exceptions/Exceptions.dart';

main() {
  Interpreter interpreter;

  setUp(() {
    interpreter = new Interpreter();
  });

  const tAVal = 2;
  const tBVal = 3;
  const tCVal = 'non-integer';

  const STOP = 'STOP';
  const PUSH_INT = 'PUSH_INT';
  const ADD = 'ADD';
  const MUL = 'MUL';
  const DIV = 'DIV';
  const SUB = 'SUB';
  const LT = 'LT';
  const GT = 'GT';
  const EQ = 'EQ';
  const AND = 'AND';
  const OR = 'OR';
  const JUMP = 'JUMP';
  const JUMP_S = 'JUMP_S';
  const JUMP_I = 'JUMP_I';

  group('STOP', () {
    test('should stop program', () {
      final code = [STOP];
      expect(interpreter.runCode(code), equals(0));
    });
  });

  group('PUSH_INT', () {
    test('should throw [PushException] on invalid PUSH_INT value', () {
      final code = [PUSH_INT, tCVal];
      final call = interpreter.runCode;
      expect(() => call(code), throwsA(isA<PushException>()));
    });
  });

  group('ADD', () {
    test('should add [tAVal] and [tBVal] together and return the result', () {
      final code = [PUSH_INT, tAVal, PUSH_INT, tBVal, ADD, STOP];
      expect(interpreter.runCode(code), equals(5));
    });
    test(
        'should throw [MissingValueException] when there is no two values in stack',
        () {
      final code = [PUSH_INT, tAVal, ADD];
      final call = interpreter.runCode;
      expect(() => call(code), throwsA(isA<MissingValueException>()));
    });
  });

  group('MUL', () {
    test('should multiply tValA and tValB and return its result', () {
      final code = [PUSH_INT, tAVal, PUSH_INT, tBVal, MUL, STOP];
      final result = interpreter.runCode(code);
      expect(result, equals(6));
    });

    test(
        'should throw [MissingValueException] when no two numbers found in stack',
        () {
      final code = [PUSH_INT, tAVal, MUL, STOP];
      final call = interpreter.runCode;
      expect(() => call(code), throwsA(isA<MissingValueException>()));
    });
  });

  group('DIV', () {
    test('should divide [tAVar] and [tBVar] and return result', () {
      final code = [PUSH_INT, tAVal, PUSH_INT, tBVal, DIV, STOP];
      final result = interpreter.runCode(code);
      expect(result, equals(1.5));
    });

    test(
        'should throw [MissingValueException] when no two numbers found in stack',
        () {
      final code = [PUSH_INT, tAVal, DIV, STOP];
      final call = interpreter.runCode;
      expect(() => call(code), throwsA(isA<MissingValueException>()));
    });

    test('should throw [DivException] when trying to do division with zero',
        () {
      final code = [PUSH_INT, tAVal, PUSH_INT, 0, DIV, STOP];
      final call = interpreter.runCode;
      expect(() => call(code), throwsA(isA<DivException>()));
    });
  });
  group('SUB', () {
    test('should substract [tAVar] from [tBVar] and return result', () {
      final code = [PUSH_INT, tAVal, PUSH_INT, tBVal, SUB, STOP];
      final result = interpreter.runCode(code);
      expect(result, equals(1));
    });

    test(
        'should throw [MissingValueException] when no two numbers found in stack',
        () {
      final code = [PUSH_INT, tAVal, SUB, STOP];
      final call = interpreter.runCode;
      expect(() => call(code), throwsA(isA<MissingValueException>()));
    });
  });

  group('LT', () {
    test('should compare [tBVal] with [tAVal] and return 0', () {
      final code = [PUSH_INT, tAVal, PUSH_INT, tBVal, LT, STOP];
      final result = interpreter.runCode(code);
      expect(result, equals(0));
    });
    test(
        'should throw [MissingValueException] when no two numbers found in stack',
        () {
      final code = [PUSH_INT, tAVal, LT, STOP];
      final call = interpreter.runCode;
      expect(() => call(code), throwsA(isA<MissingValueException>()));
    });
  });

  group('GT', () {
    test('should compare [tBVal] to [tAVal] and return 1', () {
      final code = [PUSH_INT, tAVal, PUSH_INT, tBVal, GT, STOP];
      final result = interpreter.runCode(code);
      expect(result, equals(1));
    });

    test(
        'should throw [MissingValueException] when no two numbers found in stack',
        () {
      final code = [PUSH_INT, tAVal, GT, STOP];
      final call = interpreter.runCode;
      expect(() => call(code), throwsA(isA<MissingValueException>()));
    });
  });

  group('EQ', () {
    test('should compare [tBVal] with [tAVal] and return 0', () {
      final code = [PUSH_INT, tAVal, PUSH_INT, tBVal, EQ, STOP];
      final result = interpreter.runCode(code);
      expect(result, equals(0));
    });

    test('should compare [tAVal] with [tAVal] and return 1', () {
      final code = [PUSH_INT, tAVal, PUSH_INT, tAVal, EQ, STOP];
      final result = interpreter.runCode(code);
      expect(result, equals(1));
    });

    test(
        'should throw [MissingValueException] when no two numbers found in stack',
        () {
      final code = [PUSH_INT, tAVal, EQ, STOP];
      final call = interpreter.runCode;
      expect(() => call(code), throwsA(isA<MissingValueException>()));
    });
  });

  group('AND', () {
    test('should throw error if conditions commands are not present', () {
      final code = [AND, STOP];
      final call = interpreter.runCode;
      expect(() => call(code), throwsA(isA<MissingConditionCheckException>()));
    });

    [
      {"command": EQ, "result": 0},
      {"command": LT, "result": 0},
      {"command": GT, "result": 1},
    ].forEach((el) {
      test(
          'should return and answer on ${el["command"]} when format is correct',
          () {
        final code = [
          PUSH_INT,
          tAVal,
          PUSH_INT,
          tBVal,
          el["command"],
          PUSH_INT,
          tAVal,
          PUSH_INT,
          tBVal,
          el["command"],
          AND,
          STOP
        ];

        final result = interpreter.runCode(code);
        expect(result, equals(el["result"]));
      });
    });
  });

  group('OR', () {
    test('should throw error if conditions commands are not present', () {
      final code = [OR, STOP];
      final call = interpreter.runCode;
      expect(() => call(code), throwsA(isA<MissingConditionCheckException>()));
    });

    [
      {"command": LT, "result": 0},
      {"command": GT, "result": 1},
      {"command": EQ, "result": 0}
    ].forEach((el) {
      test(
          'on command ${el["command"]} should return an answer when structure is correct',
          () {
        final code = [
          PUSH_INT,
          tAVal,
          PUSH_INT,
          tBVal,
          el["command"],
          PUSH_INT,
          tAVal,
          PUSH_INT,
          tBVal,
          el["command"],
          OR,
          STOP
        ];
        final result = interpreter.runCode(code);
        expect(result, equals(el["result"]));
      });
    });
  });

  group('JUMP', () {
    test(
        'should throw [NoDestinationException] if destination value is missing',
        () {
      final code = [JUMP, STOP];
      final call = interpreter.runCode;
      expect(() => call(code), throwsA(isA<NoDestinationException>()));
    });

    test(
        'should throw [InvalidDestinationException] when destination is out of range',
        () {
      final code = [JUMP, 3, STOP];
      final call = interpreter.runCode;
      expect(() => call(code), throwsA(isA<InvalidDestinationException>()));
    });

    test(
        'should throw [FalseDestinationException] if no command on follow up locatioin',
        () {
      final code = [JUMP, 1, 4, STOP];
      final call = interpreter.runCode;
      expect(() => call(code), throwsA(isA<FalseDestinationException>()));
    });

    test('should continue on valid jump', () {
      final code = [JUMP, 1, PUSH_INT, 4, STOP];
      final result = interpreter.runCode(code);
      expect(result, equals(4));
    });
  });

  group(JUMP_S, () {
    test('should throw [MissingValueException] when no value found in stack',
        () {
      final code = [JUMP_S, STOP];
      final call = interpreter.runCode;
      expect(() => call(code), throwsA(isA<MissingValueException>()));
    });

    test(
        'should throw [InvalidDestinationException] if destination out of range',
        () {
      final code = [PUSH_INT, 2, JUMP_S, STOP];
      final call = interpreter.runCode;
      expect(() => call(code), throwsA(isA<InvalidDestinationException>()));
    });

    test(
        'should throw [InvalidDestinationException] if negative destination is out of range',
        () {
      final code = [PUSH_INT, -3, JUMP_S, STOP];
      final call = interpreter.runCode;
      expect(() => call(code), throwsA(isA<InvalidDestinationException>()));
    });

    test(
        'should throw [FalseDestinationException] if no command on follow up locatioin',
        () {
      final code = [PUSH_INT, 1, JUMP_S, 1, STOP];
      final call = interpreter.runCode;
      expect(() => call(code), throwsA(isA<FalseDestinationException>()));
    });

    test('should continue on valid jump', () {
      final code = [PUSH_INT, 4, PUSH_INT, 3, JUMP_S, PUSH_INT, 1, STOP];
      final result = interpreter.runCode(code);
      expect(result, equals(4));
    });
  });

  group(JUMP_I, () {
    test('should throw [MissingValueException] if value is missing from stack',
        () {
      final code = [JUMP_I, 1, STOP];
      final call = interpreter.runCode;
      expect(() => call(code), throwsA(isA<MissingValueException>()));
    });
    test(
        'should throw [IncorrectValueException] if stack value is not zero or one',
        () {
      final code = [PUSH_INT, 3, JUMP_I, 1, STOP];
      final call = interpreter.runCode;
      expect(() => call(code), throwsA(isA<IncorrectValueException>()));
    });

    test(
        'should throw [InvalidDestinationException] if jump target is not integer',
        () {
      final code = [PUSH_INT, 1, JUMP_I, STOP];
      final call = interpreter.runCode;
      expect(() => call(code), throwsA(isA<InvalidDestinationException>()));
    });

    test(
        'shuld throw [FalseDestinationException] if destination is not a command',
        () {
      final code = [PUSH_INT, 1, JUMP_I, 1, 1, STOP];
      final call = interpreter.runCode;
      expect(() => call(code), throwsA(isA<FalseDestinationException>()));
    });

    test('should return correct value [3]', () {
      final tRes = 3;
      final code = [PUSH_INT, 4, PUSH_INT, 0, JUMP_I, 3, PUSH_INT, tRes, STOP];
      final result = interpreter.runCode(code);
      expect(result, equals(tRes));
    });

    test('should return correct value [4]', () {
      final tRes = 4;
      final code = [PUSH_INT, tRes, PUSH_INT, 1, JUMP_I, 3, PUSH_INT, 3, STOP];
      final result = interpreter.runCode(code);
      expect(result, equals(tRes));
    });
  });
}

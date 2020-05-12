import 'package:test/test.dart';
import 'package:villenet/Interpreter.dart';
import 'package:mockito/mockito.dart';
import 'package:villenet/State.dart';
import 'package:villenet/exceptions/Exceptions.dart';

class MockState extends Mock implements State {}

main() {
  Interpreter interpreter;
  MockState mockState;

  setUp(() {
    mockState = MockState();
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
}

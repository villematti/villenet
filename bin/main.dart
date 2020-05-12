import 'dart:typed_data';
import 'dart:convert';

import 'package:pointycastle/digests/sha3.dart';
import 'package:villenet/Interpreter.dart';
import 'package:villenet/State.dart';

main(List<String> args) {
  final code = ['PUSH_INT', 4, 'PUSH_INT', 5, 'ADD', 'STOP'];
  final code1 = ['STOP'];

  final Interpreter interpreter = Interpreter();

  final val = interpreter.runCode(code);

  final uIntList = new Uint8List(1);

  final sha3 = new SHA3Digest(256, true);

  final list = Uint8List.fromList('hello world'.codeUnits);

  final encodedList = sha3.process(list);

  final bytes = Uint8List.fromList(encodedList);

  final Base64Encoder base64encoder = new Base64Encoder();

  // final sha = sha3.process(uIntList);
  print(base64encoder.convert(bytes));
}

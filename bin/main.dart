import 'dart:typed_data';
import 'dart:convert';

import 'package:pointycastle/digests/sha3.dart';
import 'package:villenet/config.dart';
import 'package:villenet/src/Blockchain.dart';
import 'package:villenet/src/Interpreter.dart';
import 'package:villenet/src/util/Utils.dart';

main(List<String> args) {
  final code = ['PUSH_INT', 4, 'PUSH_INT', 5, 'ADD', 'STOP'];
  final code1 = ['STOP'];

  final Interpreter interpreter = Interpreter();

  final val = interpreter.runCode(code);

  final blockchain = BlockchainImpl();
  print(keccakHash(blockchain.toJson()[0]));
  print(MAX_HASH_VALUE);
}

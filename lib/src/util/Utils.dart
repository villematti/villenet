import 'dart:convert';
import 'dart:typed_data';
import 'package:convert/convert.dart';

import 'package:pointycastle/digests/sha3.dart';

String sortCharacters(Map<String, dynamic> data) {
  List<String> jsonList =
      new JsonEncoder.withIndent(null).convert(data).split("");

  jsonList.sort();
  final newString = jsonList.join("");

  return newString;
}

String keccakHash(Map<String, dynamic> data) {
  final list = Uint8List.fromList(sortCharacters(data).codeUnits);

  final encodedList = new SHA3Digest(256, true).process(list);

  final bytes = Uint8List.fromList(encodedList);

  final Base64Encoder base64encoder = new Base64Encoder();

  return hex.encode(bytes);
}

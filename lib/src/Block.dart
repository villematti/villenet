import 'package:meta/meta.dart';
import 'package:villenet/config.dart';
import 'package:convert/convert.dart';

import 'BlockHeaders.dart';

class Block {
  final BlockHeaders headers;

  Block({@required this.headers});

  static String calculateBlockTargetHash(Block lastBlock) {
    var val =
        BigInt.from(MAX_HASH_VALUE / BigInt.from(lastBlock.headers.difficulty))
            .toRadixString(16);
    if (val.length > HASH_LENGTH) {
      return List.filled(HASH_LENGTH, 'f').join();
    }

    if (val.length < 64) {
      final zeroString = List.filled(HASH_LENGTH - val.length, '0').join();
      val = "${zeroString}${val}";
    }

    return val;
  }

  static mineBlock(Block lastBlock, String beneficiary) {}

  static Block genesis() {
    return new Block(headers: GENESIS_DATA);
  }

  Map<String, dynamic> toJson() {
    return {
      "beneficiary": headers.beneficiary,
      "difficulty": headers.difficulty,
      "number": headers.number,
      "timestamp": headers.timestamp,
      "nonce": headers.nonce,
      "parentHash": headers.parentHash,
    };
  }
}

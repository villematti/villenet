import 'package:meta/meta.dart';
import 'package:villenet/config.dart';

import 'BlockHeaders.dart';

abstract class Block {
  Map<String, dynamic> toJson();

  static Block genesis() {
    return new BlockImpl(headers: GENESIS_DATA);
  }
}

class BlockImpl implements Block {
  final BlockHeaders headers;

  BlockImpl({@required this.headers});

  static mineBlock(Block lastBlock) {}

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

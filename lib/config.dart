import 'package:villenet/src/BlockHeaders.dart';

final GENESIS_DATA = BlockHeaders(
  beneficiary: '--GENESIS-BENEFICIARY--',
  difficulty: 1,
  number: 0,
  timestamp: '--GENESIS-TIMESTAMP--',
  nonce: 0,
  parentHash: '--GENESIS-PARENT-HASH--',
);

const HASH_LENGTH = 64;
final MAX_HASH_VALUE =
    BigInt.parse(List.filled(HASH_LENGTH, 'f').join(), radix: 16);

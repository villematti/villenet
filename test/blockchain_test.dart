import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:villenet/config.dart';
import 'package:villenet/src/Block.dart';
import 'package:villenet/src/BlockHeaders.dart';
import 'package:villenet/src/Blockchain.dart';

main() {
  Blockchain bc;

  setUp(() {
    bc = BlockchainImpl();
  });

  final tGenesis = {
    "beneficiary": GENESIS_DATA.beneficiary,
    "difficulty": GENESIS_DATA.difficulty,
    "number": GENESIS_DATA.number,
    "timestamp": GENESIS_DATA.timestamp,
    "nonce": GENESIS_DATA.nonce,
    "parentHash": GENESIS_DATA.parentHash,
  };

  test('should return json list of genesis block data', () {
    final result = bc.toJson();
    expect(result, equals([tGenesis]));
  });
}

import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:villenet/src/Block.dart';
import 'package:villenet/src/BlockHeaders.dart';

class MockBlockHeaders extends Mock implements BlockHeaders {}

main() {
  Block block;
  MockBlockHeaders headers;
  setUp(() {
    headers = MockBlockHeaders();
    block = Block(headers: headers);
  });

  final tBeneficiary = "testing-beneficiary";
  final tDifficulty = 1;
  final tNumber = 123;
  final tTimestamp = "testing-timestamp";
  final tNonce = 0;
  final tParentHash = "testing-parentHash";

  setBlockHeaderData() {
    when(headers.beneficiary).thenReturn(tBeneficiary);
    when(headers.difficulty).thenReturn(tDifficulty);
    when(headers.number).thenReturn(tNumber);
    when(headers.timestamp).thenReturn(tTimestamp);
    when(headers.nonce).thenReturn(tNonce);
    when(headers.parentHash).thenReturn(tParentHash);
  }

  test("should return json of block data", () {
    setBlockHeaderData();

    final result = block.toJson();
    final expected = {
      "beneficiary": tBeneficiary,
      "difficulty": tDifficulty,
      "number": tNumber,
      "timestamp": tTimestamp,
      "nonce": tNonce,
      "parentHash": tParentHash,
    };

    expect(result, equals(expected));
  });

  test("should return max lenght", () {
    Block tLastBlock = Block(
        headers: BlockHeaders(
            beneficiary: tBeneficiary,
            difficulty: 1,
            number: tNumber,
            timestamp: tTimestamp,
            nonce: tNonce,
            parentHash: tParentHash));
    expect(
        Block.calculateBlockTargetHash(tLastBlock),
        equals(
            'ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff'));
  });

  test("should return correct length", () {
    Block tLastBlock = Block(
        headers: BlockHeaders(
            beneficiary: tBeneficiary,
            difficulty: 123,
            number: tNumber,
            timestamp: tTimestamp,
            nonce: tNonce,
            parentHash: tParentHash));
    expect(
        Block.calculateBlockTargetHash(tLastBlock),
        equals(
            '0214d0214d0214e0000000000000000000000000000000000000000000000000'));
  });

  test("should return with correct lenght", () {
    Block tLastBlock = Block(
        headers: BlockHeaders(
            beneficiary: tBeneficiary,
            difficulty: 99999999,
            number: tNumber,
            timestamp: tTimestamp,
            nonce: tNonce,
            parentHash: tParentHash));
    final result = Block.calculateBlockTargetHash(tLastBlock);
    expect(result.length, equals(64));
  });
}

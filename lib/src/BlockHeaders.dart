import 'package:meta/meta.dart';

class BlockHeaders {
  final String parentHash;
  final String beneficiary;
  final int difficulty;
  final int number;
  final String timestamp;
  final int nonce;

  BlockHeaders({
    @required this.beneficiary,
    @required this.difficulty,
    @required this.number,
    @required this.timestamp,
    @required this.nonce,
    @required this.parentHash,
  });
}

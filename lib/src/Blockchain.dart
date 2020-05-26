import 'Block.dart';

abstract class Blockchain {
  List<Map<String, dynamic>> toJson();
}

class BlockchainImpl implements Blockchain {
  final List<Block> chain = [];
  BlockchainImpl() {
    this.chain.add(Block.genesis());
  }

  List<Map<String, dynamic>> toJson() {
    return chain.map((val) => val.toJson()).toList();
  }
}

import 'package:test/test.dart';
import 'package:villenet/src/State.dart';

main() {
  StateImpl state;
  setUp(() {
    state = StateImpl();
  });

  final tCode = ["PUSH_INT, 3, STOP"];

  test('should set correct code', () {
    state.setCode(tCode);
    expect(state.code, equals(tCode));
  });
}

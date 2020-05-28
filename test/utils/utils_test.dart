import 'package:test/test.dart';
import 'package:villenet/src/util/Utils.dart';

main() {
  group("sortCharacters()", () {
    test("should return sorted string", () {
      final tData = {"testing": "something"};
      final result = sortCharacters(tData);
      expect(result, equals('"""":eegghiimnnossttt{}'));
    });

    test("should return same string when properties are switched", () {
      final tData1 = {"firstProperty": 123, "secondProperty": "testing"};
      final tData2 = {"secondProperty": "testing", "firstProperty": 123};
      expect(sortCharacters(tData1), equals(sortCharacters(tData2)));
    });

    test("should create different string from different objcts", () {
      final tData1 = {"firstProperty": 123, "secondProperty": "testing"};
      final tData2 = {"firstProperty": "456", "secondProperty": "another-test"};
      expect(sortCharacters(tData1), isNot(equals(sortCharacters(tData2))));
    });
  });

  group("keccakHash()", () {
    test("should return correct hex", () {
      expect(
          keccakHash({"foo": "bar"}),
          equals(
              "4527ed5350f32c6b456088a911f5590088fc519e53e52e350382fa57ea49e51e"));
    });
  });
}

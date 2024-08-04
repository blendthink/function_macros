import 'package:function_macros/callback_or_null.dart';
import 'package:test/test.dart';

void main() {
  group('Generates sampleA a callback method', () {
    SampleAFunction? sample;

    test('Result is null', () {
      final result = sample?.callback('a', 'b');
      expect(result, isNull);
    });

    test('Result is callback', () {
      sample = (
        String a, [
        String? b,
      ]) {
        return a + (b ?? '');
      };
      final result = sample?.callback('a', 'b');
      expect(result, isA<SampleACallback>());
    });
  });

  group('Generates sampleB a callback method', () {
    SampleBFunction? sample;

    test('Result is null', () {
      final result = sample?.callback('a', b: 'b');
      expect(result, isNull);
    });

    test('Result is callback', () {
      sample = (
        String a, {
        String? b,
      }) {
        return a + (b ?? '');
      };
      final result = sample?.callback('a', b: 'b');
      expect(result, isA<SampleBCallback>());
    });
  });

  group('Generates sampleC a callback method', () {
    _SampleCFunction? sample;

    test('Result is null', () {
      final result = sample?.callback('a');
      expect(result, isNull);
    });

    test('Result is callback', () {
      sample = (
        String a,
      ) {
        return a;
      };
      final result = sample?.callback('a');
      expect(result, isA<_SampleCCallback>());
    });
  });
}

@Callback()
external String sampleA(
  String a, [
  String? b,
]);

@Callback()
external String sampleB(
  String a, {
  required String? b,
});

@Callback()
external String _sampleC(
  String a,
);

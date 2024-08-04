import 'package:function_macros/callback_or_null.dart';
import 'package:test/test.dart';

void main() {
  group('Generates sampleA a callbackOrNull method', () {
    SampleAFunction? sample;

    test('Result is null', () {
      final result = sample.callbackOrNull('a', 'b');
      expect(result, isNull);
    });
    
    test('Result is callback', () {
      sample = (
        String a, [
        String? b,
      ]) {
        return a + (b ?? '');
      };
      final result = sample.callbackOrNull('a', 'b');
      expect(result, isA<SampleACallback>());
    });
  });

  group('Generates sampleB a callbackOrNull method', () {
    SampleBFunction? sample;

    test('Result is null', () {
      final result = sample.callbackOrNull('a', b: 'b');
      expect(result, isNull);
    });
    
    test('Result is callback', () {
      sample = (
        String a, {
        String? b,
      }) {
        return a + (b ?? '');
      };
      final result = sample.callbackOrNull('a', b: 'b');
      expect(result, isA<SampleBCallback>());
    });
  });

  group('Generates sampleC a callbackOrNull method', () {
    _SampleCFunction? sample;

    test('Result is null', () {
      final result = sample.callbackOrNull('a');
      expect(result, isNull);
    });
    
    test('Result is callback', () {
      sample = (
        String a,
      ) {
        return a;
      };
      final result = sample.callbackOrNull('a');
      expect(result, isA<_SampleCCallback>());
    });
  });
}

@CallbackOrNull()
external String sampleA(
  String a, [
  String? b,
]);

@CallbackOrNull()
external String sampleB(
  String a, {
  required String? b,
});

@CallbackOrNull()
external String _sampleC(
  String a,
);

// ignore_for_file: avoid_print

import 'package:function_macros/callback.dart';

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

void main() {
  print('Start sampleA');
  demoSampleA();

  print('Start sampleB');
  demoSampleB();

  print('Start sampleC');
  demoSampleC();
}

void demoSampleA() {
  SampleAFunction? sample;
  final result1 = sample?.callback('a', 'b');
  print(result1);

  sample = (
    String a, [
    String? b,
  ]) {
    return a + (b ?? '');
  };
  final result2 = sample?.callback('a', 'b');
  print(result2);
}

void demoSampleB() {
  SampleBFunction? sample;
  final result1 = sample?.callback('a', b: 'b');
  print(result1);

  sample = (
    String a, {
    required String? b,
  }) {
    return a + (b ?? '');
  };
  final result2 = sample?.callback('a', b: 'b');
  print(result2);
}

void demoSampleC() {
  _SampleCFunction? sample;
  final result1 = sample?.callback('a');
  print(result1);

  sample = (
    String a,
  ) {
    return a;
  };
  final result2 = sample?.callback('a');
  print(result2);
}

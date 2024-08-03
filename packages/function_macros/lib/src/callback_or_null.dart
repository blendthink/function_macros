import 'dart:async';

import 'package:macros/macros.dart';

macro class CallbackOrNull implements FunctionTypesMacro {
  const CallbackOrNull();

 @override
  Future<void> buildTypesForFunction(
    FunctionDeclaration function,
    TypeBuilder builder,
  ) async {}
}

import 'dart:async';

import 'package:macros/macros.dart';

macro class CallbackOrNull implements FunctionTypesMacro {
  const CallbackOrNull();

 @override
  Future<void> buildTypesForFunction(
    FunctionDeclaration function,
    TypeBuilder builder,
  ) async {
    if (!function.hasExternal) {
      final diagnostic = Diagnostic(
        DiagnosticMessage(
          'The @CallbackOrNull() macro can only be used on external functions.'
        ),
        Severity.error,
      );
      throw DiagnosticException(diagnostic);
    }
  }
}

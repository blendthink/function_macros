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
          'The @CallbackOrNull() macro can only be used on external functions.',
        ),
        Severity.error,
      );
      throw DiagnosticException(diagnostic);
    }

    if (function.typeParameters.isNotEmpty) {
      final diagnostic = Diagnostic(
        DiagnosticMessage(
          '''The @CallbackOrNull() macro does not support functions with type parameters.''',
        ),
        Severity.error,
      );
      throw DiagnosticException(diagnostic);
    }

    final originalFunctionName = function.identifier.name;
    final functionName = '${originalFunctionName.toCamelCase}Function';
    final callBackName = '${originalFunctionName.toCamelCase}Callback';
    final extensionName = '${callBackName}OrNull';

    final returnTypeCode = function.returnType.code;

    builder.declareType(
      functionName,
      DeclarationCode.fromParts([
        'typedef $functionName = ',
        returnTypeCode,
        ' Function',
        function.buildArgumentsCode,
        ';',
      ]),
    );

    builder.declareType(
      callBackName,
      DeclarationCode.fromParts([
        'typedef $callBackName = ',
        returnTypeCode,
        ' Function();',
      ]),
    );

    builder.declareType(
      extensionName,
      DeclarationCode.fromParts([
        'extension $extensionName on $functionName? {\n',
        '  $callBackName? callbackOrNull',
        function.buildArgumentsCode,
'''
{
    final tmp = this;
    if (tmp == null) {
      return null;
    }
    return () => tmp
''',
        function.buildArgumentsCodeForInput,
'''
;
''',
'''
  }
}
''',
      ]),
    );
  }
}

extension _CamelCase on String {
  String get toCamelCase {
    if (isEmpty) {
      return '';
    }
    
    final firstText = this[0];
    if (length == 1) {
      if (!firstText.contains(RegExp('[a-zA-Z]'))) {
        throw FormatException('Invalid character: $this');
      }
      return toUpperCase();
    }
    
    if (firstText == '_') {
      final secondText = this[1];
      return '_${secondText.toUpperCase()}${substring(2)}';
    }

    return firstText.toUpperCase() + substring(1);
  }
}

extension _BuildArgumentsCode on FunctionDeclaration {
  DeclarationCode get buildArgumentsCode {
    return DeclarationCode.fromParts([
      '(',
      if (positionalParameters.any((p) => p.isRequired)) ...[  
        for (final positionalRequired in positionalParameters
            .where((p) => p.isRequired)) ...[
          positionalRequired.code,
          ', ',
        ],
      ],
      if (positionalParameters.any((p) => !p.isRequired)) ...[
        '[',
        for (final positionalOptional in positionalParameters
            .where((p) => !p.isRequired)) ...[
          positionalOptional.code,
          ', ',
        ],
        ']',
      ],
      if (namedParameters.isNotEmpty) ...[
        '{',
        for (final named in namedParameters) ...[
          named.code,
          ', ',
        ],
        '}',
      ],
      ')',
    ]);
  }

  DeclarationCode get buildArgumentsCodeForInput {
    return DeclarationCode.fromParts([
      '(',
      if (positionalParameters.isNotEmpty) ...[  
        for (final positionalParameter in positionalParameters) ...[
          positionalParameter.name,
          ', ',
        ],
      ],
      if (namedParameters.isNotEmpty) ...[
        for (final named in namedParameters) ...[
          '${named.name}: ${named.name}',
          ', ',
        ],
      ],
      ')',
    ]);
  }
}

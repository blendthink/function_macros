import 'package:flutter/material.dart';
import 'package:function_macros/callback.dart';

@Callback()
external void _onPressed(
  String text,
);

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
  });

  final String text;
  final _OnPressedFunction? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed?.callback(text),
      child: Text(text),
    );
  }
}

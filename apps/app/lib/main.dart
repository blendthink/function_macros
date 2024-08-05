import 'package:app/custom_button.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            children: [
              CustomButton(
                text: 'NULL',
                onPressed: null,
              ),
              CustomButton(
                text: 'NOT NULL',
                onPressed: (text) {
                  print(text);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

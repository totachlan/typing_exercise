import 'package:flutter/material.dart';

import 'core/letter_service.dart';
import 'features/main_page.dart';

void main() {
  runApp(const TypingExerciseApp());
}

class TypingExerciseApp extends StatelessWidget {
  const TypingExerciseApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Typing Exercise',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const MainPage(
        letters: LetterService.aToZLetters,
      ),
    );
  }
}

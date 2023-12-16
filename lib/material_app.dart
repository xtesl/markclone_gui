import 'package:flutter/material.dart';
import 'package:markclone/screens/start_up_screens/intro_screen.dart';

class MarkClone extends StatelessWidget {
  const MarkClone({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: IntroScreen(),
    );
  }
}

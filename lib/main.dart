import 'package:flutter/material.dart';

void main() {
  runApp(const workGuard());
}

class workGuard extends StatelessWidget {
  const workGuard({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: ThemeData(), home: Container());
  }
}

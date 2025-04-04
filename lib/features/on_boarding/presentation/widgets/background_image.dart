import 'package:flutter/material.dart';

class BackgroundImage extends StatelessWidget {
  final String imagePath;

  const BackgroundImage({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage(imagePath),
          ),
        ),
      ),
    );
  }
}

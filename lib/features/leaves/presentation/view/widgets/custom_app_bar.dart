import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: screenWidth * 0.055,
              fontWeight: FontWeight.bold,
            ),
          ),
          Spacer(),
          InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: () {
              //////////////////////////////////////////////////////////////////////

              //////////////////////////////////////////////////////////////////////
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.black),
              ),
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}

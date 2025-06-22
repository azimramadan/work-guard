import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:work_guard/core/utils/constants/app_assets.dart';
import 'package:work_guard/core/utils/styles/app_colors.dart';

class AssistanceDialog extends StatelessWidget {
  final String subtitle;

  const AssistanceDialog({super.key, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: ContentBox(subtitle: subtitle),
    );
  }
}

class ContentBox extends StatelessWidget {
  const ContentBox({super.key, required this.subtitle});

  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Lottie.asset(AppAssets.animationContact, repeat: false),
              SizedBox(height: 15.0),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: screenWidth * 0.045,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 25.0),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },

                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Text(
                      'Done',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

void showAssistanceDialog(BuildContext context, String subtitle) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => AssistanceDialog(subtitle: subtitle),
  );
}

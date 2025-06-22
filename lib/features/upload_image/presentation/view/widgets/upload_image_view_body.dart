import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:work_guard/core/routes.dart';
import 'package:work_guard/core/utils/styles/app_colors.dart';
import 'package:work_guard/features/upload_image/presentation/view/dialogs/success_dialog.dart';
import 'package:work_guard/features/upload_image/presentation/view/widgets/image_actions.dart';
import 'package:work_guard/features/upload_image/presentation/view/widgets/image_grid.dart';

class UploadImageViewBody extends StatelessWidget {
  const UploadImageViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      spacing: 16,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Please upload clear photos of yourself and your face from multiple angles.',
          style: TextStyle(fontSize: screenWidth * 0.04),
          textAlign: TextAlign.center,
        ),

        Expanded(child: ImageGrid(images: [], onRemoveImage: (index) {})),

        Row(
          children: [
            Checkbox(
              value: false,
              onChanged: (value) {},
              activeColor: AppColors.primaryColor,
            ),
            Expanded(
              child: Text(
                'I confirm that I have uploaded clear photos of myself.',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.035,
                ),
              ),
            ),
          ],
        ),

        ImageActions(
          onSelectImages: () {},
          onUploadImages: () {},
          isLoading: false,
        ),
      ],
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}

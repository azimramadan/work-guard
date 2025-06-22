import 'package:flutter/material.dart';
import 'package:work_guard/core/utils/styles/app_colors.dart';

class ImageActions extends StatelessWidget {
  final VoidCallback onSelectImages;
  final VoidCallback onUploadImages;
  final bool isLoading;

  const ImageActions({
    super.key,
    required this.onSelectImages,
    required this.onUploadImages,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: ElevatedButton.icon(
            onPressed: onSelectImages,
            icon: const Icon(Icons.photo_library),
            label: const Text('Select from Gallery'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: isLoading ? null : onUploadImages,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              minimumSize: Size(double.infinity, 56),
              maximumSize: Size(double.infinity, 56),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child:
                isLoading
                    ? const CircularProgressIndicator(
                      color: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 16),
                    )
                    : const Text(
                      'Upload Images',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
          ),
        ),
      ],
    );
  }
}

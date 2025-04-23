import 'package:flutter/material.dart';

class SuccessBottomSheet extends StatelessWidget {
  final VoidCallback onDone;

  const SuccessBottomSheet({super.key, required this.onDone});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // إضافة SingleChildScrollView
      child: Container(
        padding: const EdgeInsets.all(24),
        // إزالة الـ height الثابت واستخدام الحجم الطبيعي للمحتوى
        child: Column(
          mainAxisSize: MainAxisSize.min, // استخدام الحجم الدنى المطلوب
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.check, color: Colors.white, size: 32),
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Leave Applied Successfully',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Your Leave has been applied successfully',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 48),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onDone,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Done',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
            // إضافة SizedBox أخير لضمان وجود مساحة إضافية في النهاية عند التمرير
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

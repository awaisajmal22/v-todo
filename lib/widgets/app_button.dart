import 'package:flutter/material.dart';
import 'package:get/get.dart';

typedef OnTap = Function();

class AppButton extends StatelessWidget {
  final String title;
  final OnTap onTap;
  const AppButton({super.key, required this.onTap, required this.title});

  @override
  Widget build(BuildContext context) {
       final isDark = Get.isDarkMode;
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        backgroundColor: isDark
            ? Theme.of(context).colorScheme.secondary
            : Theme.of(context).primaryColor,
        foregroundColor: isDark ? Colors.black : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 5,
      ),
      child: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}

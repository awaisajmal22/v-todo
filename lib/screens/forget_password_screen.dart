import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vtodo/widgets/app_button.dart';
import '../controllers/auth_controller.dart';
class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final newPasswordController = TextEditingController();

  final AuthController authController = Get.find<AuthController>();

  void resetPassword()async {
    if (formKey.currentState!.validate()) {
      final email = emailController.text.trim();
      final newPassword = newPasswordController.text.trim();

      final success = await authController.forgetPassword(email, newPassword);

      if (success) {
        Get.snackbar(
          'Success',
          'Password updated successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Get.back(); // go back to login
      } else {
        Get.snackbar(
          'Failed',
          'Email not found',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Reset Password',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Enter your email and new password',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 40),
            Form(
              key: formKey,
              child: Column(
                children: [
                  // Email
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) =>
                        value == null || value.isEmpty ? 'Enter email' : null,
                  ),
                  const SizedBox(height: 20),

                  // New Password
                  TextFormField(
                    controller: newPasswordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'New Password',
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) => (value == null || value.length < 6)
                        ? 'Minimum 6 characters'
                        : null,
                  ),
                  const SizedBox(height: 30),

                  // Reset Button
                  SizedBox(
                    width: double.infinity,
                    child: AppButton(
                      title: 'Reset Password',
                      onTap: resetPassword,
                    ),
                  ),

                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Remembered your password? "),
                      TextButton(
                        onPressed: () => Get.back(),
                        child: const Text('Login'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
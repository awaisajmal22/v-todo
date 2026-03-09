import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:vtodo/navigation/routes.dart';
import '../controllers/auth_controller.dart';
import '../widgets/app_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    final AuthController authController = Get.find<AuthController>();

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome Back',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              const SizedBox(height: 10),
              Text('Login to continue', style: TextStyle(fontSize: 16)),
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
                          value == null || value.isEmpty ? 'Enter your email' : null,
                    ),
                    const SizedBox(height: 20),

                    // Password
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) =>
                          value == null || value.isEmpty ? 'Enter your password' : null,
                    ),
                    const SizedBox(height: 30),

                    // Login button with loading
                    Obx(() => authController.isLoading.value
                        ? const CircularProgressIndicator()
                        : SizedBox(
                            width: double.infinity,
                            child: AppButton(
                              title: 'Login',
                              onTap: () async {
                                if (formKey.currentState!.validate()) {
                                  final email = emailController.text.trim();
                                  final password = passwordController.text.trim();

                                  final success = await authController.login(email, password);
                                  if (success) {
                                    Get.offAllNamed(Routes.home);
                                  } else {
                                    Get.snackbar(
                                      'Login Failed',
                                      'Invalid email or password',
                                      snackPosition: SnackPosition.BOTTOM,
                                      backgroundColor: Colors.redAccent,
                                      colorText: Colors.white,
                                    );
                                  }
                                }
                              },
                            ),
                          )),
                    const SizedBox(height: 10),

                    // Forgot password
                    TextButton(
                      onPressed: () => Get.toNamed(Routes.forget),
                      child: const Text('Forgot Password?'),
                    ),

                    // Signup link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account? "),
                        TextButton(
                          onPressed: () => Get.toNamed(Routes.signup),
                          child: const Text('Sign Up'),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
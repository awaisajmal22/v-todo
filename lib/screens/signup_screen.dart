import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vtodo/navigation/routes.dart';
import '../controllers/auth_controller.dart';
import '../widgets/app_button.dart';


class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    final AuthController authController = Get.find<AuthController>();

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Create Account',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              const SizedBox(height: 10),
              Text('Sign up to get started', style: TextStyle(fontSize: 16)),
              const SizedBox(height: 40),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    // Name
                    TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: 'Name',
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) =>
                          value == null || value.isEmpty ? 'Enter your name' : null,
                    ),
                    const SizedBox(height: 20),

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

                    // Password
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) => (value == null || value.length < 6)
                          ? 'Minimum 6 characters'
                          : null,
                    ),
                    const SizedBox(height: 30),

                    // Signup Button with Loading
                    Obx(() => authController.isLoading.value
                        ? const CircularProgressIndicator()
                        : SizedBox(
                            width: double.infinity,
                            child: AppButton(
                              title: 'Sign Up',
                              onTap: () async {
                                if (formKey.currentState!.validate()) {
                                  final name = nameController.text.trim();
                                  final email = emailController.text.trim();
                                  final password = passwordController.text.trim();

                                  final success = await authController.signup(
                                    email,
                                    password,
                                 name:   name,
                                  );

                                  if (success) {
                                    Get.offAllNamed(Routes.home);
                                  } else {
                                    Get.snackbar(
                                      'Signup Failed',
                                      'Email already exists',
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have an account? "),
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
      ),
    );
  }
}
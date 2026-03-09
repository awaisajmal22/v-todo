import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vtodo/controllers/auth_controller.dart';
import 'package:vtodo/gen/assets.gen.dart';
import 'package:vtodo/navigation/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  final AuthController authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    animation = Tween<double>(
      begin: 0.5,
      end: 1,
    ).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeInOut),
    );

    controller.forward();

    // Delay splash and check user
    Future.delayed(const Duration(seconds: 3), _checkUser);
  }

  void _checkUser() async {
    // splash delay
    await Future.delayed(const Duration(seconds: 1));

    if (authController.currentUser.value != null) {
      Get.offNamed(Routes.home);
    } else {
      Get.offNamed(Routes.login);
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ScaleTransition(
          scale: animation,
          child: Assets.images.logo.image(), // your logo
        ),
      ),
    );
  }
}
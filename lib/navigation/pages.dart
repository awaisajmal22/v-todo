import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/route_manager.dart';
import 'package:vtodo/controllers/auth_controller.dart';
import 'package:vtodo/controllers/todo_controller.dart';
import 'package:vtodo/navigation/routes.dart';
import 'package:vtodo/screens/forget_password_screen.dart';
import 'package:vtodo/screens/home_screen.dart';
import 'package:vtodo/screens/login_screen.dart';
import 'package:vtodo/screens/signup_screen.dart';
import 'package:vtodo/screens/splash_screen.dart';

class Pages {
  static final routes = [
    GetPage(name: Routes.splash, page: () => SplashScreen(),  binding: BindingsBuilder(() {
        Get.lazyPut<AuthController>(() => AuthController());
      }),),
    GetPage(
      name: Routes.login,
      page: () => LoginScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<AuthController>(() => AuthController());
      }),
    ),
    GetPage(name: Routes.signup, page: () => SignupScreen(), binding: BindingsBuilder(() {
        Get.lazyPut<AuthController>(() => AuthController());
      }),),
    GetPage(name: Routes.forget, page: () => ForgotPasswordScreen(), binding: BindingsBuilder(() {
        Get.lazyPut<AuthController>(() => AuthController());
      }),),
    GetPage(
      name: Routes.home,
      page: () => HomeScreen(),
       binding: BindingsBuilder(() {
        Get.lazyPut<TodoController>(() => TodoController());
         Get.lazyPut<AuthController>(() => AuthController());
      }),
    ),
  ];
}

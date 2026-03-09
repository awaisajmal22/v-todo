import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:get/get.dart';
import 'package:vtodo/models/todo_model.dart';
import 'package:vtodo/models/user_model.dart';
import 'package:vtodo/navigation/pages.dart';
import 'package:vtodo/navigation/routes.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(TodoAdapter());
 if (!Hive.isBoxOpen('users')) {
    await Hive.openBox<User>('users');
  }
  if (!Hive.isBoxOpen('currentUser')) {
    await Hive.openBox('currentUser');
  }
  if (!Hive.isBoxOpen('todos')) {
    await Hive.openBox<Todo>('todos');
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return  GetMaterialApp(
      theme: ThemeData(
        primaryColor: const Color(0xFF0E3A87),
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1267A8),
          secondary: const Color(0xFFF17C1F),
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        primaryColor: const Color(0xFF0E3A87),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1267A8),
          secondary: const Color(0xFFF17C1F),
          brightness: Brightness.dark,
        ),
      ),

      debugShowCheckedModeBanner: false,
      initialRoute: Routes.splash,
      getPages: Pages.routes,
      
    );
  }
}
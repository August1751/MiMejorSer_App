import 'package:flutter/material.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:get/get.dart';
import 'ui/pages/metas_primera_vez.dart';
import 'ui/Controllers/user_controller.dart';
import 'ui/pages/start.dart';

void main() {
  Get.put(UserController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false, // Elimina la bandera de debug
      title: 'Mi Mejor Ser',
      theme: ThemeData(
          colorScheme: const ColorScheme.light(
            primary: Colors.indigo,
            secondary: Colors.green,
            tertiary: Colors.purple,
            error: Colors.red,
          ),),
      home: Start(), // Utiliza la pantalla de login
    );
  }
}

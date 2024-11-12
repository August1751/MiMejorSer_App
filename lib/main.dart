import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'ui/Controllers/user_controller.dart';
import 'ui/pages/start.dart';
import 'ui/pages/iniciar_sesion.dart';
import 'ui/pages/registrarse.dart';
import 'ui/pages/metas_primera_vez.dart';
import 'ui/pages/puntos_page.dart';
import 'ui/pages/home.dart';


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
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => Start()),
        GetPage(name: '/login', page: () => const LoginScreen()),
        GetPage(name: '/signup', page: () => const SignUpPage()),
        GetPage(name: '/metas', page: () => const MetasPage()),
        GetPage(name: '/home', page: () => const Home()),
        GetPage(name: '/points', page: () => PuntosPage())
      ]// Utiliza la pantalla de login
    );
  }
}

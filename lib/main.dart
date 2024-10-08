import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'ui/pages/metas_primera_vez.dart'; // Importa el archivo nuevo

void main() {
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MetasPage(), // Utiliza la pantalla de login
    );
  }
}

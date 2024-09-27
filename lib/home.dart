import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'login.dart';
import 'signup.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Spacer(flex: 2), // Este Spacer empuja el contenido hacia arriba
              const Text(
                'Mi Mejor Ser',
                style: TextStyle(
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(flex: 3), // Más espacio entre el título y los botones
              ElevatedButton(
                onPressed: () {
                  Get.to( const LoginScreen(email: 'blank', password: 'blank'));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple, // Color del botón
                  foregroundColor: Colors.white, // Color del texto del botón
                  padding: const EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 50.0,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: const Text('Iniciar sesión'),
              ),
              const SizedBox(height: 20), // Espacio entre los botones
              ElevatedButton(
                onPressed: () {
                  Get.to(const SignUpPage() );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple, // Color del botón
                  foregroundColor: Colors.white, // Color del texto del botón
                  padding: const EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 50.0,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: const Text('Registrarse'),
              ),
              const Spacer(flex: 2), // Este Spacer crea espacio al final de la pantalla
            ],
          ),
        ),
      ),
    );
  }
}

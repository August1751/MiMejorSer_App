import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controllers/login_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the controller
    final LoginController controller = Get.put(LoginController());

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Iniciar Sesión"),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xFFD4A5FF), Color(0xFFA5E6FF)])),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 12.0),
          child: Form(
            key: controller.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Iniciar sesión con correo",
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  key: const Key('TextFormFieldLoginEmail'),
                  controller: controller.emailController,
                  decoration:
                      const InputDecoration(labelText: 'Correo Electronico'),
                  validator: controller.validateEmail,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  key: const Key('TextFormFieldLoginPassword'),
                  controller: controller.passwordController,
                  decoration: const InputDecoration(labelText: "Contraseña"),
                  keyboardType: TextInputType.number,
                  obscureText: true,
                  validator: controller.validatePassword,
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    key: const Key('ButtonLoginSubmit'),
                    onPressed: () {
                      // Dismiss keyboard
                      FocusScope.of(context).requestFocus(FocusNode());
                      controller.login();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple, // Color del botón
                      foregroundColor:
                          Colors.white, // Color del texto del botón
                      padding: const EdgeInsets.symmetric(
                        vertical: 16.0,
                        horizontal: 50.0,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    child: const Text("Entrar")),
                const SizedBox(
                  height: 20,
                ), // Espacio entre los botones
                ElevatedButton(
                  onPressed: () {
                    Get.toNamed('/signup');
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white, // Color del botón
                      foregroundColor:
                          Colors.deepPurple, // Color del texto del botón
                      padding: const EdgeInsets.symmetric(
                        vertical: 16.0,
                        horizontal: 35.0,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      side: const BorderSide(color: Colors.deepPurple)),
                  child: const Text('Registrarse'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

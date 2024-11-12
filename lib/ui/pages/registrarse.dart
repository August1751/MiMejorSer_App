import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controllers/register_controller.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the controller
    final SignUpController controller = Get.put(SignUpController());

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Registrarse"),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
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
                  'Ingresa la información de la cuenta',
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 20),
                TextFormField(
                    key: const Key('TextFormFieldSignUpUsername'),
                    controller: controller.usernameController,
                    decoration: const InputDecoration(
                        border: UnderlineInputBorder(), labelText: 'Usuario'),
                    validator: controller.validateUsername,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  key: const Key('TextFormFieldSignUpEmail'),
                  controller: controller.emailController,
                  decoration: const InputDecoration(
                      border: UnderlineInputBorder(), labelText: 'Correo electronico'),
                  validator: controller.validateEmail,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  key: const Key('TextFormFieldSignUpPassword'),
                  controller: controller.passwordController,
                  decoration: const InputDecoration(
                      border: UnderlineInputBorder(), labelText: "Contraseña"),
                  keyboardType: TextInputType.number,
                  obscureText: true,
                  validator: controller.validatePassword,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                    key: const Key('ButtonSignUpSubmit'),
                    onPressed: () {
                      // Dismiss the keyboard
                      FocusScope.of(context).requestFocus(FocusNode());
                      controller.signUp(); // Use the controller's signup method
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        vertical: 16.0,
                        horizontal: 50.0,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    child: const Text("Entrar")
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

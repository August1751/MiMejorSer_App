import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'registrarse.dart';
import '../Controllers/login_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key, required this.email, required this.password}) : super(key: key);

  final String email;
  final String password;

  @override
  Widget build(BuildContext context) {
    // Initialize the controller
    final LoginController _controller = Get.put(LoginController());

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Iniciar Sesión"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 12.0),
          child: Form(
            key: _controller.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Login with email",
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  key: const Key('TextFormFieldLoginEmail'),
                  controller: _controller.emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: _controller.validateEmail,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  key: const Key('TextFormFieldLoginPassword'),
                  controller: _controller.passwordController,
                  decoration: const InputDecoration(labelText: "Password"),
                  keyboardType: TextInputType.number,
                  obscureText: true,
                  validator: _controller.validatePassword,
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    key: const Key('ButtonLoginSubmit'),
                    onPressed: () {
                      // Dismiss keyboard
                      FocusScope.of(context).requestFocus(FocusNode());
                      _controller.login(email, password);
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
                    child: const Text("Submit")),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(height: 20), // Espacio entre los botones
                ElevatedButton(
                  onPressed: () {
                    Get.to(const SignUpPage());
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

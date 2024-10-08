import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controllers/register_controller.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Initialize the controller
    final SignUpController _controller = Get.put(SignUpController());

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Registrarse"),
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
                  'Enter account information',
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 20),
                TextFormField(
                    key: const Key('TextFormFieldSignUpUsername'),
                    controller: _controller.usernameController,
                    decoration: const InputDecoration(
                        border: UnderlineInputBorder(), labelText: 'Username'),
                    validator: _controller.validateUsername,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  key: const Key('TextFormFieldSignUpEmail'),
                  controller: _controller.emailController,
                  decoration: const InputDecoration(
                      border: UnderlineInputBorder(), labelText: 'Email'),
                  validator: _controller.validateEmail,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  key: const Key('TextFormFieldSignUpPassword'),
                  controller: _controller.passwordController,
                  decoration: const InputDecoration(
                      border: UnderlineInputBorder(), labelText: "Password"),
                  keyboardType: TextInputType.number,
                  obscureText: true,
                  validator: _controller.validatePassword,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                    key: const Key('ButtonSignUpSubmit'),
                    onPressed: () {
                      // Dismiss the keyboard
                      FocusScope.of(context).requestFocus(FocusNode());
                      _controller.signUp(); // Use the controller's signup method
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
                    child: const Text("Submit")
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

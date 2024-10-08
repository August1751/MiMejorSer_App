import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'metas_primera_vez.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Enter account information',
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                    key: const Key('TextFormFieldSignUpUsername'),
                    controller: _usernameController,
                    decoration: const InputDecoration(
                        border: UnderlineInputBorder(), labelText: 'Username'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter username";
                      } else if (value.length < 8) {
                        return "Username must have at least 8 characters";
                      }
                      return null;
                    }),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  key: const Key('TextFormFieldSignUpEmail'),
                  controller: _emailController,
                  decoration: const InputDecoration(
                      border: UnderlineInputBorder(), labelText: 'Email'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter email";
                    } else if (!value.contains('@')) {
                      return "Enter valid email address";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  key: const Key('TextFormFieldSignUpPassword'),
                  controller: _passwordController,
                  decoration: const InputDecoration(
                      border: UnderlineInputBorder(), labelText: "Password"),
                  keyboardType: TextInputType.number,
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter password";
                    } else if (value.length < 6) {
                      return "Password should have at least 6 characters";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    key: const Key('ButtonSignUpSubmit'),
                    onPressed: () {
                      // this line dismiss the keyboard by taking away the focus of the TextFormField and giving it to an unused
                      FocusScope.of(context).requestFocus(FocusNode());
                      final form = _formKey.currentState;
                      form!.save();
                      if (form.validate()) {
                       Get.to(const MetasPage());  //Get.OffAll(firstime)
                      } else {
                        const snackBar = SnackBar(
                          content: Text('Validation nok'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

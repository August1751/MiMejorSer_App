import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert'; // Para usar la función de hashing
import './user_controller.dart';
import './validators.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import './user_controller.dart';

class SignUpController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Access the UserController instance
  final UserController userController = Get.find<UserController>();

  // Function to validate and sign up
  void signUp() {
    final form = formKey.currentState;
    if (form != null && form.validate()) {
      // Add a new user using UserController
      bool validate = userController.addUser(
        usernameController.text,
        emailController.text,
        passwordController.text,
      );

      String encodedEmail = _encodeEmail(emailController.text);

      // Navigate to the Metas page if signup is successful
      if (validate) {
        Get.toNamed('/metas', arguments: {'email': encodedEmail});
      }
    } else {
      Get.snackbar('Error', 'Por favor, corrija los errores',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  String _encodeEmail(String email) {
    return base64Url.encode(utf8.encode(email));
  }

  // Validators
  String? validateUsername(String? value) {
    // Add your validation logic
  }

  String? validateEmail(String? value) {
    // Add your validation logic
  }

  String? validatePassword(String? value) {
    // Add your validation logic
  }
}


  // Validadores del formulario
  String? validateUsername(String? value) {
    return FormValidators.validateUsername(value);
  }

  String? validateEmail(String? value) {
    return FormValidators.validateEmail(value);
  }

  String? validatePassword(String? value) {
    return FormValidators.validatePassword(value);
  }
}

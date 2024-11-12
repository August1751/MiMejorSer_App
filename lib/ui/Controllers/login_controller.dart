import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import './validators.dart';
import './user_controller.dart';


class LoginController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var email = ''.obs;
  var password = ''.obs;

  // Access the UserController instance
  final UserController userController = Get.find<UserController>();

  // Function to validate and login
  void login() {
    final form = formKey.currentState;
    if (form != null && form.validate()) {
      // Retrieve the user from the Hive box using UserController
      var user = userController.findUserByEmail(emailController.text);
      if (user != null && user.password == passwordController.text) {
        String encodedEmail = _encodeEmail(emailController.text);
        Get.toNamed('/home', arguments: {'email': encodedEmail});
      } else {
        Get.snackbar(
          'Error',
          'Email o contraseña incorrectos',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } else {
      Get.snackbar(
        'Error',
        'Por favor, ingrese los datos válidos',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  String _encodeEmail(String email) {
    return base64Url.encode(utf8.encode(email));
  }
  
  // Validadores del formulario
  String? validateEmail(String? value) {
    return FormValidators.validateEmail(value);
  }

  String? validatePassword(String? value) {
    return FormValidators.validatePassword(value);
  }
}
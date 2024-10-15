import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import './validators.dart';
import './user_controller.dart';
import '../pages/home.dart';

class LoginController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var email = ''.obs;
  var password = ''.obs;

  // Inyecta el UserController para acceder a los usuarios
  final UserController userController = Get.find<UserController>();

  // Función para validar e iniciar sesión
  void login() {
    final form = formKey.currentState;
    if (form != null && form.validate()) {
      // Verifica si existe el usuario con las credenciales correctas
      var user = userController.findUserByEmail(emailController.text);
      if (user != null && user.password == passwordController.text) {
        String encodedEmail = _encodeEmail(emailController.text);
        Get.to(Home(),arguments: {'email': encodedEmail}); // Navega a Home si el login es exitoso
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
    // Convertir el email en bytes y luego codificarlo en base64Url
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

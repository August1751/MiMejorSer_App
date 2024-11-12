import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert'; // Para usar la función de hashing
import './user_controller.dart';
import './validators.dart';

class SignUpController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Inyecta el UserController para registrar nuevos usuarios
  final UserController userController = Get.find<UserController>();

  // Función para validar y registrarse
  void signUp() {
    final form = formKey.currentState;
    if (form != null && form.validate()) {
      // Añade el nuevo usuario al UserController
      bool validate= userController.addUser(
        usernameController.text,
        emailController.text,
        passwordController.text,
      );

      // Codifica el email antes de enviarlo como argumento
      String encodedEmail = _encodeEmail(emailController.text);

      // Navega a la página de Metas tras el registro exitoso, pasando el email codificado
      if(validate){
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

  // Método para codificar el email usando un hash (sha256 en este caso)
  String _encodeEmail(String email) {
  // Convertir el email en bytes y luego codificarlo en base64Url
  return base64Url.encode(utf8.encode(email));
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

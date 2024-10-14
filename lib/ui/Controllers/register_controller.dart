import 'package:flutter/material.dart';
import 'package:get/get.dart';
import './user_controller.dart';
import './validators.dart';
import '../pages/metas_primera_vez.dart';

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
      userController.addUser(
        usernameController.text,
        emailController.text,
        passwordController.text,
      );
      // Navega a la página de Metas tras el registro exitoso
      Get.to(MetasPage());
    } else {
      Get.snackbar('Error', 'Por favor, corrija los errores',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
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

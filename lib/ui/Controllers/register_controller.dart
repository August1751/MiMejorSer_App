import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../pages/Auth/metas_primera_vez.dart';

class SignUpController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Function to validate and sign up
  void signUp() {
    final form = formKey.currentState;
    if (form != null && form.validate()) {
      // Navigate to MetasPage after successful validation
      Get.to(MetasPage());
    } else {
      Get.snackbar('Error', 'Please correct the errors',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  // Validators for the form fields
  String? validateUsername(String? value) {
    if (value!.isEmpty) {
      return "Enter username";
    } else if (value.length < 8) {
      return "Username must have at least 8 characters";
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value!.isEmpty) {
      return "Enter email";
    } else if (!value.contains('@')) {
      return "Enter valid email address";
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value!.isEmpty) {
      return "Enter password";
    } else if (value.length < 6) {
      return "Password should have at least 6 characters";
    }
    return null;
  }
}

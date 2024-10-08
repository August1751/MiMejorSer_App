import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../pages/HomePage/home.dart';

class LoginController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  
  var email = ''.obs;
  var password = ''.obs;

  // Function to validate and login
  void login(String correctEmail, String correctPassword) {
    final form = formKey.currentState;
    if (form != null && form.validate()) {
      if (emailController.text == correctEmail && passwordController.text == correctPassword) {
        Get.to(Home());  // Navigate to Home on success
      } else {
        Get.snackbar('Error', 'Incorrect email or password',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } else {
      Get.snackbar('Error', 'Please enter valid details',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  // Form validator functions
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

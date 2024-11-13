import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '../../storage/user_model.dart';
import '../../storage/metas_model.dart'; // Assuming this is where your User class is defined

class UserController extends GetxController {
  // Use Hive to persist user data
  late Box<User> userBox;

  // Initialize the box when this controller is created
  @override
  void onInit() async {
    super.onInit();
    userBox = await Hive.openBox<User>('userBox');
  }

  // Method to add a new user
  bool addUser(String username, String email, String password) {
    // Check if the email already exists to avoid duplicates
    if (userBox.values.any((user) => user.email == email)) {
      Get.snackbar('Error', 'El usuario ya existe con ese email',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return false;
    } else {
      var user = User(username, email, password);
      userBox.add(user); // Save user to Hive box
      Get.snackbar('Éxito', 'Usuario agregado correctamente',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white);
      return true;
    }
  }

  // Method to find a user by email
  User? findUserByEmail(String email) {
    return userBox.values.firstWhere((user) => user.email == email);
  }

  String encodeEmail(String email) {
    return base64Url.encode(utf8.encode(email));
  }

  void removeUserByEmail(String email) {
    var userToRemove = userBox.values.firstWhere((user) => user.email == email);
    if (userToRemove != null) {
      userBox.delete(userToRemove.key); // Remove from Hive
      Get.snackbar('Éxito', 'Usuario eliminado correctamente',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white);
    } else {
      Get.snackbar('Error', 'Usuario no encontrado',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

   List<Meta> getMetasForUser(String email) {
    var user = findUserByEmail(email);
    return user?.metas ?? [];
  }

  void addMetasToUser(String encodedEmail, List<Meta> metas) {
    var user =
        userBox.values.firstWhere((u) => encodeEmail(u.email) == encodedEmail);

    if (user != null) {
      user.metas.clear(); // Clear existing metas
      user.metas.addAll(metas); // Add new metas
      update(); // Update if necessary
    } else {
      Get.snackbar(
        'Error',
        'Usuario no encontrado',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
  void setUserDateTime(String encodedEmail, DateTime dateTime) {
    var user =
        userBox.values.firstWhere((u) => encodeEmail(u.email) == encodedEmail);
    if (user != null) {
      user.dateTime = dateTime; // Cambiar la fecha
      Get.snackbar('Éxito', 'Fecha actualizada para ${user.username}',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white);
    } else {
      Get.snackbar('Error', 'Usuario no encontrado',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }
}


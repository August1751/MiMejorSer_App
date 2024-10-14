import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Definir la clase User
class User {
  String username;
  String email;
  String password;
  int puntos = 0;

  User(this.username, this.email, this.password);

  // Método para agregar puntos
  void agregarPuntos(int puntos) {
    this.puntos += puntos;
  }
}

// Controlador para gestionar los usuarios
class UserController extends GetxController {
  // Lista reactiva de usuarios
  var users = <User>[].obs;

  // Método para agregar un nuevo usuario
  void addUser(String username, String email, String password) {
    // Verifica si el email ya existe para evitar duplicados
    if (users.any((user) => user.email == email)) {
      Get.snackbar('Error', 'El usuario ya existe con ese email',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    } else {
      users.add(User(username, email, password));
      Get.snackbar('Éxito', 'Usuario agregado correctamente',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white);
    }
  }

  // Método para eliminar un usuario por email
  void removeUserByEmail(String email) {
    users.removeWhere((user) => user.email == email);
    Get.snackbar('Éxito', 'Usuario eliminado correctamente',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white);
  }

  // Buscar un usuario por email
  User? findUserByEmail(String email) {
    return users.firstWhereOrNull((user) => user.email == email);
  }

  // Buscar un usuario por nombre de usuario
  User? findUserByUsername(String username) {
    return users.firstWhereOrNull((user) => user.username == username);
  }

  // Método para agregar puntos a un usuario
  void addPointsToUser(String email, int puntos) {
    var user = findUserByEmail(email);
    if (user != null) {
      user.agregarPuntos(puntos);
      Get.snackbar('Éxito', 'Puntos agregados a ${user.username}',
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

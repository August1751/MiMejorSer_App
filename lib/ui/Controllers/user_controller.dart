import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:get/get.dart';
import './metas_controller.dart';

// Definir la clase User
class User {
  String username;
  String email;
  String password;
  int puntos = 0;
  List<Meta> metas = []; // Lista de metas asociadas al usuario

  User(this.username, this.email, this.password);

  // Método para agregar puntos
  void agregarPuntos(int puntos) {
    this.puntos += puntos;
  }

  // Método para agregar una meta
  void agregarMeta(Meta meta) {
    metas.add(meta);
  }

  // Método para eliminar una meta
  void eliminarMeta(Meta meta) {
    metas.remove(meta);
  }
}

// Controlador para gestionar los usuarios
class UserController extends GetxController {
  // Lista reactiva de usuarios
  var users = <User>[].obs;

  // Controlador de metas para gestionar las acciones relacionadas con las metas
  final MetasController metasController = MetasController();

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

  String encodeEmail(String email) {
    return base64Url.encode(utf8.encode(email));
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

  // Método para agregar una meta a un usuario
  void addMetaToUser(String email, Meta meta) {
    var user = findUserByEmail(email);
    if (user != null) {
      user.agregarMeta(meta);
      metasController.addMeta(meta); // Agregar la meta al MetasController
      Get.snackbar('Éxito', 'Meta agregada a ${user.username}',
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

  // Método para eliminar una meta de un usuario
  void removeMetaFromUser(String email, Meta meta) {
    var user = findUserByEmail(email);
    if (user != null) {
      user.eliminarMeta(meta);
      metasController.metas
          .remove(meta); // Eliminar la meta del MetasController
      Get.snackbar('Éxito', 'Meta eliminada de ${user.username}',
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

  // Método para obtener las metas de un usuario
  List<Meta> getMetasForUser(String email) {
    var user = findUserByEmail(email);
    return user?.metas ?? [];
  }

  void addMetasToUser(String encodedEmail, List<Meta> metas) {
  // Busca al usuario utilizando el email codificado
  var user = users.firstWhereOrNull((u) => encodeEmail(u.email) == encodedEmail);
  
  if (user != null) {
    // Agrega las metas al usuario encontrado
    user.metas.addAll(metas);
    update(); // Actualiza la interfaz si es necesario
  } else {
    Get.snackbar('Error', 'Usuario no encontrado',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }
}

}

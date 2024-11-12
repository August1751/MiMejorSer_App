import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '../../storage/user_model.dart'; // Assuming this is where your User class is defined

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
    return userBox.values.firstWhereOrNull((user) => user.email == email);
  }

  void removeUserByEmail(String email) {
    var userToRemove = users.firstWhereOrNull((user) => user.email == email);
    if (userToRemove != null) {
      userBox.delete(userToRemove.key); // Remove from Hive
      users.remove(userToRemove);       // Remove from local list
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
}

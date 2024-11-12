import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mimejorser_app/ui/Controllers/user_controller.dart';
import '../Controllers/metas_controller.dart';

class PuntosPage extends StatelessWidget {
  const PuntosPage({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments;
    final encodedEmail = arguments['email'];
    final UserController userController = Get.find<UserController>();
    final user = userController.users.firstWhereOrNull(
        (u) => userController.encodeEmail(u.email) == encodedEmail);
    final MetasController controller = Get.put(
      MetasController(initialMetas: user?.metas ?? []),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Puntos'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFD4A5FF), Color(0xFFA5E6FF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Center(
        child: Obx(() {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Puntos acumulados:',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Text(
                '${controller.puntos.value}', // Mostramos los puntos actuales
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

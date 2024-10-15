import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controllers/metas_controller.dart';

class PuntosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MetasController metasController = Get.find<MetasController>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Mis Puntos'),
        backgroundColor: Colors.purple,
      ),
      body: Center(
        child: Obx(() {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Puntos acumulados:',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                '${metasController.puntos.value}', // Mostramos los puntos actuales
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.purple),
              ),
            ],
          );
        }),
      ),
    );
  }
}

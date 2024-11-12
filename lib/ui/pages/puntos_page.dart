import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mimejorser_app/ui/Controllers/user_controller.dart';
import '../Controllers/metas_controller.dart';

class PuntosPage extends StatefulWidget {
  @override
  _PuntosPageState createState() => _PuntosPageState();
}

class _PuntosPageState extends State<PuntosPage> {
  late UserController userController;
  final List<bool> _isChecked = List<bool>.filled(5, false);

  @override
  void initState() {
    super.initState();
    userController = Get.find<UserController>();
  }

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments;
    final encodedEmail = arguments['email'];
    final user = userController.users.firstWhereOrNull(
        (u) => userController.encodeEmail(u.email) == encodedEmail);
    final int userPuntos = user?.puntos ?? 0;
    final MetasController controller = Get.put(
      MetasController(initialMetas: user?.metas ?? []),
    );

    // Activar los checkboxes si el usuario tiene al menos 50 puntos
    for (int i = 0; i < _isChecked.length; i++) {
      _isChecked[i] = userPuntos >= 50;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Mis Puntos'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFD4A5FF), Color(0xFFA5E6FF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 20),
            Text(
              'Puntos acumulados:',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Obx(() {
              return Text(
                '${controller.puntos.value}',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                ),
              );
            }),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  _buildIconItem(Icons.access_alarm, 'Access Alarm', 0),
                  _buildIconItem(Icons.directions_bus, 'Directions Bus', 1),
                  _buildIconItem(Icons.assignment_turned_in_outlined, 'Assignment Turned In', 2),
                  _buildIconItem(Icons.audiotrack, 'Audiotrack', 3),
                  _buildIconItem(Icons.email_outlined, 'Email Outlined', 4),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconItem(IconData icon, String label, int index) {
    return ListTile(
      leading: Icon(icon, color: Colors.purple),
      title: Text(label),
      trailing: Checkbox(
        value: _isChecked[index],
        onChanged: (bool? value) {
          setState(() {
            // Solo permitir cambios si los puntos son al menos 50
            if (_isChecked[index] || value == true) {
              _isChecked[index] = value ?? false;
            }
          });
        },
      ),
    );
  }
}

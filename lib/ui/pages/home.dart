import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controllers/metas_controller.dart';
import '../Controllers/user_controller.dart'; // Importar UserController para acceder a los usuarios
import 'package:flutter_spinkit/flutter_spinkit.dart'; // Para añadir el círculo de carga

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments; 
    final encodedEmail = arguments['email'];
    final UserController userController = Get.find<UserController>();
    final user = userController.users
        .firstWhereOrNull((u) => userController.encodeEmail(u.email) == encodedEmail);

    final controller = Get.put(
      MetasController(initialMetas: user?.metas ?? []),
    );

    return MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Mi Tienda',
                      style: TextStyle(
                        color: Colors.purple,
                        fontSize: 24,
                      ),
                    ),
                    Container(
                      width: 30,
                      height: 30,
                      color: Colors.purple,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: Obx(() {
                  return GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1,
                    children: List.generate(controller.metas.length, (index) {
                      final meta = controller.metas[index];
                      return GoalGridItem(
                        meta: meta,
                        index: index,
                        controller: controller,
                        encodedEmail: encodedEmail,
                      );
                    }),
                  );
                }),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _mostrarDialogoAgregarMeta(context, controller),
          backgroundColor: Colors.purple,
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  Future<void> _mostrarDialogoAgregarMeta(BuildContext context, MetasController controller) async {
    String nuevaMeta = '';
    bool esCuantificable = false;
    double valorObjetivo = 0.0;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Nueva Meta'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setDialogState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextField(
                    onChanged: (value) {
                      nuevaMeta = value;
                    },
                    decoration: const InputDecoration(hintText: 'Escribe una meta'),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: <Widget>[
                      const Text('¿Es cuantificable?'),
                      Checkbox(
                        value: esCuantificable,
                        onChanged: (bool? value) {
                          setDialogState(() {
                            esCuantificable = value ?? false;
                          });
                        },
                      ),
                    ],
                  ),
                  if (esCuantificable)
                    TextField(
                      onChanged: (value) {
                        valorObjetivo = double.tryParse(value) ?? 0.0;
                      },
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(hintText: 'Valor objetivo'),
                    ),
                ],
              );
            },
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Agregar'),
              onPressed: () {
                if (nuevaMeta.isNotEmpty) {
                  if (esCuantificable) {
                    controller.addMetaCuantificable(nuevaMeta, valorObjetivo);
                  } else {
                    controller.addMetaBooleana(nuevaMeta);
                  }
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class GoalGridItem extends StatelessWidget {
  final dynamic meta;
  final int index;
  final MetasController controller;
  final String encodedEmail;

  GoalGridItem({
    required this.meta,
    required this.index,
    required this.controller,
    required this.encodedEmail,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (meta is MetaBooleana) {
          _showBooleanMetaDialog(context, meta);
        } else if (meta is MetaCuantificable) {
          _showProgressDialog(context, meta);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[300], // Fondo gris claro
          borderRadius: BorderRadius.circular(8), // Bordes redondeados
        ),
        padding: EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                _getIconForMeta(meta.nombre),
                size: 40,
                color: Colors.purple,
              ),
              SizedBox(height: 8),
              Text(
                meta.nombre,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                ),
              ),
              SizedBox(height: 8),
              CircularProgressIndicator(
                value: meta.valorActual / meta.valorObjetivo,
                color: Colors.purple,
                backgroundColor: Colors.grey[200],
              ),
              if (meta is MetaCuantificable)
                Text(
                  'Meta: ${meta.valorActual}/${meta.valorObjetivo}',
                  style: TextStyle(fontSize: 14),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _showBooleanMetaDialog(BuildContext context, MetaBooleana meta) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Completar Meta'),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Checkbox(
                value: meta.completa,
                onChanged: (bool? value) {
                  if (value == true) {
                    controller.updateCompletion(index, true);
                    meta.completar();
                  } else {
                    controller.updateCompletion(index, false);
                    meta.descompletar();
                  }
                  Get.back();
                  _updateUserGoals();
                },
              ),
              Text('Completar'),
            ],
          ),
        );
      },
    );
  }

  void _showProgressDialog(BuildContext context, MetaCuantificable meta) {
    final TextEditingController _progressController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Actualizar Progreso'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Introduce la cantidad a añadir'),
              TextField(
                controller: _progressController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(hintText: 'Cantidad'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                final double? value = double.tryParse(_progressController.text);
                if (value != null &&
                    value > 0 &&
                    value <= (meta.valorObjetivo - meta.valorActual)) {
                  controller.actualizarProgresoMetaCuantificable(index, value);
                  Get.back();
                  _updateUserGoals();
                } else {
                  Get.snackbar(
                    'Error',
                    'Introduce un valor válido dentro del rango',
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                  );
                }
              },
              child: Text('Actualizar'),
            ),
            TextButton(
              onPressed: () => Get.back(),
              child: Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }

  void _updateUserGoals() {
    final UserController userController = Get.find<UserController>();
    userController.addMetasToUser(encodedEmail, controller.metas);
  }

  IconData _getIconForMeta(String nombre) {
    switch (nombre) {
      case 'Hidratarse':
        return Icons.local_drink_outlined;
      case 'Dormir siesta':
        return Icons.bed_outlined;
      case 'Comer frutas':
        return Icons.apple_outlined;
      case 'Hacer ejercicio':
        return Icons.sports_football_outlined;
      case 'Leer un libro':
        return Icons.library_books_outlined;
      default:
        return Icons.help_outline;
    }
  }
}

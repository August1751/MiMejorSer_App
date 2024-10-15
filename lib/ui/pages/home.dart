import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controllers/metas_controller.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart'; // Para añadir el círculo de carga

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<dynamic>? selectedGoals = Get.arguments;
    final controller = Get.put(MetasController(initialMetas: selectedGoals));

    return MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(height: 20), // Espacio superior
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[300], // Fondo gris
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Mi Tienda',
                      style: TextStyle(
                        color: Colors.purple, // Texto morado
                        fontSize: 24,
                      ),
                    ),
                    Container(
                      width: 30,
                      height: 30,
                      color: Colors.purple, // Cuadrado morado
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: Obx(() {
                  return GridView.count(
                    crossAxisCount: 2, // Dos columnas
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1, // Relación de aspecto 1:1
                    children: List.generate(controller.metas.length, (index) {
                      final meta = controller.metas[index];
                      return GoalGridItem(
                          meta: meta, index: index, controller: controller);
                    }),
                  );
                }),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Acción al presionar el FAB
          },
          backgroundColor: Colors.purple,
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

class GoalGridItem extends StatelessWidget {
  final dynamic meta;
  final int index;
  final MetasController controller;

  GoalGridItem(
      {required this.meta, required this.index, required this.controller});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (meta is MetaBooleana) {
          // Si es meta booleana, mostrar el diálogo con el checkbox
          _showBooleanMetaDialog(context, meta);
        } else if (meta is MetaCuantificable) {
          // Si es meta cuantificable, mostrar el diálogo para añadir cantidad
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
              // Añadir el ícono asociado a cada meta
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
              // Mostrar barra de progreso tanto para MetaBooleana como MetaCuantificable
              Column(
                children: [
                  SizedBox(height: 8),
                  // Barra de progreso circular
                  CircularProgressIndicator(
                    value: meta.valorActual / meta.valorObjetivo,
                    color: Colors.purple,
                    backgroundColor: Colors.grey[200],
                  ),
                ],
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

  // Función para mostrar el diálogo de checkbox para MetaBooleana
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
                    meta.completar(); // Completar meta booleana
                  } else {
                    controller.updateCompletion(index, false);
                    meta.descompletar(); // Descompletar meta booleana
                  }
                  Get.back(); // Cerrar el diálogo
                },
              ),
              Text('Completar'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Get.back(), // Cerrar el diálogo
              child: Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

  // Función para mostrar el diálogo de progreso (solo para MetaCuantificable)
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
                  Get.back(); // Cerrar el diálogo
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
              onPressed: () => Get.back(), // Cerrar el diálogo
              child: Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }

  // Función para obtener el ícono correcto basado en el nombre de la meta
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
        return Icons.help_outline; // Icono por defecto
    }
  }
}

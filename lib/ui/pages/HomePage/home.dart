import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controllers/metas_controller.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Retrieve the goals from Get.arguments, if passed
    final List<dynamic>? selectedGoals = Get.arguments;
    final MetasController _controller = Get.put(MetasController());

    return MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(height: 20), // Espacio superior

              // Usamos un Expanded para hacer que el grid ocupe el espacio restante
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2, // Dos columnas
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1, // Relación de aspecto 1:1
                  children: [
                    // "Mi Tienda" ocupará las dos columnas
                    GridTile(
                      child: Container(
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
                    ),
                    // Añadimos un SizedBox para hacer que "Mi Tienda" ocupe toda la fila
                    SizedBox.shrink(),

                    // Ítems del grid
                    if (selectedGoals != null)
                      ...selectedGoals.map((meta) {
                        print(meta);
                        return GoalGridItem(meta: meta); // Display each goal
                      }).toList(),

                    // You can keep other grid items here if needed
                  ],
                ),
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

// Custom widget to display each goal in the grid
class GoalGridItem extends StatelessWidget {
  final dynamic meta;

  GoalGridItem({required this.meta});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[300], // Fondo gris claro
        borderRadius: BorderRadius.circular(8), // Bordes redondeados
      ),
      padding: EdgeInsets.all(16),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              meta.nombre, // Display goal name
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.purple,
              ),
            ),
            if (meta is MetaCuantificable)
              Text(
                'Meta: ${meta.valorObjetivo}', // Display goal target if cuantificable
                style: TextStyle(fontSize: 16),
              ),
          ],
        ),
      ),
    );
  }
}

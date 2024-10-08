import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Espacio superior
              SizedBox(height: 20),

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
                    ...List.generate(6, (index) {
                      return CustomGridItem(); // Ítems interactivos
                    }),
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

class CustomGridItem extends StatefulWidget {
  @override
  _CustomGridItemState createState() => _CustomGridItemState();
}

class _CustomGridItemState extends State<CustomGridItem> {
  bool isPressed = false;

  void _handleTap() {
    setState(() {
      isPressed = !isPressed; // Cambia el estado al presionar
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap, // Detecta cuando el widget es presionado
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[300], // Fondo gris claro
          borderRadius: BorderRadius.circular(8), // Bordes redondeados
        ),
        child: Center(
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.purple, width: 2), // Borde morado
            ),
            child: Center(
              child: Container(
                width: 20,
                height: 20,
                color: isPressed ? Colors.green : Colors.purple, // Cambia de color cuando se presiona
              ),
            ),
          ),
        ),
      ),
    );
  }
}

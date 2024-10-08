import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Classess/metas.dart';
import '../../Classess/metas_booleana.dart';
import '../../Classess/metas_cuantificable.dart';
import '../HomePage/home.dart';

class MetasPage extends StatefulWidget {
  const MetasPage({Key? key}) : super(key: key);

  @override
  State<MetasPage> createState() => _MetasPageState();
}

class _MetasPageState extends State<MetasPage> {
  final List<Meta> _metas = [
    MetaBooleana('Hidratarse', false),
    MetaBooleana('Dormir siesta', false),
    MetaCuantificable('Comer frutas', 0, 3),
    MetaBooleana('Hacer ejercicio', false),
    MetaBooleana('Leer un libro', false)
  ];

  // Lista para manejar si cada meta está completada o no (estado del checkbox)
  final List<bool> _completadas = List.generate(5, (_) => false);

  Future<void> _mostrarDialogoAgregarMeta() async {
    String nuevaMeta = '';
    bool esCuantificable = false;
    double valorObjetivo = 0.0; // Para el valor objetivo si es cuantificable

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
                  // Campo para ingresar el nombre de la meta
                  TextField(
                    onChanged: (value) {
                      nuevaMeta = value;
                    },
                    decoration: const InputDecoration(hintText: 'Escribe una meta'),
                  ),
                  const SizedBox(height: 10),
                  // Checkbox para seleccionar si la meta es cuantificable
                  Row(
                    children: <Widget>[
                      const Text('¿Es cuantificable?'),
                      Checkbox(
                        value: esCuantificable,
                        onChanged: (bool? value) {
                          // Aquí actualizamos el estado del diálogo
                          setDialogState(() {
                            esCuantificable = value ?? false;
                          });
                        },
                      ),
                    ],
                  ),
                  // Campo para ingresar el valor objetivo si es cuantificable
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
                    _addMetaCuantificable(nuevaMeta, valorObjetivo);
                  } else {
                    _addMetaBooleana(nuevaMeta);
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

  // Función para agregar una meta booleana
  void _addMetaBooleana(String nombreMeta) {
    setState(() {
      MetaBooleana nuevaMetaBooleana = MetaBooleana(nombreMeta, false);
      _metas.add(nuevaMetaBooleana);
      _completadas.add(false); // Agregamos un valor inicial para el checkbox
    });
  }

  // Función para agregar una meta cuantificable
  void _addMetaCuantificable(String nombreMeta, double valorObjetivo) {
    setState(() {
      MetaCuantificable nuevaMetaCuantificable =
          MetaCuantificable(nombreMeta, 0.0, valorObjetivo);
      _metas.add(nuevaMetaCuantificable);
      _completadas.add(false); // Agregamos un valor inicial para el checkbox
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Metas'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Metas:',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              '¿Qué metas deseas cumplir?',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _metas.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.purple[50],
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.deepPurple[100],
                        child: const Text(
                          'A',
                          style: TextStyle(color: Colors.deepPurple),
                        ),
                      ),
                      // Aquí accedemos al nombre de la meta
                      title: Text(_metas[index].nombre),
                      trailing: Checkbox(
                        value: _completadas[index],
                        onChanged: (bool? value) {
                          setState(() {
                            _completadas[index] = value ?? false;
                          });
                        },
                        activeColor: Colors.deepPurple,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _mostrarDialogoAgregarMeta,
            backgroundColor: Colors.deepPurple,
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () {
              Get.to(Home());
            },
            backgroundColor: Colors.deepPurple,
            child: const Icon(Icons.check),
          ),
        ],
      ),
    );
  }
}

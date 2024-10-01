import 'package:flutter/material.dart';


class MetasPage extends StatefulWidget {
  const MetasPage({Key? key}) : super(key: key);

  @override
  State<MetasPage> createState() => _MetasPageState();
}

class _MetasPageState extends State<MetasPage> {
  final List<String> _metas = [
    'Hidratarse',
    'Dormir Siesta',
    'Comer frutas',
    'Hacer ejercicio',
    'Leer un libro'
  ];

  // Lista para manejar si cada meta está completada o no (estado del checkbox)
  final List<bool> _completadas = List.generate(5, (_) => false);

  // Método para agregar una nueva meta
  void _addMeta(String nuevaMeta) {
    setState(() {
      _metas.add(nuevaMeta);
      _completadas.add(false); // Nueva meta con estado no completado
    });
  }

  // Método para mostrar el cuadro de diálogo y agregar una nueva meta
  Future<void> _mostrarDialogoAgregarMeta() async {
    String nuevaMeta = '';
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Nueva Meta'),
          content: TextField(
            onChanged: (value) {
              nuevaMeta = value;
            },
            decoration: const InputDecoration(hintText: 'Escribe una meta'),
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
                  _addMeta(nuevaMeta);
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
                      title: Text(_metas[index]),
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
              // Puedes agregar la funcionalidad para "guardar" las metas
            },
            backgroundColor: Colors.deepPurple,
            child: const Icon(Icons.check),
          ),
        ],
      ),
    );
  }
}

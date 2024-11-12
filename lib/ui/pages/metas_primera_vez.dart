import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controllers/metas_controller.dart';
import '../Controllers/user_controller.dart';
import 'home.dart';
class MetasPage extends StatefulWidget{
   @override
  const MetasPage({Key? key}) : super(key: key);
  _MetasPage createState() => _MetasPage();
}

class _MetasPage extends State<MetasPage> {

  final MetasPageController _controller = Get.put(MetasPageController());
  final UserController _userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    // Obtener el email codificado de los argumentos
    final arguments = Get.arguments;
    final String encodedEmail = arguments['email'];

    Future<void> _mostrarDialogoAgregarMeta(BuildContext context) async {
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
                      _controller.addMetaCuantificable(nuevaMeta, valorObjetivo);
                    } else {
                      _controller.addMetaBooleana(nuevaMeta);
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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Metas'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [Color(0xFFD4A5FF), Color(0xFFA5E6FF)]),
          ),
        ),
        leading:BackButton( onPressed:(){ Get.offNamed('/login');})
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Metas:',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              '¿Qué metas deseas cumplir?',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: _controller.metas.length,
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
                        title: Text(_controller.metas[index].nombre),
                        trailing: Obx(() => Checkbox(
                          value: _controller.selected[index],
                          onChanged: (bool? value) {
                            _controller.updateCompletion(index, value ?? false);
                          },
                          activeColor: Colors.deepPurple,
                        )),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => _mostrarDialogoAgregarMeta(context),
            backgroundColor: Colors.deepPurple,
            child: const Icon(Icons.add, color: Colors.white),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () {
              // Filtra solo las metas completadas (seleccionadas)
              final selectedGoals = _controller.metas
                  .asMap()
                  .entries
                  .where((entry) => _controller.selected[entry.key])
                  .map((entry) => entry.value)
                  .toList();

              // Agrega las metas seleccionadas al usuario con el email codificado
              _userController.addMetasToUser(encodedEmail, selectedGoals);

              // Navega a Home con el email codificado
              Get.toNamed('/home', arguments: {'email': encodedEmail});
            },
            backgroundColor: Colors.deepPurple,
            child: const Icon(Icons.check, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

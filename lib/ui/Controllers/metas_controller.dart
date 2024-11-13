import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '../../storage/metas_model.dart'; // Import the Meta classes

class MetasController extends GetxController {
  var metas = <Meta>[].obs;
  var puntos = 0.obs;
  late Box<Meta> metaBox;

  @override
  void onInit() async {
    super.onInit();
    metaBox = await Hive.openBox<Meta>('metaBox');
    metas.addAll(metaBox.values);
  }

  MetasController({List<dynamic>? initialMetas}) {
    if (initialMetas != null) {
      for (var meta in initialMetas) {
        if (meta is MetaBooleana) {
          metas.add(meta);
        } else if (meta is MetaCuantificable) {
          metas.add(meta);
        }
      }
    }
  }
  
  void addMeta(Meta meta) {
    metaBox.add(meta); // Add meta to Hive box
    metas.add(meta);   // Add meta to observable list
  }

  void addMetaBooleana(String nombre) {
    var meta = MetaBooleana(nombre);
    addMeta(meta);
  }

  void addMetaCuantificable(String nombre, double valorObjetivo) {
    var meta = MetaCuantificable(nombre, valorObjetivo);
    addMeta(meta);
  }

  void updateCompletion(int index, bool isCompleted) {
    if (isCompleted && !metas[index].completa) {
      metas[index].completar();
      puntos += 5;
      var metaCompletada = metas.removeAt(index);
      metas.insert(0, metaCompletada);
      metaBox.putAt(index, metaCompletada); // Update in Hive
    } else if (!isCompleted && metas[index].completa) {
      metas[index].descompletar();
      puntos -= 5;
      var metaDescompletada = metas.removeAt(index);
      metas.add(metaDescompletada);
      metaBox.putAt(index, metaDescompletada); // Update in Hive
    }
    metas.refresh();
  }

  void actualizarProgresoMetaCuantificable(int index, double valor) {
    if (metas[index] is MetaCuantificable) {
      (metas[index] as MetaCuantificable).actualizarProgreso(valor);
      if (metas[index].completa) {
        puntos += 5;
      }
      metaBox.putAt(index, metas[index]); // Update in Hive
      metas.refresh();
    }
  }

  void reiniciarMetasDiarias() {
    for (var i = 0; i < metas.length; i++) {
      var meta = metas[i];
      if (meta is MetaCuantificable) {
        meta.valorActual = 0;
      } else if (meta is MetaBooleana) {
        if (meta.completa) {
          puntos -= 5;
        }
        meta.descompletar();
      }
      metaBox.putAt(i, meta); // Update in Hive
    }
    update();
  }
}

class MetasPageController extends GetxController {
  // Listas observables para metas y seleccionadas
  var metas = <Meta>[].obs;
  var selected = <bool>[].obs;

  // Constructor para inicializar el controlador con metas por defecto
  @override
  void onInit() {
    super.onInit();
    _initializeDefaultMetas();
  }

  void _initializeDefaultMetas() {
    metas.addAll([
      MetaBooleana('Hidratarse'),
      MetaBooleana('Dormir siesta'),
      MetaCuantificable('Comer frutas', 3),
      MetaBooleana('Hacer ejercicio'),
      MetaBooleana('Leer un libro')
    ]);
    selected.addAll([
      false,
      false,
      false,
      false,
      false
    ]); // Inicialmente, todas las metas no están completadas
  }
  void addMetaBooleana(String nombre) {
    metas.add(MetaBooleana(nombre));
    selected.add(false); // Inicialmente no completada
  }

  // Método para agregar una nueva meta cuantificable
  void addMetaCuantificable(String nombre, double valorObjetivo) {
    metas.add(MetaCuantificable(nombre, valorObjetivo));
    selected.add(false); // Inicialmente no completada
  }

  // Método para actualizar el estado de completitud de una meta
  void updateCompletion(int index, bool isSelected) {
    selected[index] = isSelected; // Actualizar el estado de completitud
    // La lista observable 'selected' hará que Obx reconstruya cuando haya cambios
  }
}

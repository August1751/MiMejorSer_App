import 'package:get/get.dart';

// Abstract class Meta
abstract class Meta {
  String nombre; // Nombre de la meta
  bool completa; // Indica si la meta está completa o no

  Meta(this.nombre, this.completa);

  // Métodos abstractos para completar y descompletar la meta
  void completar();
  void descompletar();
}

// Clase que representa una meta booleana (hereda de Meta)
class MetaBooleana extends Meta {
  double valorActual = 0; // Valor actual (0 o 1 para booleanos)
  double valorObjetivo = 1; // El valor objetivo siempre es 1 para metas booleanas

  MetaBooleana(super.nombre, [super.completa = false]) {
    if (completa) {
      valorActual = 1;
    }
  }

  @override
  void completar() {
    completa = true;
    valorActual = 1;
  }

  @override
  void descompletar() {
    completa = false;
    valorActual = 0;
  }
}

// Clase que representa una meta cuantificable (hereda de Meta)
class MetaCuantificable extends Meta {
  double valorActual = 0; // Valor actual de la meta cuantificable
  double valorObjetivo; // Valor objetivo a alcanzar

  MetaCuantificable(String nombre, this.valorObjetivo, [this.valorActual = 0])
      : super(nombre, valorActual >= valorObjetivo);

  // Método para actualizar el progreso hacia la meta
  void actualizarProgreso(double valor) {
    valorActual += valor;
    if (valorActual >= valorObjetivo) {
      completar();
    }
  }

  @override
  void completar() {
    completa = true;
  }

  @override
  void descompletar() {
    valorActual = 0;
    completa = false;
  }
}

class MetasController extends GetxController {
  var metas = <Meta>[].obs;
  var puntos = 0.obs; // Variable que almacenará los puntos

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
    metas.add(meta);
  }

  void addMetaBooleana(String nombre) {
    metas.add(MetaBooleana(nombre));
  }

  void addMetaCuantificable(String nombre, double valorObjetivo) {
    metas.add(MetaCuantificable(nombre, valorObjetivo));
  }

  // Método para actualizar el estado de completitud y reordenar las metas
  void updateCompletion(int index, bool isCompleted) {
  if (isCompleted && !metas[index].completa) {
    metas[index].completar();
    puntos += 5; // Añadir 5 puntos cuando se completa la meta

    // Mover la meta completada al principio
    var metaCompletada = metas.removeAt(index);
    metas.insert(0, metaCompletada);
  } else if (!isCompleted && metas[index].completa) {
    metas[index].descompletar();
    puntos -= 5; // Restar puntos si la meta se descompleta

    // Mover la meta no completada al final
    var metaDescompletada = metas.removeAt(index);
    metas.add(metaDescompletada);
  }
  metas.refresh(); // Refrescar la lista
}




  void actualizarProgresoMetaCuantificable(int index, double valor) {
    if (metas[index] is MetaCuantificable) {
      (metas[index] as MetaCuantificable).actualizarProgreso(valor);
      if (metas[index].completa) {
        puntos += 5; // Añadir puntos cuando se completa la meta
      }
      metas.refresh();
    }
  }

  void reiniciarMetasDiarias() {
    for (var meta in metas) {
      if (meta is MetaCuantificable) {
        meta.valorActual = 0;
      } else if (meta is MetaBooleana) {
        if (meta.completa) {
          puntos -= 5; // Restar puntos si la meta estaba completa y se reinicia
        }
        meta.descompletar(); // Descompletar la meta booleana
      }
    }
    update(); // Actualizar el estado del controlador
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

  // Método para agregar una nueva meta booleana
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

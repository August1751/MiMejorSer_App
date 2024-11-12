import 'package:get/get.dart';

// Abstract class Meta
abstract class Meta {
  String nombre; // Name of the goal
  bool completa; // Indicates if the goal is complete or not

  Meta(this.nombre, this.completa);

  // Abstract method to complete the goal
  void completar();
  void descompletar();
}

// Class representing a boolean goal (inherits from Meta)
class MetaBooleana extends Meta {
  double valorActual = 0; // Current value (0 or 1 for booleans)
  double valorObjetivo = 1; // Target value is always 1 for boolean goals

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

  // Método para "descompletar" si se quita el check
  void descompletar() {
    completa = false;
    valorActual = 0;
  }
}

// Class representing a quantifiable goal (inherits from Meta)
class MetaCuantificable extends Meta {
  double valorActual = 0; // Current value of the quantifiable goal
  double valorObjetivo; // Target value to achieve

  MetaCuantificable(String nombre, this.valorObjetivo, [this.valorActual = 0])
      : super(nombre, valorActual >= valorObjetivo);

  // Method to update progress towards the goal
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

  void descompletar() {
    valorActual = 0;
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
          puntos -=
              5; // Restar los puntos si la meta estaba completa y se reinicia
        }
        meta.completa = false;
        meta.valorActual = 0;
      }
    }
    update();
  }
}

class MetasPageController extends GetxController {
  // Observable lists for metas and selected
  var metas = <Meta>[].obs;
  var selected = <bool>[].obs;

  // Constructor to initialize the controller with default metas
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
    ]); // Initially, all metas are not completed
  }

  // Function to add a new meta
  void addMetaBooleana(String nombre) {
    metas.add(MetaBooleana(nombre));
    selected.add(false); // Initially not completed
  }

  void addMetaCuantificable(String nombre, double valorObjetivo) {
    metas.add(MetaCuantificable(nombre, valorObjetivo));
    selected.add(false); // Initially not completed
  }

  // Function to update the completion status of a meta
  void updateCompletion(int index, bool isSelected) {
    selected[index] = isSelected; // Update the completion state
    // Since 'completadas' is an observable list, Obx will rebuild on change
  }
}

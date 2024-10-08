import 'package:get/get.dart';

// Abstract class Meta
abstract class Meta {
  String nombre; // Name of the goal
  bool completa; // Indicates if the goal is complete or not

  Meta(this.nombre, this.completa);

  // Abstract method to complete the goal
  void completar();
}

// Class representing a boolean goal (inherits from Meta)
class MetaBooleana extends Meta {
  MetaBooleana(super.nombre, [super.completa = false]);

  @override
  void completar() {
    completa = true;
  }
}

// Class representing a quantifiable goal (inherits from Meta)
class MetaCuantificable extends Meta {
  double valorActual = 0; // Current value of the quantifiable goal
  double valorObjetivo;   // Target value to achieve

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
}

// MetasController to manage a list of metas (goals)
class MetasController extends GetxController {
  // Observable list of metas
  var metas = <Meta>[].obs;

  void addMeta(Meta meta){
    metas.add(meta);
  }

  // Method to add a boolean goal
  void addMetaBooleana(String nombre) {
    metas.add(MetaBooleana(nombre));
  }

  // Method to add a quantifiable goal
  void addMetaCuantificable(String nombre, double valorObjetivo) {
    metas.add(MetaCuantificable(nombre, valorObjetivo));
  }

  // Method to update the completion status of a goal
  void updateCompletion(int index, bool isCompleted) {
    metas[index].completa = isCompleted;
    metas.refresh(); // Refresh the list to trigger UI updates
  }

  // Method to update progress of a quantifiable goal
  void actualizarProgresoMetaCuantificable(int index, double valor) {
    if (metas[index] is MetaCuantificable) {
      (metas[index] as MetaCuantificable).actualizarProgreso(valor);
      metas.refresh(); // Refresh the list to trigger UI updates
    }
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
      MetaCuantificable('Comer frutas',3),
      MetaBooleana('Hacer ejercicio'),
      MetaBooleana('Leer un libro')
    ]);
    selected.addAll([false, false, false,false,false]);  // Initially, all metas are not completed
  }

  // Function to add a new meta
  void addMetaBooleana(String nombre) {
    metas.add(MetaBooleana(nombre));
    selected.add(false); // Initially not completed
  }

  void addMetaCuantificable(String nombre, double valorObjetivo) {
    metas.add(MetaCuantificable(nombre,valorObjetivo));
    selected.add(false); // Initially not completed
  }

  // Function to update the completion status of a meta
  void updateCompletion(int index, bool isSelected) {
    selected[index] = isSelected; // Update the completion state
    // Since 'completadas' is an observable list, Obx will rebuild on change
  }
}

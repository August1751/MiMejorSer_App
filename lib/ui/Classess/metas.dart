// Clase abstracta Meta
abstract class Meta {
  String nombre; // Nombre de la meta
  bool completa; // Indica si la meta está completa o no

  // Constructor de la clase abstracta
  Meta(this.nombre, this.completa);

  // Método abstracto para completar la meta
  void completar();
}



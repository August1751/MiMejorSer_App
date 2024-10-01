import 'metas.dart';

// Clase que hereda de Meta y representa una meta booleana
class MetaBooleana extends Meta {
  // Constructor que inicializa nombre y estado de completa
  MetaBooleana(String nombre, bool completa) : super(nombre, completa);

  // Implementación del método para completar la meta
  @override
  void completar() {
    completa = true;
  }
}

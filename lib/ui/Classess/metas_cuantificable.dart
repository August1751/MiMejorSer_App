import 'metas.dart';


// Clase que hereda de Meta y representa una meta cuantificable
class MetaCuantificable extends Meta {
  double valorActual = 0; // Valor actual de la meta cuantificable
  double valorObjetivo; // Valor objetivo que se quiere alcanzar

  // Constructor que inicializa nombre, estado de completa y valores
  MetaCuantificable(String nombre, this.valorActual, this.valorObjetivo)
      : super(nombre, valorActual >= valorObjetivo);

  // Implementación del método para actualizar el progreso y completar la meta
  void actualizarProgreso(double valor) {
    valorActual += valor;
    if (valorActual >= valorObjetivo) {
      completar();
    } else {
      print("Progreso actual de '$nombre': $valorActual/$valorObjetivo");
    }
  }

  // Implementación del método para completar la meta
  @override
  void completar() {
    completa = true;
    print("La meta cuantificable '$nombre' ha sido completada.");
  }
}



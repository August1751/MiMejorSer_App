import 'package:hive/hive.dart';

part 'metas_model.g.dart'; // Generated file for Hive adapters

@HiveType(typeId: 1)
abstract class Meta extends HiveObject {
  @HiveField(0)
  String nombre;

  @HiveField(1)
  bool completa;

  Meta(this.nombre, this.completa);

  void completar();
  void descompletar();
}

@HiveType(typeId: 2)
class MetaBooleana extends Meta {
  @HiveField(2)
  double valorActual;

  @HiveField(3)
  double valorObjetivo;

  MetaBooleana(String nombre, [bool completa = false])
      : valorActual = completa ? 1 : 0,
        valorObjetivo = 1,
        super(nombre, completa);

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

@HiveType(typeId: 3)
class MetaCuantificable extends Meta {
  @HiveField(2)
  double valorActual;

  @HiveField(3)
  double valorObjetivo;

  MetaCuantificable(String nombre, this.valorObjetivo, [this.valorActual = 0])
      : super(nombre, valorActual >= valorObjetivo);

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

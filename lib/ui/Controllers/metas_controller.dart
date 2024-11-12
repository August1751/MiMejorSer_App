import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '.:/../storage/s_model.dart'; // Import the Meta classes

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

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'metas_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************


class MetaBooleanaAdapter extends TypeAdapter<MetaBooleana> {
  @override
  final int typeId = 2;

  @override
  MetaBooleana read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MetaBooleana(
      fields[0] as String,
      fields[1] as bool,
    )
      ..valorActual = fields[2] as double
      ..valorObjetivo = fields[3] as double;
  }

  @override
  void write(BinaryWriter writer, MetaBooleana obj) {
    writer
      ..writeByte(4)
      ..writeByte(2)
      ..write(obj.valorActual)
      ..writeByte(3)
      ..write(obj.valorObjetivo)
      ..writeByte(0)
      ..write(obj.nombre)
      ..writeByte(1)
      ..write(obj.completa);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MetaBooleanaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MetaCuantificableAdapter extends TypeAdapter<MetaCuantificable> {
  @override
  final int typeId = 3;

  @override
  MetaCuantificable read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MetaCuantificable(
      fields[0] as String,
      fields[3] as double,
      fields[2] as double,
    )..completa = fields[1] as bool;
  }

  @override
  void write(BinaryWriter writer, MetaCuantificable obj) {
    writer
      ..writeByte(4)
      ..writeByte(2)
      ..write(obj.valorActual)
      ..writeByte(3)
      ..write(obj.valorObjetivo)
      ..writeByte(0)
      ..write(obj.nombre)
      ..writeByte(1)
      ..write(obj.completa);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MetaCuantificableAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

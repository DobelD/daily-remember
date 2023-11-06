// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vocabulary.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VocabularyModelAdapter extends TypeAdapter<VocabularyModel> {
  @override
  final int typeId = 1;

  @override
  VocabularyModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VocabularyModel(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
      fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, VocabularyModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.verbOne)
      ..writeByte(1)
      ..write(obj.verbTwo)
      ..writeByte(2)
      ..write(obj.verbThree)
      ..writeByte(3)
      ..write(obj.verbIng);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VocabularyModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

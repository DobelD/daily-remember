// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'speaking_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SpeakingModelAdapter extends TypeAdapter<SpeakingModel> {
  @override
  final int typeId = 1;

  @override
  SpeakingModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SpeakingModel(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
      fields[3] as String,
      fields[4] as String,
      fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SpeakingModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.audioPath)
      ..writeByte(2)
      ..write(obj.duration)
      ..writeByte(3)
      ..write(obj.idTranscript)
      ..writeByte(4)
      ..write(obj.transcript)
      ..writeByte(5)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SpeakingModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

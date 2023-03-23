// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NoteModelAdapter extends TypeAdapter<NoteModel> {
  @override
  final int typeId = 0;

  @override
  NoteModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NoteModel(
      id: fields[1] as String?,
      title: fields[2] as String?,
      content: fields[3] as String?,
      createdAt: fields[4] as DateTime?,
      color: fields[5] as String?,
      isPinned: fields[6] as bool?,
      textType: fields[7] as String?,
      textSize: fields[8] as double?,
    )
      ..userId = fields[9] as String?
      ..images = (fields[10] as List?)?.cast<NoteImageModel?>()
      ..notePin = fields[11] as String?;
  }

  @override
  void write(BinaryWriter writer, NoteModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.content)
      ..writeByte(4)
      ..write(obj.createdAt)
      ..writeByte(5)
      ..write(obj.color)
      ..writeByte(6)
      ..write(obj.isPinned)
      ..writeByte(7)
      ..write(obj.textType)
      ..writeByte(8)
      ..write(obj.textSize)
      ..writeByte(9)
      ..write(obj.userId)
      ..writeByte(10)
      ..write(obj.images)
      ..writeByte(11)
      ..write(obj.notePin);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NoteModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

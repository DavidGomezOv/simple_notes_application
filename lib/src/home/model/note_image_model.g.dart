// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_image_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NoteImageModelAdapter extends TypeAdapter<NoteImageModel> {
  @override
  final int typeId = 1;

  @override
  NoteImageModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NoteImageModel(
      fields[1] as String?,
      fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, NoteImageModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(1)
      ..write(obj.imageUrl)
      ..writeByte(2)
      ..write(obj.imageName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NoteImageModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NoteImageModel _$NoteImageModelFromJson(Map<String, dynamic> json) =>
    NoteImageModel(
      json['imageUrl'] as String?,
      json['imageName'] as String?,
    );

Map<String, dynamic> _$NoteImageModelToJson(NoteImageModel instance) =>
    <String, dynamic>{
      'imageUrl': instance.imageUrl,
      'imageName': instance.imageName,
    };

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
      fields[1] as String?,
      fields[2] as String?,
      fields[3] as String?,
      fields[4] as DateTime?,
      fields[5] as String?,
      fields[6] as bool?,
      fields[7] as String?,
      fields[8] as double?,
    )
      ..userId = fields[9] as String?
      ..images = (fields[10] as List?)?.cast<NoteImageModel?>();
  }

  @override
  void write(BinaryWriter writer, NoteModel obj) {
    writer
      ..writeByte(10)
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
      ..write(obj.images);
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

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NoteModel _$NoteModelFromJson(Map<String, dynamic> json) => NoteModel(
      json['id'] as String?,
      json['title'] as String?,
      json['content'] as String?,
      NoteModel._fromJson(json['createdAt'] as Timestamp),
      json['color'] as String?,
      json['isPinned'] as bool?,
      json['textType'] as String?,
      (json['textSize'] as num?)?.toDouble(),
    )
      ..userId = json['userId'] as String?
      ..images = (json['images'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : NoteImageModel.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$NoteModelToJson(NoteModel instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'createdAt': NoteModel._toJson(instance.createdAt),
      'color': instance.color,
      'isPinned': instance.isPinned,
      'textType': instance.textType,
      'textSize': instance.textSize,
      'userId': instance.userId,
      'images': instance.images?.map((e) => e?.toJson()).toList(),
    };

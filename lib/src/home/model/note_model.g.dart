// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_model.dart';

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
      json['textSize'] as int?,
    );

Map<String, dynamic> _$NoteModelToJson(NoteModel instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'createdAt': instance.createdAt?.toIso8601String(),
      'color': instance.color,
      'isPinned': instance.isPinned,
      'textType': instance.textType,
      'textSize': instance.textSize,
    };

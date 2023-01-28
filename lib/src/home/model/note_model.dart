import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'note_model.g.dart';

@JsonSerializable(explicitToJson: true)
class NoteModel {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'title')
  final String? title;
  @JsonKey(name: 'content')
  final String? content;
  @JsonKey(
    name: 'createdAt',
    fromJson: _fromJson,
  )
  final DateTime? createdAt;
  @JsonKey(name: 'color')
  final String? color;
  @JsonKey(name: 'isPinned')
  final bool? isPinned;
  @JsonKey(name: 'textType')
  final String? textType;
  @JsonKey(name: 'textSize')
  final double? textSize;

  NoteModel(
    this.id,
    this.title,
    this.content,
    this.createdAt,
    this.color,
    this.isPinned,
    this.textType,
    this.textSize,
  );

  factory NoteModel.fromJson(Map<String, dynamic> json) =>
      _$NoteModelFromJson(json);

  Map<String, dynamic> toJson() => _$NoteModelToJson(this);

  static DateTime? _fromJson(Timestamp data) => data.toDate();

  @override
  String toString() {
    return 'NoteModel{id: $id, title: $title, content: $content, createdAt: $createdAt, color: $color, isPinned: $isPinned, textType: $textType, textSize: $textSize}';
  }
}

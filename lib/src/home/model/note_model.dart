import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'note_model.g.dart';

@HiveType(typeId: 0)
@JsonSerializable(explicitToJson: true)
class NoteModel extends HiveObject {
  @HiveField(1)
  @JsonKey(name: 'id')
  final String? id;
  @HiveField(2)
  @JsonKey(name: 'title')
  final String? title;
  @HiveField(3)
  @JsonKey(name: 'content')
  final String? content;
  @HiveField(4)
  @JsonKey(name: 'createdAt', fromJson: _fromJson, toJson: _toJson)
  final DateTime? createdAt;
  @HiveField(5)
  @JsonKey(name: 'color')
  final String? color;
  @HiveField(6)
  @JsonKey(name: 'isPinned')
  final bool? isPinned;
  @HiveField(7)
  @JsonKey(name: 'textType')
  final String? textType;
  @HiveField(8)
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

  static Timestamp _toJson(DateTime? time) => Timestamp.fromDate(time!);

  @override
  String toString() {
    return 'NoteModel{id: $id, title: $title, content: $content, createdAt: $createdAt, color: $color, isPinned: $isPinned, textType: $textType, textSize: $textSize}';
  }
}

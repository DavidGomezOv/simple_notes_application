import 'package:hive/hive.dart';
import 'package:simple_notes_application/src/home/model/note_image_model.dart';

part 'note_model.g.dart';

@HiveType(typeId: 0)
class NoteModel extends HiveObject {
  @HiveField(1)
  final String? id;
  @HiveField(2)
  final String? title;
  @HiveField(3)
  final String? content;
  @HiveField(4)
  final DateTime? createdAt;
  @HiveField(5)
  final String? color;
  @HiveField(6)
  final bool? isPinned;
  @HiveField(7)
  final String? textType;
  @HiveField(8)
  final double? textSize;
  @HiveField(9)
  String? userId;
  @HiveField(10)
  List<NoteImageModel?>? images;
  @HiveField(11)
  String? notePin;

  NoteModel({
    this.id,
    this.title,
    this.content,
    this.createdAt,
    this.color,
    this.isPinned,
    this.textType,
    this.textSize,
  });

  @override
  String toString() {
    return 'NoteModel{id: $id, title: $title, content: $content, createdAt: $createdAt, color: $color, isPinned: $isPinned, textType: $textType, textSize: $textSize}';
  }
}

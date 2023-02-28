import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'note_image_model.g.dart';

@HiveType(typeId: 1)
@JsonSerializable(explicitToJson: true)
class NoteImageModel extends HiveObject {
  @HiveField(1)
  @JsonKey(name: 'imageUrl')
  final String? imageUrl;
  @HiveField(2)
  @JsonKey(name: 'imageName')
  final String? imageName;

  NoteImageModel(
    this.imageUrl,
    this.imageName,
  );

  factory NoteImageModel.fromJson(Map<String, dynamic> json) =>
      _$NoteImageModelFromJson(json);

  Map<String, dynamic> toJson() => _$NoteImageModelToJson(this);

  @override
  String toString() {
    return 'NoteImageModel{imageUrl: $imageUrl, imageName: $imageName}';
  }
}

import 'package:hive/hive.dart';

part 'note_image_model.g.dart';

@HiveType(typeId: 1)
class NoteImageModel extends HiveObject {
  @HiveField(1)
  final String? imageUrl;
  @HiveField(2)
  final String? imageName;

  NoteImageModel(
    this.imageUrl,
    this.imageName,
  );

  @override
  String toString() {
    return 'NoteImageModel{imageUrl: $imageUrl, imageName: $imageName}';
  }
}

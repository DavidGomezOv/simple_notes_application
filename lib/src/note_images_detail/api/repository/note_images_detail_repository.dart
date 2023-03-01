import 'dart:io';
import 'dart:typed_data';

import 'package:injectable/injectable.dart';
import 'package:simple_notes_application/src/note_images_detail/api/datasource/note_images_detail_firestore_source.dart';

@injectable
class NoteImagesDetailRepository {
  final NoteImagesDetailFirestoreSource _datasource;

  @factoryMethod
  NoteImagesDetailRepository.from(this._datasource);

  Future<Uint8List> downloadImage(String noteModelId, String imageName) {
    return _datasource.downloadImage(noteModelId, imageName);
  }
}

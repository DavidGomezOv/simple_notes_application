import 'dart:io';
import 'dart:typed_data';

import 'package:injectable/injectable.dart';
import 'package:simple_notes_application/src/core/base/base_reactive_service.dart';
import 'package:simple_notes_application/src/note_images_detail/api/repository/note_images_detail_repository.dart';

@lazySingleton
class NoteImagesDetailService extends BaseReactiveService {
  final NoteImagesDetailRepository _repository;

  @factoryMethod
  NoteImagesDetailService.from(this._repository) {
    listenToReactiveValues([
      loadingReactiveValue,
    ]);
  }

  Future<Uint8List> downloadImage(String noteModelId, String imageName) {
    loadingReactiveValue.value = true;
    return _repository
        .downloadImage(noteModelId, imageName)
        .whenComplete(() => loadingReactiveValue.value = false);
  }
}

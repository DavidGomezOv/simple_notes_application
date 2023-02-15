import 'dart:io';
import 'dart:ui';

import 'package:injectable/injectable.dart';
import 'package:simple_notes_application/src/core/base/base_reactive_service.dart';
import 'package:simple_notes_application/src/core/constants/constants.dart';
import 'package:simple_notes_application/src/core/enums/enums.dart';
import 'package:simple_notes_application/src/core/extensions/generic_extensions.dart';
import 'package:simple_notes_application/src/home/model/note_model.dart';
import 'package:simple_notes_application/src/note_detail/api/respository/note_detail_repository.dart';
import 'package:stacked/stacked.dart';

@lazySingleton
class NoteDetailService extends BaseReactiveService {
  final NoteDetailRepository _repository;

  final colorValue =
      ReactiveValue<Color>(HexColor.fromHex(CustomColors.colorBlack74));
  final isNotePinned = ReactiveValue<bool>(false);
  final isButtonAvailable = ReactiveValue<bool>(false);
  final textSize = ReactiveValue<double>(18);
  final createdDate = ReactiveValue<DateTime>(DateTime.now());
  final textType = ReactiveValue<TextType>(TextType.normal);
  final imageList = ReactiveValue<List<File?>>([]);

  @factoryMethod
  NoteDetailService.from(this._repository) {
    listenToReactiveValues([
      loadingReactiveValue,
      colorValue,
      isNotePinned,
      isButtonAvailable,
      textSize,
      createdDate,
      textType,
      imageList,
    ]);
  }

  resetValues() {
    colorValue.value = HexColor.fromHex(CustomColors.colorBlack74);
    isNotePinned.value = false;
    isButtonAvailable.value = false;
    textSize.value = 18;
    createdDate.value = DateTime.now();
    textType.value = TextType.normal;
    imageList.value = [];
    loadingReactiveValue.value = false;
  }

  Future<void> createNote(NoteModel noteModel) async {
    loadingReactiveValue.value = true;
    return _repository
        .createNote(noteModel)
        .whenComplete(() => loadingReactiveValue.value = false);
  }

  Future<void> deleteNote(String noteId) async {
    loadingReactiveValue.value = true;
    return _repository
        .deleteNote(noteId)
        .whenComplete(() => loadingReactiveValue.value = false);
  }
}

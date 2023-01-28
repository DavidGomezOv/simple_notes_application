import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simple_notes_application/src/core/base/base_view_model.dart';
import 'package:simple_notes_application/src/core/constants/constants.dart';
import 'package:simple_notes_application/src/core/di/app_component.dart';
import 'package:simple_notes_application/src/core/enums/enums.dart';
import 'package:simple_notes_application/src/core/extensions/generic_extensions.dart';
import 'package:simple_notes_application/src/create_note/services/note_detail_service.dart';
import 'package:simple_notes_application/src/home/model/note_model.dart';
import 'package:simple_notes_application/src/home/services/home_service.dart';
import 'package:stacked/stacked.dart';

class NoteDetailViewModel extends AppBaseViewModel {
  final _homeService = locator<HomeService>();
  final _noteDetailService = locator<NoteDetailService>();

  bool get loading => _homeService.loadingReactiveValue.value;

  Color get noteColor => _noteDetailService.colorValue.value;

  NoteModel? get noteSelected => _homeService.noteSelectedValue.value;

  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  bool isPinned = false;
  TextType textType = TextType.normal;
  double textSize = 18;
  String? createdDate;

  NoteDetailViewModel() {
    loadNoteModel();
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [
        _homeService,
        _noteDetailService,
      ];

  void loadNoteModel() {
    titleController.text = noteSelected?.title ?? '';
    contentController.text = noteSelected?.content ?? '';
    createdDate = DateFormat('MMM d, yyyy - h:mm aaa')
        .format(noteSelected?.createdAt ?? DateTime.now());
    _noteDetailService.colorValue.value =
        HexColor.fromHex(noteSelected?.color ?? CustomColors.colorBlack74);
  }

  void onTitleChanged(String title) {}

  void onContentChanged(String title) {}

  void onTextTypeChanged(TextType textTypeSelected) {
    if (textType == TextType.bold) {
      textType = TextType.normal;
    } else if (textType == TextType.italic) {
      textType = TextType.italicBold;
    } else if (textType == TextType.italicBold) {
      textType = TextType.italic;
    } else {
      textType = TextType.bold;
    }
  }

  void onTextSizeChanged(bool increaseSize) {
    if (increaseSize) {
      if (textSize < 30) {
        textSize += 1;
      }
    } else {
      if (textSize > 10) {
        textSize -= 1;
      }
    }
  }

  void onNoteColorChanged(Color color) {
    _noteDetailService.colorValue.value = color;
  }

  void deleteNote() {}

  void saveNote() {}
}

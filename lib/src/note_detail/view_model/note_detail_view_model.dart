import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simple_notes_application/routes.dart';
import 'package:simple_notes_application/src/core/base/base_view_model.dart';
import 'package:simple_notes_application/src/core/constants/constants.dart';
import 'package:simple_notes_application/src/core/di/app_component.dart';
import 'package:simple_notes_application/src/core/enums/enums.dart';
import 'package:simple_notes_application/src/core/extensions/generic_extensions.dart';
import 'package:simple_notes_application/src/core/utils/app_dialogs.dart';
import 'package:simple_notes_application/src/home/model/note_image_model.dart';
import 'package:simple_notes_application/src/home/model/note_model.dart';
import 'package:simple_notes_application/src/home/services/home_service.dart';
import 'package:simple_notes_application/src/note_detail/services/note_detail_service.dart';
import 'package:stacked/stacked.dart';

class NoteDetailViewModel extends AppBaseViewModel {
  final _homeService = locator<HomeService>();
  final _noteDetailService = locator<NoteDetailService>();

  bool get loading => _noteDetailService.loadingReactiveValue.value;

  Color get noteColor => _noteDetailService.colorValue.value;

  bool get isNotePinned => _noteDetailService.isNotePinned.value;

  bool get isButtonAvailable => _noteDetailService.isButtonAvailable.value;

  double get textSize => _noteDetailService.textSize.value;

  DateTime get createdDate => _noteDetailService.createdDate.value;

  TextType get textType => _noteDetailService.textType.value;

  NoteModel? get noteSelected => _homeService.noteSelectedValue.value;

  List<File?> get images => _noteDetailService.imageList.value;

  List<NoteImageModel?> get remoteImages =>
      _noteDetailService.remoteImageList.value;

  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  Timer? timer;

  bool isUpdate = false;

  final BuildContext context;

  NoteDetailViewModel(this.context) {
    _noteDetailService.resetValues();
    loadNoteModel();
    initTimer();
  }

  @override
  List<ListenableServiceMixin> get listenableServices => [
        _homeService,
        _noteDetailService,
      ];

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future pickImages() async {
    showInformativeDialog(
      title: Messages.selectImagesTitle,
      message: Messages.selectImagesMessages,
      primaryButtonLabel: Messages.galleryLabel,
      primaryClick: () => getImages(ImageSource.gallery),
      secondaryButtonLabel: Messages.cameraLabel,
      secondaryClick: () => getImages(ImageSource.camera),
    );
  }

  void getImages(ImageSource imageSource) async {
    _noteDetailService.loadingReactiveValue.value = true;
    late List<XFile?> image = [];
    if (imageSource == ImageSource.gallery) {
      image = await ImagePicker().pickMultiImage();
    } else {
      image = [await ImagePicker().pickImage(source: imageSource)];
    }
    _noteDetailService.loadingReactiveValue.value = false;
    if (image.isEmpty) return;

    for (var element in image) {
      if (element == null) continue;
      _noteDetailService.imageList.value.add(File(element.path));
    }

    if (titleController.text.isNotEmpty && contentController.text.isNotEmpty) {
      _noteDetailService.isButtonAvailable.value = true;
    } else {
      _noteDetailService.isButtonAvailable.value = false;
    }
  }

  void removeImage(int index, {bool isRemote = false}) async {
    _noteDetailService.loadingReactiveValue.value = true;
    if (isRemote) {
      _noteDetailService.remoteImageList.value.removeAt(index);
      if (noteSelected!.images != _noteDetailService.remoteImageList.value) {
        _noteDetailService.isButtonAvailable.value = true;
      } else {
        _noteDetailService.isButtonAvailable.value = false;
      }
    } else {
      _noteDetailService.imageList.value.removeAt(index);
      if (_noteDetailService.imageList.value.isEmpty) {
        _noteDetailService.isButtonAvailable.value = false;
      }
    }
    _noteDetailService.loadingReactiveValue.value = false;
  }

  void loadNoteModel() {
    if (noteSelected != null) {
      isUpdate = true;
    }
    _noteDetailService.textSize.value = noteSelected?.textSize ?? 18;
    titleController.text = noteSelected?.title ?? '';
    contentController.text = noteSelected?.content ?? '';
    _noteDetailService.createdDate.value =
        noteSelected?.createdAt ?? DateTime.now();
    _noteDetailService.colorValue.value =
        HexColor.fromHex(noteSelected?.color ?? CustomColors.colorBlack74);
    _noteDetailService.isNotePinned.value = noteSelected?.isPinned ?? false;
    _noteDetailService.textType.value =
        stringToEnum(noteSelected?.textType) ?? TextType.normal;
    loadNoteImages();
  }

  void loadNoteImages() {
    noteSelected?.images?.forEach((element) {
      if (element != null) {
        _noteDetailService.remoteImageList.value.add(element);
      }
    });
  }

  void initTimer() {
    if (isUpdate) return;
    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      _noteDetailService.createdDate.value = DateTime.now();
    });
  }

  void validateButton() {
    if (isUpdate) {
      validateUpdateNote();
    } else {
      validateNewNote();
    }
  }

  void validateUpdateNote() {
    if ((titleController.text.isNotEmpty &&
            contentController.text.isNotEmpty) &&
        (titleController.text != noteSelected!.title ||
            contentController.text != noteSelected!.content ||
            noteColor.toHex() != noteSelected!.color ||
            textSize != noteSelected!.textSize ||
            isNotePinned != noteSelected!.isPinned ||
            textType.asString() != noteSelected!.textType)) {
      _noteDetailService.isButtonAvailable.value = true;
    } else {
      _noteDetailService.isButtonAvailable.value = false;
    }
  }

  void validateNewNote() {
    if (_noteDetailService.imageList.value.isNotEmpty) {
      if (titleController.text.isNotEmpty &&
          contentController.text.isNotEmpty) {
        _noteDetailService.isButtonAvailable.value = true;
      } else {
        _noteDetailService.isButtonAvailable.value = false;
      }
    } else if (titleController.text.isNotEmpty &&
        contentController.text.isNotEmpty) {
      _noteDetailService.isButtonAvailable.value = true;
    } else {
      _noteDetailService.isButtonAvailable.value = false;
    }
  }

  void onTextTypeChanged(TextType textTypeSelected) {
    if (textType == TextType.italicBold && textTypeSelected == TextType.bold) {
      _noteDetailService.textType.value = TextType.italic;
    } else if (textType == TextType.italicBold &&
        textTypeSelected == TextType.italic) {
      _noteDetailService.textType.value = TextType.bold;
    } else if ((textType == TextType.bold &&
            textTypeSelected == TextType.italic) ||
        (textType == TextType.italic && textTypeSelected == TextType.bold)) {
      _noteDetailService.textType.value = TextType.italicBold;
    } else {
      _noteDetailService.textType.value = textTypeSelected;
    }
    validateButton();
  }

  void onTextSizeChanged(bool increaseSize) {
    if (increaseSize) {
      if (textSize < 30) {
        _noteDetailService.textSize.value += 1;
        validateButton();
      }
    } else {
      if (textSize > 10) {
        _noteDetailService.textSize.value -= 1;
        validateButton();
      }
    }
  }

  void onNoteColorChanged(Color color) {
    _noteDetailService.colorValue.value = color;
    validateButton();
  }

  void deleteNote() {
    showInformativeDialog(
      title: Messages.informationLabel,
      message: Messages.deleteNoteMessage,
      primaryClick: () {
        _noteDetailService
            .deleteNote(noteSelected!.id!)
            .then((value) => appNavigator.back())
            .catchError((error) {
          handleApiResponse(error.toString());
        });
      },
    );
  }

  void pinNote() {
    _noteDetailService.isNotePinned.value = !isNotePinned;
    if (isUpdate) saveNote(needGoBack: false);
  }

  void saveNote({bool needGoBack = true}) {
    FocusScope.of(context).requestFocus(FocusNode());
    final note = NoteModel(
      noteSelected?.id ?? DateTime.now().toString(),
      titleController.text.toString(),
      contentController.text.toString(),
      createdDate,
      noteColor.toHex(),
      isNotePinned,
      textType.asString(),
      textSize,
    );
    note.images = _noteDetailService.remoteImageList.value;
    _noteDetailService.createNote(note, images).then((value) {
      if (needGoBack) appNavigator.back();
    }).catchError((error) {
      handleApiResponse(error.toString());
    });
  }

  void onImageTap(String imagePath, int position) {
    _noteDetailService.imageSelected.value = position;
    appNavigator.push(Routes.imagesDetail);
  }
}

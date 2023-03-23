import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:local_auth/local_auth.dart';
import 'package:stacked/stacked.dart';
import 'package:simple_notes_application/routes.dart';
import 'package:simple_notes_application/src/core/base/base_view_model.dart';
import 'package:simple_notes_application/src/core/constants/constants.dart';
import 'package:simple_notes_application/src/core/constants/strings.dart';
import 'package:simple_notes_application/src/core/di/app_component.dart';
import 'package:simple_notes_application/src/core/enums/enums.dart';
import 'package:simple_notes_application/src/core/extensions/generic_extensions.dart';
import 'package:simple_notes_application/src/core/utils/app_dialogs.dart';
import 'package:simple_notes_application/src/home/model/note_image_model.dart';
import 'package:simple_notes_application/src/home/model/note_model.dart';
import 'package:simple_notes_application/src/home/services/home_service.dart';
import 'package:simple_notes_application/src/note_detail/services/note_detail_service.dart';

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

  bool get isExpandedImages => _noteDetailService.expandedImages.value;

  void changeExpandedImages(bool isExpanded) =>
      _noteDetailService.expandedImages.value = isExpanded;

  bool get isProtected => _noteDetailService.isProtected.value;

  bool get isLocked => _noteDetailService.isLocked.value;

  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  Timer? timer;

  bool isUpdate = false;

  String? notePin;

  final BuildContext context;

  NoteDetailViewModel(this.context) : super(context) {
    if (noteSelected != null) {
      isUpdate = true;
    }
    _noteDetailService.resetValues();
    validateLockedNote();
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

  Future<void> validateLockedNote() async {
    if (isUpdate && noteSelected!.notePin != null) {
      final LocalAuthentication auth = LocalAuthentication();
      bool didAuthenticate = false;
      try {
        didAuthenticate = await auth.authenticate(
            localizedReason: AppStrings().authReason,
            options: const AuthenticationOptions(biometricOnly: true));
        if (didAuthenticate == true) {
          _noteDetailService.isLocked.value = false;
        }
      } catch (e) {
        showInputPinDialog(
          context: context,
          title: AppStrings().unlockNoteDialogTitle,
          message: AppStrings().unlockNoteDialogLabel,
          acceptClick: (pin) async {
            if (pin != null && pin == noteSelected!.notePin) {
              _noteDetailService.isLocked.value = false;
            } else {
              handleApiResponse(
                AppStrings().incorrectNotePin,
              );
            }
          },
          cancelClick: () => appNavigator.back(),
        );
      }
    } else {
      _noteDetailService.isLocked.value = false;
    }
  }

  void loadNoteModel() {
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
    _noteDetailService.isProtected.value = noteSelected?.notePin != null;
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

  Future pickImages() async {
    showInformativeDialog(
      title: AppStrings().selectImagesTitle,
      message: AppStrings().selectImagesMessages,
      primaryButtonLabel: AppStrings().galleryLabel,
      primaryClick: () => getImages(ImageSource.gallery),
      secondaryButtonLabel: AppStrings().cameraLabel,
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
    if (image.isEmpty || (image[0] == null)) return;

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
      if (textSize < 28) {
        _noteDetailService.textSize.value += 1;
        validateButton();
      }
    } else {
      if (textSize > 12) {
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
      title: AppStrings().informationLabel,
      message: AppStrings().deleteNoteMessage,
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

  void lockNote() {
    _noteDetailService.isProtected.value =
        !_noteDetailService.isProtected.value;
    if (isProtected) {
      showInputPinDialog(
          context: context,
          title: AppStrings().pinNoteDialogTitle,
          message: AppStrings().pinNoteDialogLabel,
          acceptClick: (pin) {
            notePin = pin;
            if (isUpdate) saveNote(needGoBack: false);
          },
          cancelClick: () {
            _noteDetailService.isProtected.value =
                !_noteDetailService.isProtected.value;
          });
    } else {
      notePin = null;
      if (isUpdate) saveNote(needGoBack: false);
    }
  }

  void saveNote({bool needGoBack = true}) {
    FocusScope.of(context).requestFocus(FocusNode());
    final note = NoteModel(
      id: noteSelected?.id ?? DateTime.now().toString(),
      title: titleController.text.toString(),
      content: contentController.text.toString(),
      createdAt: createdDate,
      color: noteColor.toHex(),
      isPinned: isNotePinned,
      textType: textType.asString(),
      textSize: textSize,
    );
    note.images = _noteDetailService.remoteImageList.value;
    note.notePin = notePin;
    _noteDetailService.createNote(note, images).then((value) {
      if (needGoBack) appNavigator.back();
    }).catchError((error) {
      handleApiResponse(error.toString());
    });
  }

  void onImageTap(String imagePath, int position) {
    if (noteSelected != null &&
        (noteSelected!.images != null && noteSelected!.images!.isNotEmpty)) {
      _noteDetailService.imageSelected.value = position;
      appNavigator.push(Routes.imagesDetail);
    }
  }
}

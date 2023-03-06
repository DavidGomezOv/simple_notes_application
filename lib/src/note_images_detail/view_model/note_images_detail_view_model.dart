import 'dart:io';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:simple_notes_application/src/core/base/base_view_model.dart';
import 'package:simple_notes_application/src/core/constants/constants.dart';
import 'package:simple_notes_application/src/core/constants/strings.dart';
import 'package:simple_notes_application/src/core/di/app_component.dart';
import 'package:simple_notes_application/src/core/enums/enums.dart';
import 'package:simple_notes_application/src/core/utils/app_dialogs.dart';
import 'package:simple_notes_application/src/home/model/note_image_model.dart';
import 'package:simple_notes_application/src/home/model/note_model.dart';
import 'package:simple_notes_application/src/home/services/home_service.dart';
import 'package:simple_notes_application/src/note_detail/services/note_detail_service.dart';
import 'package:simple_notes_application/src/note_images_detail/services/note_images_detail_service.dart';
import 'package:stacked/stacked.dart';

class NoteImagesDetailViewModel extends AppBaseViewModel {
  final _noteDetailService = locator<NoteDetailService>();
  final _noteImagesService = locator<NoteImagesDetailService>();
  final _homeService = locator<HomeService>();

  int get position => _noteDetailService.imageSelected.value;

  bool get loading => _noteImagesService.loadingReactiveValue.value;

  NoteModel get noteSelected => _homeService.noteSelectedValue.value!;

  List<NoteImageModel?> get remoteImages =>
      _noteDetailService.remoteImageList.value;

  late List<TransformationController> transformationControllerList = [];

  final carouselController = CarouselController();

  final BuildContext context;

  NoteImagesDetailViewModel(this.context) : super(context) {
    initControllers();
    carouselController.onReady.then(
      (value) => carouselController.jumpToPage(position),
    );
  }

  @override
  List<ListenableServiceMixin> get listenableServices => [
        _noteDetailService,
        _noteImagesService,
      ];

  void initControllers() {
    for (var element in remoteImages) {
      transformationControllerList.add(TransformationController());
    }
  }

  void onPageChanged(int index) {
    _noteDetailService.imageSelected.value = index;
  }

  Future<void> downloadImage() async {
    showInformativeDialog(
      title: AppStrings().selectImagesTitle,
      message: AppStrings().downloadImagesOptionMessages,
      primaryButtonLabel: AppStrings().downloadThisImage,
      primaryClick: () => downloadImages(DownloadType.one),
      secondaryButtonLabel: AppStrings().downloadAllImages,
      secondaryClick: () => downloadImages(DownloadType.all),
    );
  }

  Future<void> downloadImages(DownloadType type) async {
    if (type == DownloadType.one) {
      getFile(remoteImages[position]!).then((value) async {
        saveFile(
          '${noteSelected.title}-${remoteImages[position]!.imageName!}',
          value,
          remoteImages[position]!.imageUrl!.contains('https'),
          noteSelected.id!,
        ).then(
          (value) => showSnackBar(AppStrings().downloadImageConfirmation),
        );
      }).catchError((error) {
        handleApiResponse(error.toString());
      });
    } else {
      for (var element in remoteImages) {
        try {
          final imageData = await getFile(element!);
          await saveFile(
            '${noteSelected.title}-${element.imageName!}',
            imageData,
            remoteImages[position]!.imageUrl!.contains('https'),
            noteSelected.id!,
          ).then((value) {
            if (remoteImages.last == element) {
              showSnackBar(AppStrings().downloadImagesConfirmation);
            }
          });
        } catch (exception) {
          handleApiResponse(exception.toString());
          break;
        }
      }
    }
  }

  Future<dynamic> getFile(NoteImageModel imageSelected) async {
    if (imageSelected.imageUrl!.contains('https')) {
      final data = await _noteImagesService.downloadImage(
        noteSelected.id!,
        imageSelected.imageName!,
      );
      return data;
    } else {
      return File(imageSelected.imageUrl!);
    }
  }

  Future<bool?> saveFile(
      String name, dynamic file, bool isRemote, String noteModelId) async {
    try {
      late File fileToSave;
      if (isRemote) {
        final directory = await getApplicationDocumentsDirectory();
        final Directory appDocDirFolder =
        Directory('${directory.path}/$noteModelId');
        final imageData = File.fromRawPath(file as Uint8List);
        fileToSave = await imageData.copy('${appDocDirFolder.path}/$name');
      } else {
        fileToSave = file as File;
      }
      return GallerySaver.saveImage(fileToSave.path,
          albumName: 'Simple Notes Images');
    } catch (exception) {
      throw (exception.toString());
    }
  }
}

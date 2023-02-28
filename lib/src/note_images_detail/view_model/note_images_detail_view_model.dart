import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:simple_notes_application/src/core/base/base_view_model.dart';
import 'package:simple_notes_application/src/core/di/app_component.dart';
import 'package:simple_notes_application/src/home/model/note_image_model.dart';
import 'package:simple_notes_application/src/note_detail/services/note_detail_service.dart';
import 'package:stacked/stacked.dart';

class NoteImagesDetailViewModel extends AppBaseViewModel {
  final _noteDetailService = locator<NoteDetailService>();

  int get position => _noteDetailService.imageSelected.value;

  List<NoteImageModel?> get remoteImages =>
      _noteDetailService.remoteImageList.value;

  late List<TransformationController> transformationControllerList = [];

  final carouselController = CarouselController();

  NoteImagesDetailViewModel() {
    initControllers();
    carouselController.onReady.then(
      (value) => carouselController.jumpToPage(position),
    );
  }

  @override
  List<ListenableServiceMixin> get listenableServices => [
    _noteDetailService,
  ];

  void initControllers() {
    for (var element in remoteImages) {
      transformationControllerList.add(TransformationController());
    }
  }

  void onPageChanged(int index) {
    _noteDetailService.imageSelected.value = index;
  }

  void downloadImage() {

  }
}

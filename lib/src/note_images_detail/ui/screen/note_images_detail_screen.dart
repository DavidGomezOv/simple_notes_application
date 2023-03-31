import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:simple_notes_application/src/core/constants/constants.dart';
import 'package:simple_notes_application/src/core/constants/strings.dart';
import 'package:simple_notes_application/src/core/extensions/generic_extensions.dart';
import 'package:simple_notes_application/src/note_images_detail/ui/widgets/note_images_list_dots_widget.dart';
import 'package:simple_notes_application/src/note_images_detail/ui/widgets/note_images_list_item.dart';
import 'package:simple_notes_application/src/note_images_detail/view_model/note_images_detail_view_model.dart';
import 'package:stacked/stacked.dart';

class NoteImagesDetailScreen extends StatelessWidget {
  const NoteImagesDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NoteImagesDetailViewModel>.reactive(
      viewModelBuilder: () => NoteImagesDetailViewModel(context),
      builder: (context, viewModel, child) => SafeArea(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(AppStrings().noteDetailImageTitle),
            actions: [
              MaterialButton(
                visualDensity: VisualDensity.compact,
                minWidth: 65,
                height: 50,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                onPressed: viewModel.downloadImage,
                child: const Icon(
                  Icons.arrow_downward,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          body: Stack(
            children: [
              Container(
                color: HexColor.fromHex(CustomColors.colorBlack74),
                child: CarouselSlider.builder(
                  carouselController: viewModel.carouselController,
                  itemCount: viewModel.remoteImages.length,
                  itemBuilder: (context, index, realIndex) =>
                      NoteImagesListItem(index: index),
                  options: CarouselOptions(
                    height: MediaQuery.of(context).size.height,
                    viewportFraction: 1.0,
                    enlargeCenterPage: true,
                    enableInfiniteScroll: false,
                    onPageChanged: (index, carouselReason) =>
                        viewModel.onPageChanged(index),
                  ),
                ),
              ),
              const NoteImagesListDotsWidget(),
              Visibility(
                visible: viewModel.loading,
                child: Container(
                  width: double.maxFinite,
                  height: double.maxFinite,
                  color: Colors.black.withAlpha(70),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

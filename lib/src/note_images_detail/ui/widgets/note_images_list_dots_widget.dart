import 'package:flutter/material.dart';
import 'package:simple_notes_application/src/note_images_detail/view_model/note_images_detail_view_model.dart';
import 'package:stacked/stacked.dart';

class NoteImagesListDotsWidget
    extends ViewModelWidget<NoteImagesDetailViewModel> {
  const NoteImagesListDotsWidget({super.key});

  @override
  Widget build(BuildContext context, NoteImagesDetailViewModel viewModel) =>
      Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: List<Widget>.generate(
              viewModel.remoteImages.length,
              (index) => Padding(
                padding: const EdgeInsets.all(8),
                child: AnimatedContainer(
                  width: index == viewModel.position ? 16 : 10,
                  height: index == viewModel.position ? 16 : 10,
                  duration: const Duration(milliseconds: 150),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: index == viewModel.position
                        ? Colors.white
                        : Colors.grey,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}

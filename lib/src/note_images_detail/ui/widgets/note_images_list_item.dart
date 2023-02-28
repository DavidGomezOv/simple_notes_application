import 'dart:io';

import 'package:flutter/material.dart';
import 'package:simple_notes_application/src/note_images_detail/view_model/note_images_detail_view_model.dart';
import 'package:stacked/stacked.dart';

class NoteImagesListItem extends ViewModelWidget<NoteImagesDetailViewModel> {
  final int index;

  const NoteImagesListItem({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context, NoteImagesDetailViewModel viewModel) =>
      InteractiveViewer(
        transformationController: viewModel.transformationControllerList[index],
        maxScale: 4.0,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: viewModel.remoteImages[index]!.imageUrl!.contains('https')
                ? Image.network(viewModel.remoteImages[index]!.imageUrl!)
                : Image.file(File(viewModel.remoteImages[index]!.imageUrl!)),
          ),
        ),
      );
}

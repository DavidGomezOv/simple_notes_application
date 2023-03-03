import 'dart:io';

import 'package:flutter/material.dart';
import 'package:simple_notes_application/src/note_detail/ui/widgets/note_detail_image_remove_widget.dart';
import 'package:simple_notes_application/src/note_detail/view_model/note_detail_view_model.dart';
import 'package:stacked/stacked.dart';

class NoteDetailImagesWidget extends ViewModelWidget<NoteDetailViewModel> {
  const NoteDetailImagesWidget({super.key});

  @override
  Widget build(BuildContext context, NoteDetailViewModel viewModel) {
    return SizedBox(
      height: 280,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: viewModel.remoteImages.length,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              itemBuilder: (context, index) {
                return SizedBox(
                  width: 280,
                  height: 280,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onTap: () => viewModel.onImageTap(
                            viewModel.remoteImages[index]!.imageUrl!,
                            index,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: viewModel.remoteImages[index]!.imageUrl!
                                    .contains('https')
                                ? Image.network(
                                    viewModel.remoteImages[index]!.imageUrl!,
                                    width: 240,
                                    height: 240,
                                    fit: BoxFit.cover,
                                  )
                                : Image.file(
                                    File(viewModel
                                        .remoteImages[index]!.imageUrl!),
                                    width: 240,
                                    height: 240,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                      ),
                      NoteDetailImageRemoveWidget(
                        index: index,
                        isRemote: true,
                      ),
                    ],
                  ),
                );
              },
            ),
            ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: viewModel.images.length,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              itemBuilder: (context, index) {
                return SizedBox(
                  width: 280,
                  height: 280,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onTap: () => viewModel.onImageTap(
                            viewModel.images[index]!.path,
                            index,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: Image.file(
                              viewModel.images[index]!,
                              width: 240,
                              height: 240,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      NoteDetailImageRemoveWidget(
                        index: index,
                        isRemote: false,
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

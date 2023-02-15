import 'package:flutter/material.dart';
import 'package:simple_notes_application/src/note_detail/view_model/note_detail_view_model.dart';
import 'package:stacked/stacked.dart';

class NoteDetailImagesWidget extends ViewModelWidget<NoteDetailViewModel> {
  const NoteDetailImagesWidget({super.key});

  @override
  Widget build(BuildContext context, NoteDetailViewModel viewModel) {
    return SizedBox(
      height: 280,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: viewModel.images.length,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        itemBuilder: (context, index) => SizedBox(
          width: 280,
          height: 280,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
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
              Align(
                alignment: Alignment.topRight,
                child: MaterialButton(
                  visualDensity: VisualDensity.compact,
                  minWidth: 60,
                  height: 50,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  onPressed: () => viewModel.removeImage(index),
                  child: const Icon(
                    Icons.cancel,
                    color: Colors.red,
                    size: 30,
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

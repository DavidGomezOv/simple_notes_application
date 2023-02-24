import 'package:flutter/material.dart';
import 'package:simple_notes_application/src/note_detail/view_model/note_detail_view_model.dart';
import 'package:stacked/stacked.dart';

class NoteDetailImageRemoveWidget extends ViewModelWidget<NoteDetailViewModel> {
  final int index;

  const NoteDetailImageRemoveWidget({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context, NoteDetailViewModel viewModel) {
    return Align(
      alignment: Alignment.topRight,
      child: MaterialButton(
        visualDensity: VisualDensity.compact,
        minWidth: 60,
        height: 50,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        onPressed: () => viewModel.removeImage(index, isRemote: true),
        child: const Icon(
          Icons.cancel,
          color: Colors.red,
          size: 30,
        ),
      ),
    );
  }
}

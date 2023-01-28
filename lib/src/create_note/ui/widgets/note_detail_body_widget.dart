import 'package:flutter/material.dart';
import 'package:simple_notes_application/src/create_note/view_model/note_detail_view_model.dart';
import 'package:simple_notes_application/src/core/extensions/string_extensions.dart';
import 'package:stacked/stacked.dart';

class NoteDetailBodyWidget extends ViewModelWidget<NoteDetailViewModel> {
  const NoteDetailBodyWidget({super.key});

  @override
  Widget build(BuildContext context, NoteDetailViewModel viewModel) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: TextField(
          controller: viewModel.contentController,
          decoration: InputDecoration.collapsed(
              hintText: 'Note',
              hintStyle: TextStyle(
                  fontSize: viewModel.noteSelected?.textSize ?? 18.0,
                  color: Colors.white)),
          style: TextStyle(
              color: Colors.white,
              fontSize: viewModel.noteSelected?.textSize ?? 18.0,
              fontStyle: viewModel.noteSelected?.textType?.getFontStyle(),
              fontWeight: viewModel.noteSelected?.textType?.getFontWeight()),
          cursorColor: Colors.white,
          maxLines: null,
          expands: true,
          onChanged: viewModel.onContentChanged,
        ),
      ),
    );
  }
}

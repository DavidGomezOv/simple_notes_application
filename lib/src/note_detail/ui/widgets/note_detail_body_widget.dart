import 'package:flutter/material.dart';
import 'package:simple_notes_application/src/core/constants/constants.dart';
import 'package:simple_notes_application/src/core/constants/strings.dart';
import 'package:simple_notes_application/src/core/extensions/generic_extensions.dart';
import 'package:simple_notes_application/src/core/extensions/string_extensions.dart';
import 'package:simple_notes_application/src/note_detail/view_model/note_detail_view_model.dart';
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
              hintText: AppStrings().noteLabel,
              hintStyle: TextStyle(
                  fontSize: viewModel.textSize, color: Colors.white38)),
          style: TextStyle(
              color: Colors.white,
              fontSize: viewModel.textSize,
              fontStyle: viewModel.textType.asString().getFontStyle(),
              fontWeight: viewModel.textType.asString().getFontWeight()),
          cursorColor: Colors.white,
          maxLines: null,
          expands: true,
          onChanged: (value) => viewModel.validateButton(),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:simple_notes_application/src/core/constants/constants.dart';
import 'package:simple_notes_application/src/core/di/app_component.dart';
import 'package:simple_notes_application/src/core/extensions/generic_extensions.dart';
import 'package:simple_notes_application/src/note_detail/view_model/note_detail_view_model.dart';
import 'package:stacked/stacked.dart';

class NoteDetailTopBarWidget extends ViewModelWidget<NoteDetailViewModel> {
  const NoteDetailTopBarWidget({super.key});

  @override
  Widget build(BuildContext context, NoteDetailViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              appNavigator.back();
            },
          ),
          Expanded(
            child: TextField(
              controller: viewModel.titleController,
              decoration: InputDecoration.collapsed(
                hintText: 'Title',
                hintStyle: TextStyle(
                  fontSize: 24,
                  color: HexColor.fromHex(CustomColors.colorWhite38),
                ),
              ),
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w500),
              cursorColor: Colors.white,
              onChanged: (value) => viewModel.validateButton(),
            ),
          ),
          MaterialButton(
            visualDensity: VisualDensity.compact,
            minWidth: 60,
            height: 50,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            onPressed: viewModel.pinNote,
            child: Transform.rotate(
              angle: viewModel.isNotePinned ? 0 : .8,
              child: Icon(
                Icons.push_pin,
                color: viewModel.isNotePinned
                    ? Colors.white
                    : HexColor.fromHex(CustomColors.colorWhite84),
              ),
            ),
          ),
          viewModel.isUpdate
              ? MaterialButton(
                  visualDensity: VisualDensity.compact,
                  minWidth: 60,
                  height: 50,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  onPressed: viewModel.deleteNote,
                  child: const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}

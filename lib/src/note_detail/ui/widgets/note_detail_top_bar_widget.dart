import 'package:flutter/material.dart';
import 'package:simple_notes_application/src/core/constants/constants.dart';
import 'package:simple_notes_application/src/core/constants/strings.dart';
import 'package:simple_notes_application/src/core/di/app_component.dart';
import 'package:simple_notes_application/src/core/extensions/generic_extensions.dart';
import 'package:simple_notes_application/src/note_detail/view_model/note_detail_view_model.dart';
import 'package:stacked/stacked.dart';

class NoteDetailTopBarWidget extends ViewModelWidget<NoteDetailViewModel> {
  const NoteDetailTopBarWidget({super.key});

  @override
  Widget build(BuildContext context, NoteDetailViewModel viewModel) {
    return Container(
      color: viewModel.noteColor,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            MaterialButton(
              visualDensity: VisualDensity.compact,
              minWidth: 60,
              height: 60,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              onPressed: () => appNavigator.back(),
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 10,),
            Expanded(
              child: TextField(
                controller: viewModel.titleController,
                decoration: InputDecoration.collapsed(
                  hintText: AppStrings().noteTitleLabel,
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
              height: 60,
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
                    height: 60,
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
            MaterialButton(
              visualDensity: VisualDensity.compact,
              minWidth: 60,
              height: 60,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              onPressed: viewModel.lockNote,
              child: Icon(
                viewModel.isProtected ? Icons.lock_outline : Icons.lock_open_outlined,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}

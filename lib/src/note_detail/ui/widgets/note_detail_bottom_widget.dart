import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:simple_notes_application/src/core/constants/constants.dart';
import 'package:simple_notes_application/src/core/enums/enums.dart';
import 'package:simple_notes_application/src/core/extensions/generic_extensions.dart';
import 'package:simple_notes_application/src/note_detail/ui/widgets/note_detail_color_picker.dart';
import 'package:simple_notes_application/src/note_detail/view_model/note_detail_view_model.dart';
import 'package:stacked/stacked.dart';

class NoteDetailBottomWidget extends ViewModelWidget<NoteDetailViewModel> {
  const NoteDetailBottomWidget({super.key});

  @override
  Widget build(BuildContext context, NoteDetailViewModel viewModel) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      height: 145,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () => viewModel.onTextTypeChanged(
                    viewModel.textType == TextType.bold
                        ? TextType.normal
                        : TextType.bold),
                style: TextButton.styleFrom(
                  minimumSize: Size.zero,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: const Text(
                  'B',
                  style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              TextButton(
                onPressed: () => viewModel.onTextTypeChanged(
                    viewModel.textType == TextType.italic
                        ? TextType.normal
                        : TextType.italic),
                style: TextButton.styleFrom(
                  minimumSize: Size.zero,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: const FaIcon(
                  FontAwesomeIcons.italic,
                  size: 19,
                  color: Colors.white,
                ),
              ),
              TextButton(
                onPressed: () => viewModel.onTextSizeChanged(true),
                style: TextButton.styleFrom(
                  minimumSize: Size.zero,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: const Text(
                  'A+',
                  style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              TextButton(
                onPressed: () => viewModel.onTextSizeChanged(false),
                style: TextButton.styleFrom(
                  minimumSize: Size.zero,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: const Text(
                  'A-',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const Divider(
            color: Colors.white,
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  viewModel.createdDate.formatDate(),
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w500),
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.color_lens,
                  color: Colors.white,
                ),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return CustomColorPicker(
                        onSelectColor: (color) =>
                            viewModel.onNoteColorChanged(color),
                        availableColors: [
                          HexColor.fromHex(CustomColors.colorBlack74),
                          HexColor.fromHex(CustomColors.colorRed),
                          HexColor.fromHex(CustomColors.colorOrange),
                          HexColor.fromHex(CustomColors.colorYellow),
                          HexColor.fromHex(CustomColors.colorGreen),
                          HexColor.fromHex(CustomColors.colorTurquoise),
                          HexColor.fromHex(CustomColors.colorBlue),
                          HexColor.fromHex(CustomColors.colorPurple),
                          HexColor.fromHex(CustomColors.colorPink),
                        ],
                        initialColor: viewModel.noteColor,
                        backgroundColor: viewModel.noteColor,
                      );
                    },
                  );
                },
              ),
              IconButton(
                icon: const Icon(
                  Icons.photo,
                  color: Colors.white,
                ),
                onPressed: () {},
              ),
            ],
          ),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              style: ButtonStyle(
                backgroundColor:
                    viewModel.loading || !viewModel.isButtonAvailable
                        ? MaterialStateProperty.all<Color>(Colors.white12)
                        : MaterialStateProperty.all<Color>(Colors.blue),
                overlayColor: viewModel.loading || !viewModel.isButtonAvailable
                    ? null
                    : MaterialStateProperty.all<Color>(Colors.white12),
              ),
              onPressed: viewModel.loading || !viewModel.isButtonAvailable
                  ? null
                  : () => viewModel.saveNote(context),
              child: Text(
                viewModel.noteSelected == null ? 'Save' : 'Edit',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
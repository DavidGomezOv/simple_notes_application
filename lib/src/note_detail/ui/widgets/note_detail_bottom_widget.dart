import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:simple_notes_application/src/core/constants/constants.dart';
import 'package:simple_notes_application/src/core/constants/strings.dart';
import 'package:simple_notes_application/src/core/enums/enums.dart';
import 'package:simple_notes_application/src/core/extensions/generic_extensions.dart';
import 'package:simple_notes_application/src/note_detail/ui/widgets/note_detail_color_picker.dart';
import 'package:simple_notes_application/src/note_detail/view_model/note_detail_view_model.dart';
import 'package:stacked/stacked.dart';

class NoteDetailBottomWidget extends ViewModelWidget<NoteDetailViewModel> {
  const   NoteDetailBottomWidget({super.key});

  @override
  Widget build(BuildContext context, NoteDetailViewModel viewModel) {
    final color = viewModel.loading
        ? HexColor.fromHex(CustomColors.colorTextDisabled)
        : Colors.white;
    return IgnorePointer(
      ignoring: viewModel.loading,
      child: Container(
        color: viewModel.loading ? Colors.transparent : viewModel.noteColor,
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        height: 155,
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
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 5),
                    child: Text(
                      'B',
                      style: TextStyle(
                          fontSize: 26,
                          color: color,
                          fontWeight: FontWeight.bold),
                    ),
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
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8,),
                    child: FaIcon(
                      FontAwesomeIcons.italic,
                      size: 20,
                      color: color,
                    ),
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
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Text(
                      'A+',
                      style: TextStyle(
                          fontSize: 26,
                          color: color,
                          fontWeight: FontWeight.bold),
                    ),
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
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Text(
                      'A-',
                      style: TextStyle(
                          fontSize: 26,
                          color: color,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
            Divider(
              color: color,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    viewModel.createdDate.formatDate(),
                    style: TextStyle(color: color, fontWeight: FontWeight.w500),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.color_lens,
                    color: color,
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
                  icon: Icon(
                    Icons.photo,
                    color: color,
                  ),
                  onPressed: viewModel.pickImages,
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
                  overlayColor:
                      viewModel.loading || !viewModel.isButtonAvailable
                          ? null
                          : MaterialStateProperty.all<Color>(Colors.white12),
                ),
                onPressed: viewModel.loading || !viewModel.isButtonAvailable
                    ? null
                    : () => viewModel.saveNote(),
                child: Text(
                  viewModel.noteSelected == null
                      ? AppStrings().saveLabel
                      : AppStrings().editLabel,
                  style: TextStyle(color: color),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

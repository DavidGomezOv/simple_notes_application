import 'package:flutter/material.dart';
import 'package:simple_notes_application/src/core/constants/constants.dart';
import 'package:simple_notes_application/src/core/extensions/generic_extensions.dart';
import 'package:simple_notes_application/src/core/extensions/string_extensions.dart';
import 'package:simple_notes_application/src/home/model/note_model.dart';
import 'package:simple_notes_application/src/home/ui/widgets/loading_grid_tile_widget.dart';
import 'package:simple_notes_application/src/home/view_model/home_view_model.dart';
import 'package:stacked/stacked.dart';

class GridTileWidget extends ViewModelWidget<HomeViewModel> {
  final NoteModel? noteModel;

  const GridTileWidget({
    this.noteModel,
    super.key,
  });

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    return viewModel.loading
        ? LoadingGridTileWidget(
            height: viewModel.isGridView ? 140 : 80,
          )
        : GestureDetector(
            onTap: () => viewModel.onNoteTap(noteModel),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: noteModel!.color != null
                    ? HexColor.fromHex(noteModel!.color!)
                    : HexColor.fromHex(CustomColors.colorBlack74),
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(
                  color: HexColor.fromHex(CustomColors.colorWhite38),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Text(
                          noteModel!.title ?? '',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      noteModel!.isPinned!
                          ? const Icon(
                              Icons.push_pin,
                              color: Colors.white,
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    noteModel!.content ?? '',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: noteModel!.textType?.getFontWeight(),
                      fontStyle: noteModel!.textType?.getFontStyle(),
                    ),
                    maxLines: 6,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          );
  }
}

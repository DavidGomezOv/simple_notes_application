import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:simple_notes_application/src/core/constants/constants.dart';
import 'package:simple_notes_application/src/core/extensions/generic_extensions.dart';
import 'package:simple_notes_application/src/home/ui/widgets/loading_text_widget.dart';
import 'package:simple_notes_application/src/home/view_model/home_view_model.dart';
import 'package:stacked/stacked.dart';

class LoadingGridTileWidget extends ViewModelWidget<HomeViewModel> {
  final double height;

  const LoadingGridTileWidget({required this.height, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    return Shimmer.fromColors(
      baseColor: HexColor.fromHex(CustomColors.colorBlack70),
      highlightColor: HexColor.fromHex(CustomColors.colorWhite10),
      child: Container(
        padding: const EdgeInsets.all(10),
        height: height,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: HexColor.fromHex(CustomColors.colorWhite38),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LoadingTextWidget(
              width: viewModel.isGridView ? 80 : 130,
              height: 14,
              padding: const EdgeInsets.only(bottom: 10),
            ),
            LoadingTextWidget(
              width: double.infinity,
              height: 10,
              padding: const EdgeInsets.only(bottom: 10),
            ),
            LoadingTextWidget(width: double.infinity, height: 10),
            if (viewModel.isGridView)
              Column(
                children: List.generate(
                  3,
                  (index) => LoadingTextWidget(
                    width: double.infinity,
                    height: 10,
                    padding: const EdgeInsets.only(top: 10),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}

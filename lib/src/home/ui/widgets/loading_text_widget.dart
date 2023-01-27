import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:simple_notes_application/src/core/constants/constants.dart';
import 'package:simple_notes_application/src/core/extensions/generic_extensions.dart';
import 'package:simple_notes_application/src/home/view_model/home_view_model.dart';
import 'package:stacked/stacked.dart';

class LoadingTextWidget extends ViewModelWidget<HomeViewModel> {
  final double width;
  final double height;
  EdgeInsets padding;

  LoadingTextWidget({
    required this.width,
    required this.height,
    this.padding = EdgeInsets.zero,
    super.key,
  });

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    return Padding(
      padding: padding,
      child: Shimmer.fromColors(
        baseColor: HexColor.fromHex(CustomColors.colorBlack70),
        highlightColor: HexColor.fromHex(CustomColors.colorWhite10),
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: HexColor.fromHex(CustomColors.colorWhite38),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}

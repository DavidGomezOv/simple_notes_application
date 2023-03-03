import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shimmer/shimmer.dart';
import 'package:simple_notes_application/src/core/constants/constants.dart';
import 'package:simple_notes_application/src/core/extensions/generic_extensions.dart';
import 'package:simple_notes_application/src/home/ui/widgets/loading_text_widget.dart';
import 'package:simple_notes_application/src/home/view_model/home_view_model.dart';
import 'package:stacked/stacked.dart';

class HomeTopBarWidget extends ViewModelWidget<HomeViewModel> {
  final String title;
  final Color textColor;
  final Icon iconData;

  const HomeTopBarWidget({
    required this.title,
    required this.textColor,
    required this.iconData,
    super.key,
  });

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    return viewModel.loading
        ? Shimmer.fromColors(
            baseColor: HexColor.fromHex(CustomColors.colorBlack70),
            highlightColor: HexColor.fromHex(CustomColors.colorWhite10),
            child: Container(
              width: double.infinity,
              height: 53,
              padding: const EdgeInsets.only(left: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.0),
                border: Border.all(
                  color: HexColor.fromHex(CustomColors.colorWhite38),
                ),
              ),
              child: Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: LoadingTextWidget(width: 200, height: 20)),
            ),
          )
        : Row(
            children: [
              MaterialButton(
                visualDensity: VisualDensity.compact,
                minWidth: 50,
                height: 60,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                onPressed: viewModel.changeGridViewValue,
                child: iconData,
              ),
              const SizedBox(width: 4,),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    color: HexColor.fromHex(CustomColors.colorWhite10),
                  ),
                  child: TextField(
                    controller: viewModel.controllerSearch,
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      hintText: title,
                      hintStyle: TextStyle(fontSize: 20.0, color: textColor),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      suffixIcon: Visibility(
                        visible: viewModel.isSearching,
                        child: InkWell(
                          onTap: viewModel.resetSearch,
                          child: const Icon(Icons.cancel),
                        ),
                      ),
                      isDense: true,
                      contentPadding: const EdgeInsets.only(
                          bottom: 15, top: 15, left: 15, right: 15),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white.withOpacity(0),
                        ),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    onEditingComplete: () => FocusScope.of(context).unfocus(),
                    style: const TextStyle(fontSize: 20.0, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(width: 10,),
              //TODO Commented for future implementation
              /*MaterialButton(
                visualDensity: VisualDensity.compact,
                minWidth: 40,
                height: 50,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                onPressed: viewModel.onUserTap,
                child: const Icon(
                  Icons.person,
                  color: Colors.white,
                ),
              )*/
            ],
          );
  }
}

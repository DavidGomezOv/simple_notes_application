import 'package:flutter/material.dart';
import 'package:simple_notes_application/src/core/constants/constants.dart';
import 'package:simple_notes_application/src/core/constants/strings.dart';
import 'package:simple_notes_application/src/core/extensions/generic_extensions.dart';
import 'package:simple_notes_application/src/home/ui/widgets/grid_notes_widget.dart';
import 'package:simple_notes_application/src/home/ui/widgets/home_top_bar_widget.dart';
import 'package:simple_notes_application/src/home/view_model/home_view_model.dart';
import 'package:stacked/stacked.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppStrings().setContext(context);
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(context),
      builder: (context, viewModel, child) => SafeArea(
        child: Scaffold(
          body: GestureDetector(
            onTap: () => viewModel.closeFabButton(),
            behavior: HitTestBehavior.opaque,
            child: RefreshIndicator(
              onRefresh: () async {
                viewModel.getNotes();
              },
              child: Container(
                padding: const EdgeInsets.all(10.0),
                color: HexColor.fromHex(CustomColors.colorBlack74),
                child: Column(
                  children: [
                    HomeTopBarWidget(
                      title: AppStrings().searchNotesLabel,
                      textColor: HexColor.fromHex(CustomColors.colorWhite54),
                      iconData: Icon(
                        viewModel.isGridView
                            ? Icons.view_list
                            : Icons.auto_awesome_mosaic,
                        size: 35.0,
                        color: HexColor.fromHex(CustomColors.colorWhite38),
                      ),
                    ),
                    Expanded(
                      child: viewModel.notes.isEmpty
                          ? Padding(
                              padding: const EdgeInsets.all(20),
                              child: Stack(
                                children: [
                                  Center(
                                    child: Text(
                                      AppStrings().noNotesLabel,
                                      style: TextStyle(
                                        color: HexColor.fromHex(
                                            CustomColors.colorWhite54),
                                        fontSize: 20,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  ListView(),
                                ],
                              ),
                            )
                          : const GridNotesWidget(),
                    ),
                  ],
                ),
              ),
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () => viewModel.onNoteTap(null),
          ),
        ),
      ),
    );
  }
}

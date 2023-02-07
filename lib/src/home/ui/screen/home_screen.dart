import 'package:flutter/material.dart';
import 'package:simple_notes_application/src/core/constants/constants.dart';
import 'package:simple_notes_application/src/core/extensions/generic_extensions.dart';
import 'package:simple_notes_application/src/home/ui/widgets/floating_action_button.dart';
import 'package:simple_notes_application/src/home/ui/widgets/grid_notes_widget.dart';
import 'package:simple_notes_application/src/home/ui/widgets/home_top_bar_widget.dart';
import 'package:simple_notes_application/src/home/view_model/home_view_model.dart';
import 'package:stacked/stacked.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                      title: 'Search notes here',
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
                                      'There no notes, save one now.',
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
          floatingActionButton: ExpandableFab(
            viewModel: viewModel,
            key: viewModel.globalKey,
            children: [
              ActionButton(
                tag: 'create',
                icon: const Icon(Icons.create),
                onPressed: () => viewModel.onNoteTap(null),
              ),
              ActionButton(
                tag: 'photo',
                icon: const Icon(Icons.insert_photo),
                onPressed: () => viewModel.onPhotoNoteTap(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

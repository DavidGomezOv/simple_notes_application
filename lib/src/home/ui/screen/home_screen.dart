import 'package:flutter/material.dart';
import 'package:simple_notes_application/src/core/constants/constants.dart';
import 'package:simple_notes_application/src/core/extensions/generic_extensions.dart';
import 'package:simple_notes_application/src/home/ui/widgets/grid_notes_widget.dart';
import 'package:simple_notes_application/src/home/ui/widgets/home_top_bar_widget.dart';
import 'package:simple_notes_application/src/home/view_model/home_view_model.dart';
import 'package:stacked/stacked.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, viewModel, child) => SafeArea(
        child: Scaffold(
          body: Container(
            padding: const EdgeInsets.all(10.0),
            color: HexColor.fromHex(CustomColors.colorBlack74),
            child: Column(
              children: [
                HomeTopBarWidget(
                  title: 'Search notes here',
                  textColor: HexColor.fromHex(CustomColors.colorWhite54),
                  onTap: viewModel.changeGridViewValue,
                  iconData: Icon(
                    viewModel.isGridView
                        ? Icons.view_list
                        : Icons.auto_awesome_mosaic,
                    size: 35.0,
                    color: HexColor.fromHex(CustomColors.colorWhite38),
                  ),
                ),
                const Expanded(
                  child: GridNotesWidget(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

/*@override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, viewModel, child) => Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Chopper Example'),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10.0,
            ),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: viewModel.itemList.length,
                    itemBuilder: (context, index) => ItemListWidget(
                      item: viewModel.itemList[index],
                      onTap: () {},
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }*/
}

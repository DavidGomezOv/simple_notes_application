import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:simple_notes_application/src/home/ui/widgets/grid_tile_widget.dart';
import 'package:simple_notes_application/src/home/view_model/home_view_model.dart';
import 'package:stacked/stacked.dart';

class GridNotesWidget extends ViewModelWidget<HomeViewModel> {
  const GridNotesWidget({super.key});

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: viewModel.isGridView
          ? StaggeredGrid.count(
              mainAxisSpacing: 6.0,
              crossAxisSpacing: 6.0,
              axisDirection: AxisDirection.down,
              crossAxisCount: 2,
              children: viewModel.loading
                  ? List.generate(
                      6,
                      (index) => const GridTileWidget(noteModel: null),
                    )
                  : viewModel.notes
                      .map(
                        (e) => GridTileWidget(noteModel: e),
                      )
                      .toList(),
            )
          : ListView.builder(
              itemCount: viewModel.loading ? 6 : viewModel.notes.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: GridTileWidget(
                  noteModel: viewModel.loading ? null : viewModel.notes[index],
                ),
              ),
            ),
    );
  }
}

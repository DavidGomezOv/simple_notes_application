import 'package:flutter/material.dart';
import 'package:simple_notes_application/src/note_detail/ui/widgets/note_detail_body_widget.dart';
import 'package:simple_notes_application/src/note_detail/ui/widgets/note_detail_bottom_widget.dart';
import 'package:simple_notes_application/src/note_detail/ui/widgets/note_detail_top_bar_widget.dart';
import 'package:simple_notes_application/src/note_detail/view_model/note_detail_view_model.dart';
import 'package:stacked/stacked.dart';

class NoteDetailScreen extends StatelessWidget {
  const NoteDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NoteDetailViewModel>.reactive(
      viewModelBuilder: () => NoteDetailViewModel(context),
      builder: (context, viewModel, child) => SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              Container(
                color: viewModel.noteColor,
                child: Column(
                  children: const [
                    NoteDetailTopBarWidget(),
                    NoteDetailBodyWidget(),
                    NoteDetailBottomWidget(),
                  ],
                ),
              ),
              Visibility(
                visible: viewModel.loading,
                child: Container(
                  width: double.maxFinite,
                  height: double.maxFinite,
                  color: Colors.black.withAlpha(70),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

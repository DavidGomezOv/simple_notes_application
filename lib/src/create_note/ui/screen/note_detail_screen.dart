import 'package:flutter/material.dart';
import 'package:simple_notes_application/src/create_note/ui/widgets/note_detail_body_widget.dart';
import 'package:simple_notes_application/src/create_note/ui/widgets/note_detail_bottom_widget.dart';
import 'package:simple_notes_application/src/create_note/ui/widgets/note_detail_top_bar_widget.dart';
import 'package:simple_notes_application/src/create_note/view_model/note_detail_view_model.dart';
import 'package:stacked/stacked.dart';

class NoteDetailScreen extends StatelessWidget {
  const NoteDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NoteDetailViewModel>.reactive(
      viewModelBuilder: () => NoteDetailViewModel(),
      builder: (context, viewModel, child) => SafeArea(
        child: Scaffold(
          body: Container(
            color: viewModel.noteColor,
            child: Column(
              children: const [
                NoteDetailTopBarWidget(),
                NoteDetailBodyWidget(),
                NoteDetailBottomWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

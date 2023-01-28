import 'package:flutter/material.dart';
import 'package:simple_notes_application/src/create_note/view_model/note_detail_view_model.dart';
import 'package:stacked/stacked.dart';

class NoteDetailTopBarWidget extends ViewModelWidget<NoteDetailViewModel> {
  const NoteDetailTopBarWidget({super.key});

  @override
  Widget build(BuildContext context, NoteDetailViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          Expanded(
            child: TextField(
              controller: viewModel.titleController,
              decoration: const InputDecoration.collapsed(
                  hintText: 'Title',
                  hintStyle: TextStyle(fontSize: 24, color: Colors.white)),
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w500),
              cursorColor: Colors.white,
              onChanged: viewModel.onTitleChanged,
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.push_pin,
              color: Colors.white,
            ),
            onPressed: () {
              viewModel.isPinned = !viewModel.isPinned;
            },
          ),
        ],
      ),
    );
  }
}

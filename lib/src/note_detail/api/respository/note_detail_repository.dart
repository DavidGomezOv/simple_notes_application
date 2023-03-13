import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:simple_notes_application/src/core/constants/constants.dart';
import 'package:simple_notes_application/src/home/model/note_model.dart';
import 'package:simple_notes_application/src/note_detail/api/datasource/note_detail_local_source.dart';

@injectable
class NoteDetailRepository {
  final NoteDetailLocalSource _localDatasource;

  @factoryMethod
  NoteDetailRepository.from(this._localDatasource);

  Future<void> createNote(NoteModel noteModel, List<File?> images) async {
    noteModel.userId = Constants.localUserId;
    return _localDatasource.createLocalNote(noteModel, images);
  }

  Future<void> deleteNote(String noteId) async {
    return _localDatasource.deleteLocalNote(noteId);
  }
}

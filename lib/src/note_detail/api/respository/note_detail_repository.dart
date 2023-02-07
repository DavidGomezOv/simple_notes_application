import 'package:injectable/injectable.dart';
import 'package:simple_notes_application/src/core/utils/shared_preferences_helper.dart';
import 'package:simple_notes_application/src/home/model/note_model.dart';
import 'package:simple_notes_application/src/note_detail/api/datasource/note_detail_firestore_source.dart';
import 'package:simple_notes_application/src/note_detail/api/datasource/note_detail_local_source.dart';

@injectable
class NoteDetailRepository {
  final NoteDetailFirestoreSource _datasource;
  final NoteDetailLocalSource _localDatasource;

  @factoryMethod
  NoteDetailRepository.from(this._datasource, this._localDatasource);

  Future<void> createNote(NoteModel noteModel) async {
    final token = await SharedPreferenceHelper.getSessionToken();
    if (token != null) {
      return _datasource.createNote(noteModel);
    } else {
      return _localDatasource.createLocalNote(noteModel);
    }
  }

  Future<void> deleteNote(String noteId) async {
    final token = await SharedPreferenceHelper.getSessionToken();
    if (token != null) {
      return _datasource.deleteNote(noteId);
    } else {
      return _localDatasource.deleteLocalNote(noteId);
    }
  }
}
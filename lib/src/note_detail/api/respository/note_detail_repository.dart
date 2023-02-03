import 'package:injectable/injectable.dart';
import 'package:simple_notes_application/src/home/model/note_model.dart';
import 'package:simple_notes_application/src/note_detail/api/datasource/note_detail_firestore_source.dart';

@injectable
class NoteDetailRepository {
  final NoteDetailFirestoreSource _datasource;

  @factoryMethod
  NoteDetailRepository.from(this._datasource);

  Future<void> createNote(NoteModel noteModel) {
    return _datasource.createNote(noteModel);
  }

  Future<void> deleteNote(String noteId) {
    return _datasource.deleteNote(noteId);
  }
}
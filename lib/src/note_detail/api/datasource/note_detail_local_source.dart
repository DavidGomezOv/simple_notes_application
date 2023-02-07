import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:simple_notes_application/src/core/constants/constants.dart';
import 'package:simple_notes_application/src/home/model/note_model.dart';

@lazySingleton
class NoteDetailLocalSource {
  @factoryMethod
  NoteDetailLocalSource.from();

  Future<void> createLocalNote(NoteModel noteModel) async {
    final box = await Hive.openBox<NoteModel>(Constants.notesCollection);
    return box.put(noteModel.id, noteModel).catchError((onError) {
      throw(onError);
    });
  }

  Future<void> deleteLocalNote(String noteId) async {
    final box = Hive.box<NoteModel>(Constants.notesCollection);
    return box.delete(noteId).catchError((onError) {
      throw(onError);
    });
  }

}

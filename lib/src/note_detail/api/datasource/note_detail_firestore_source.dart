import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:simple_notes_application/src/core/base/base_datasource.dart';
import 'package:simple_notes_application/src/core/constants/constants.dart';
import 'package:simple_notes_application/src/home/model/note_model.dart';

@lazySingleton
class NoteDetailFirestoreSource extends BaseDatasource {
  @factoryMethod
  NoteDetailFirestoreSource.from();

  Future<void> createNote(NoteModel noteModel) async {
    await validateConnection();
    final db = FirebaseFirestore.instance;
    db
        .collection(await collectionName ?? Constants.notesCollection)
        .doc(noteModel.id)
        .set(noteModel.toJson());
  }

  Future<void> deleteNote(String noteId) async {
    await validateConnection();
    final db = FirebaseFirestore.instance;
    db
        .collection(await collectionName ?? Constants.notesCollection)
        .doc(noteId)
        .delete();
  }
}

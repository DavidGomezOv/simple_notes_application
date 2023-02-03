import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';
import 'package:simple_notes_application/src/core/constants/constants.dart';
import 'package:simple_notes_application/src/home/model/note_model.dart';

@lazySingleton
class NoteDetailFirestoreSource {
  @factoryMethod
  NoteDetailFirestoreSource.from();

  Future<void> createNote(NoteModel noteModel) async {
    await validateConnection();
    final db = FirebaseFirestore.instance;
    db
        .collection(Constants.notesCollection)
        .doc(noteModel.id)
        .set(noteModel.toJson());
  }

  Future<void> deleteNote(String noteId) async {
    await validateConnection();
    final db = FirebaseFirestore.instance;
    db.collection(Constants.notesCollection).doc(noteId).delete();
  }

  Future<bool> validateConnection() async {
    final connectivity = await Connectivity().checkConnectivity();
    if (connectivity == ConnectivityResult.none) {
      throw ('The device is not connected to Internet');
    }
    return connectivity != ConnectivityResult.none;
  }
}

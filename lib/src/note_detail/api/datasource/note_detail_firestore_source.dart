import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:simple_notes_application/src/core/base/base_datasource.dart';
import 'package:simple_notes_application/src/core/constants/constants.dart';
import 'package:simple_notes_application/src/home/model/note_image_model.dart';
import 'package:simple_notes_application/src/home/model/note_model.dart';

@lazySingleton
class NoteDetailFirestoreSource extends BaseDatasource {
  @factoryMethod
  NoteDetailFirestoreSource.from();

  Future<void> createNote(NoteModel noteModel, List<File?> images) async {
    await validateConnection();
    bool addImages = false;
    await saveNoteData(noteModel)
        .then(
          (value) => addImages = true,
        )
        .onError((error, stackTrace) => throw (error.toString()));
    if (addImages) {
      noteModel.images ??= [];
      await saveNoteImages(noteModel, images);
      await saveNoteData(noteModel)
          .onError((error, stackTrace) => throw (error.toString()));
      await deleteImages(noteModel);
    }
  }

  Future<void> saveNoteData(NoteModel noteModel) async {
    final firebase = FirebaseFirestore.instance;
    firebase
        .collection(await collectionName ?? Constants.notesCollection)
        .doc(noteModel.id)
        .set(noteModel.toJson());
  }

  Future<void> saveNoteImages(NoteModel noteModel, List<File?> images) async {
    String? last;
    int index = 0;
    if (noteModel.images != null && noteModel.images!.isNotEmpty) {
      last = noteModel.images?.last?.imageName;
      if (last != null) {
        index = int.parse(last.substring(5, last.indexOf('.'))) + 1;
      }
    }
    for (var element in images) {
      if (element == null) continue;
      final storage = FirebaseStorage.instance
          .ref('${Constants.imagesFolder}/${noteModel.id}');
      final imageName = 'IMAGE$index.jpg';
      TaskSnapshot taskSnapshot =
          await storage.child(imageName).putFile(element);
      noteModel.images?.add(
        NoteImageModel(await taskSnapshot.ref.getDownloadURL(), imageName),
      );
      index++;
    }
  }

  Future<void> deleteImages(NoteModel noteModel) async {
    if (noteModel.images == null) return;
    final storage = FirebaseStorage.instance
        .ref('${Constants.imagesFolder}/${noteModel.id}');
    final listResult = await storage.listAll();

    List<String?> imagesNames =
        noteModel.images!.map((e) => e?.imageName).toList();
    List<String> imagesToDelete = [];

    for (final item in listResult.items) {
      if (!imagesNames.contains(item.name)) {
        imagesToDelete.add(item.name);
      }
    }

    for (final image in imagesToDelete) {
      await storage.child(image).delete();
    }
  }

  Future<void> deleteNote(String noteId) async {
    await validateConnection();
    final firebase = FirebaseFirestore.instance;
    firebase
        .collection(await collectionName ?? Constants.notesCollection)
        .doc(noteId)
        .delete();
  }
}

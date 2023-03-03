import 'dart:io';

import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:simple_notes_application/src/core/constants/constants.dart';
import 'package:simple_notes_application/src/home/model/note_image_model.dart';
import 'package:simple_notes_application/src/home/model/note_model.dart';

@lazySingleton
class NoteDetailLocalSource {
  @factoryMethod
  NoteDetailLocalSource.from();

  Future<void> createLocalNote(NoteModel noteModel, List<File?> images) async {
    bool addImages = false;
    await saveNoteData(noteModel)
        .then((value) => addImages = true)
        .catchError((onError) => throw (onError));
    if (addImages) {
      noteModel.images ??= [];
      await saveNoteImages(noteModel, images);
      await saveNoteData(noteModel).catchError((onError) => throw (onError));
      await deleteLocalImages(noteModel);
    }
  }

  Future<void> saveNoteData(NoteModel noteModel) async {
    final box = await Hive.openBox<NoteModel>(Constants.notesCollection);
    await box.put(noteModel.id, noteModel);
  }

  Future<void> saveNoteImages(NoteModel noteModel, List<File?> images) async {
    final directory = await getApplicationDocumentsDirectory();
    String? last;
    int index = 0;
    if (noteModel.images != null && noteModel.images!.isNotEmpty) {
      last = noteModel.images?.last?.imageName;
      if (last != null) {
        index = int.parse(last.substring(5, last.indexOf('.'))) + 1;
      }
    }
    final Directory appDocDirFolder =
        Directory('${directory.path}/${noteModel.id}');
    if (await appDocDirFolder.exists() == false) {
      await appDocDirFolder.create(recursive: true);
    }
    for (var element in images) {
      if (element == null) continue;
      final imageName = 'IMAGE$index.jpg';
      final imageFile =
          await element.copy('${appDocDirFolder.path}/$imageName');

      noteModel.images?.add(
        NoteImageModel(imageFile.path, imageName),
      );
      index++;
    }
  }

  Future<void> deleteLocalImages(NoteModel noteModel) async {
    if (noteModel.images == null) return;
    final directory = await getApplicationDocumentsDirectory();
    final noteFolder = Directory('${directory.path}/${noteModel.id}');
    final List<FileSystemEntity> entities = await noteFolder.list().toList();
    List<String?> imagesUrl =
        noteModel.images!.map((e) => e?.imageUrl).toList();
    List<FileSystemEntity> imagesToDelete = [];

    for (var element in entities) {
      if (!imagesUrl.contains(element.path)) {
        imagesToDelete.add(element);
      }
    }

    for (final image in imagesToDelete) {
      await image.delete();
    }

    if (await noteFolder.list().isEmpty) {
      noteFolder.delete();
    }
  }

  Future<void> deleteLocalNote(String noteId) async {
    final box = Hive.box<NoteModel>(Constants.notesCollection);
    await box.delete(noteId).catchError((onError) {
      throw (onError);
    });
    final directory = await getApplicationDocumentsDirectory();
    final noteFolder = Directory('${directory.path}/$noteId');
    if (await noteFolder.exists()) {
      await noteFolder.delete(recursive: true);
    }
  }
}

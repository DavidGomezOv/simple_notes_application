import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:simple_notes_application/src/core/constants/constants.dart';
import 'package:simple_notes_application/src/home/model/note_model.dart';

@lazySingleton
class HomeLocalSource {
  @factoryMethod
  HomeLocalSource.from();

  Future<Box<NoteModel>> openHiveBox(String boxName) async {
    if (!kIsWeb && !Hive.isBoxOpen(boxName)) {
      Hive.init((await getApplicationDocumentsDirectory()).path);
    }
    return await Hive.openBox<NoteModel>(boxName);
  }

  Future<dynamic> getLocalNotes() async {
    List<NoteModel> notes = [];
    final box =
        await openHiveBox(Constants.notesCollection).catchError((onError) {
      throw (onError);
    });
    for (var element in box.values) {
      notes.add(element);
    }
    return notes;
  }
}

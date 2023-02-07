import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:simple_notes_application/src/core/constants/constants.dart';
import 'package:simple_notes_application/src/home/model/note_model.dart';

@lazySingleton
class HomeLocalSource {
  @factoryMethod
  HomeLocalSource.from();

  Future<dynamic> getLocalNotes() async {
    List<NoteModel> notes = [];
    final box = await Hive.openBox<NoteModel>(Constants.notesCollection)
        .catchError((onError) {
      throw (onError);
    });
    for (var element in box.values) {
      notes.add(element);
    }
    return notes;
  }
}

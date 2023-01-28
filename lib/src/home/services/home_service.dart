import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:simple_notes_application/src/core/base/base_reactive_service.dart';
import 'package:simple_notes_application/src/home/api/repository/home_repository.dart';
import 'package:simple_notes_application/src/home/model/note_model.dart';
import 'package:stacked/stacked.dart';

@lazySingleton
class HomeService extends BaseReactiveService {
  final HomeRepository _repository;

  final isGridViewValue = ReactiveValue<bool>(false);
  final notesValue = ReactiveValue<List<NoteModel>>([]);
  final noteSelectedValue = ReactiveValue<NoteModel?>(null);
  StreamSubscription<dynamic>? streamSubscription;

  @factoryMethod
  HomeService.from(this._repository) {
    listenToReactiveValues([
      loadingReactiveValue,
      isGridViewValue,
      notesValue,
    ]);
  }

  Future<dynamic> getNotes() async {
    streamSubscription?.cancel();
    loadingReactiveValue.value = true;
    final stream = await _repository.getNotes();
    streamSubscription = stream.listen((event) {
      loadingReactiveValue.value = false;
      List<NoteModel> notes = [];
      for (var e in event.docs) {
        final note = NoteModel.fromJson(e.data());
        note.id = e.id;
        notes.add(note);
      }
      notesValue.value = notes;
    });
  }
}

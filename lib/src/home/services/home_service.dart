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

  @factoryMethod
  HomeService.from(this._repository) {
    listenToReactiveValues([
      loadingReactiveValue,
      isGridViewValue,
      notesValue,
    ]);
  }

  Future<dynamic> getNotes() async {
    loadingReactiveValue.value = true;
    return _repository.getNotes().listen((event) {
      loadingReactiveValue.value = false;
      List<NoteModel> notes = [];
      for (var e in event.docChanges) {
        if (e.doc.data() != null) {
          notes.add(NoteModel.fromJson(e.doc.data()!));
        }
      }
      notesValue.value = notes;
    }).onError((error) {
      loadingReactiveValue.value = false;
      throw (error);
    });
  }
}

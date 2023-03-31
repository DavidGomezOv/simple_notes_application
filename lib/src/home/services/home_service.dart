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
  late List<NoteModel> completeList = [];
  StreamSubscription<dynamic>? streamSubscription;

  @factoryMethod
  HomeService.from(this._repository) {
    listenToReactiveValues([
      loadingReactiveValue,
      isGridViewValue,
      notesValue,
    ]);
  }

  Future<dynamic> getLocalNotes() async {
    loadingReactiveValue.value = true;
    _repository.getLocalNotes().then((value) {
      if (value is List<NoteModel>) {
        if (value.isNotEmpty) {
          value.sort(
            (a, b) => b.createdAt!.compareTo(a.createdAt!),
          );
          value.sort(
                (a, b) => b.isPinned! ? 1 : -1,
          );
        }
        completeList = value;
        notesValue.value = value;
      }
    }).whenComplete(() => loadingReactiveValue.value = false);
  }
}

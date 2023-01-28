import 'package:flutter/material.dart';
import 'package:simple_notes_application/routes.dart';
import 'package:simple_notes_application/src/core/base/base_view_model.dart';
import 'package:simple_notes_application/src/core/constants/constants.dart';
import 'package:simple_notes_application/src/core/di/app_component.dart';
import 'package:simple_notes_application/src/core/utils/shared_preferences_helper.dart';
import 'package:simple_notes_application/src/home/model/note_model.dart';
import 'package:simple_notes_application/src/home/services/home_service.dart';
import 'package:simple_notes_application/src/home/ui/widgets/floating_action_button.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends AppBaseViewModel {
  final _homeService = locator<HomeService>();

  final GlobalKey<ExpandableFabState> globalKey = GlobalKey();

  List<NoteModel> get notes => _homeService.notesValue.value;

  bool get loading => _homeService.loadingReactiveValue.value;

  bool get isGridView => _homeService.isGridViewValue.value;

  HomeViewModel() {
    getGridViewValue();
    getNotes();
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [
        _homeService,
      ];

  void getNotes() {
    _homeService.getNotes().catchError((error) {
      errorApiResponse(error.toString());
    });
  }

  void getGridViewValue() {
    SharedPreferenceHelper.getPreferencesBool(Constants.isGridViewKey)
        .then((value) {
      _homeService.isGridViewValue.value = value;
    });
  }

  void changeGridViewValue() {
    _homeService.isGridViewValue.value = !isGridView;
    SharedPreferenceHelper.savePreferencesBool(
        Constants.isGridViewKey, isGridView);
  }

  void onSearchNote(String searchText) {
    globalKey.currentState?.toggle();
  }

  void onNoteTap(NoteModel? noteModel) {
    globalKey.currentState?.toggle();
    _homeService.noteSelectedValue.value = noteModel;
    appNavigator.push(Routes.noteDetail);
  }
}

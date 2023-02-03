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

  //TODO IMPLEMENT SERVICE TO HANDLE NETWORK STATE CHANGES

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
      handleApiResponse(error.toString());
    });
  }

  void getGridViewValue() {
    SharedPreferenceHelper.getPreferencesBool(Constants.isGridViewKey)
        .then((value) {
      _homeService.isGridViewValue.value = value;
    });
  }

  void changeGridViewValue() {
    closeFabButton();
    _homeService.isGridViewValue.value = !isGridView;
    SharedPreferenceHelper.savePreferencesBool(
        Constants.isGridViewKey, isGridView);
  }

  void onSearchNote(String searchText) {
    closeFabButton();
  }

  void onNoteTap(NoteModel? noteModel) async {
    closeFabButton();
    _homeService.noteSelectedValue.value = noteModel;
    appNavigator.push(Routes.noteDetail);
  }

  void onPhotoNoteTap() {
    globalKey.currentState?.toggle();
  }

  void closeFabButton() {
    if (globalKey.currentState!.open) globalKey.currentState?.toggle();
  }
}

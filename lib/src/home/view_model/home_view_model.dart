import 'package:firebase_auth/firebase_auth.dart';
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

  final BuildContext context;

  bool isSearching = false;

  final TextEditingController controllerSearch = TextEditingController();

  //TODO IMPLEMENT SERVICE TO HANDLE NETWORK STATE CHANGES

  HomeViewModel(this.context) {
    getGridViewValue();
    getNotes();
    controllerSearch.addListener(() {
      onSearchNote(controllerSearch.text);
    });
  }

  @override
  List<ListenableServiceMixin> get listenableServices => [
        _homeService,
      ];

  @override
  void dispose() {
    controllerSearch.dispose();
    super.dispose();
  }

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
    closeFabButton(closeKeyboard: false);
    if (_homeService.completeList.isEmpty) return;
    isSearching = true;
    _homeService.notesValue.value = _homeService.completeList;
    _homeService.notesValue.value = _homeService.notesValue.value
        .where((element) =>
            element.title!.contains(searchText) ||
            element.content!.contains(searchText))
        .toList();
  }

  void resetSearch() {
    closeFabButton();
    controllerSearch.text = "";
    isSearching = false;
    _homeService.notesValue.value = _homeService.completeList;
  }

  void onNoteTap(NoteModel? noteModel) async {
    closeFabButton();
    _homeService.noteSelectedValue.value = noteModel;
    appNavigator.push(Routes.noteDetail).then((value) {
      validateReloadPage();
    });
  }

  Future<void> validateReloadPage() async {
    final token = await SharedPreferenceHelper.getSessionToken();
    if (token == null) {
      getNotes();
    }
  }

  void onUserTap() async {
    closeFabButton();
    final user = FirebaseAuth.instance.currentUser;
    final userId = await SharedPreferenceHelper.getSessionToken();
    if (user != null && userId != null) {
      appNavigator.push(Routes.signOut);
    } else {
      appNavigator.push(Routes.auth).then(
            (value) => getNotes(),
          );
    }
  }

  void onPhotoNoteTap() {
    globalKey.currentState?.toggle();
  }

  void closeFabButton({
    bool closeKeyboard = true,
  }) {
    if (closeKeyboard) FocusScope.of(context).requestFocus(FocusNode());
    if (globalKey.currentState != null) globalKey.currentState?.toggle();
  }
}

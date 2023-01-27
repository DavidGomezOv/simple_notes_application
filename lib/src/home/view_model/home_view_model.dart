import 'package:simple_notes_application/src/core/base/base_view_model.dart';
import 'package:simple_notes_application/src/core/constants/constants.dart';
import 'package:simple_notes_application/src/core/di/app_component.dart';
import 'package:simple_notes_application/src/core/utils/shared_preferences_helper.dart';
import 'package:simple_notes_application/src/home/model/note_model.dart';
import 'package:simple_notes_application/src/home/services/home_service.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends AppBaseViewModel {
  final _homeService = locator<HomeService>();

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
      _homeService.loadingReactiveValue.value = false;
      errorApiResponse(error);
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

  }

  void onNoteTap() {}
}

import 'package:simple_notes_application/src/core/utils/app_dialogs.dart';
import 'package:stacked/stacked.dart';

abstract class AppBaseViewModel extends ReactiveViewModel {
  Future<void> handleApiResponse(dynamic exception, {Function? click}) async {
    showErrorSheet(
      exception,
      okClick: click,
    );
  }
}

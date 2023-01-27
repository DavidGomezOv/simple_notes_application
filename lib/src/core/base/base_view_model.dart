import 'package:simple_notes_application/src/core/utils/app_dialogs.dart';
import 'package:stacked/stacked.dart';

abstract class AppBaseViewModel extends ReactiveViewModel {
  Future<void> errorApiResponse(dynamic exception, {Function? click}) async {
    showAlertDialog(
      exception,
      okClick: click,
    );
  }
}

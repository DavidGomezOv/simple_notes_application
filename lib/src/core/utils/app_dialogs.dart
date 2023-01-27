import 'package:simple_notes_application/src/core/di/app_component.dart';
import 'package:simple_notes_application/src/core/enums/enums.dart';

void showAlertDialog(
  String message, {
  String? title,
  String? okButton,
  String? cancelButton,
  Function? okClick,
  Function? cancelClick,
  bool oneButton = true,
  bool cancelable = true,
}) async {
  var sheetResponse = await bottomSheetService.showCustomSheet(
      variant: DialogType.floating,
      title: title,
      description: message,
      mainButtonTitle: okButton ?? 'Accept',
      secondaryButtonTitle: cancelButton ?? 'Cancel',
      showIconInSecondaryButton: !oneButton,
      isScrollControlled: true);
  if (sheetResponse?.confirmed == true) {
    okClick?.call();
  } else {
    cancelClick?.call();
  }
}

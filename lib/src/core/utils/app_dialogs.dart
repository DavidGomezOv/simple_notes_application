import 'package:simple_notes_application/src/core/di/app_component.dart';
import 'package:simple_notes_application/src/core/enums/enums.dart';

void showErrorSheet(
  String message, {
  String? okButton,
  Function? okClick,
  bool oneButton = true,
}) async {
  await bottomSheetService.showCustomSheet(
    variant: DialogType.error,
    description: message,
    mainButtonTitle: 'Accept',
    isScrollControlled: true,
    barrierDismissible: false,
  );
  okClick?.call();
}

void showInformativeDialog({
  required String title,
  required String message,
  String okButtonLabel = 'Accept',
  String cancelButtonLabel = 'Cancel',
  Function? okClick,
  Function? cancelClick,
}) async {
  final sheetResponse = await bottomSheetService.showCustomSheet(
    variant: DialogType.informative,
    title: title,
    description: message,
    mainButtonTitle: okButtonLabel,
    secondaryButtonTitle: cancelButtonLabel,
    isScrollControlled: true,
    barrierDismissible: false,
  );
  if (sheetResponse?.confirmed == true) {
    okClick?.call();
  } else {
    cancelClick?.call();
  }
}

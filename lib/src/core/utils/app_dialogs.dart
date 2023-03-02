import 'package:simple_notes_application/src/core/constants/constants.dart';
import 'package:simple_notes_application/src/core/constants/strings.dart';
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
    mainButtonTitle: AppStrings().acceptLabel,
    isScrollControlled: true,
    barrierDismissible: false,
  );
  okClick?.call();
}

void showInformativeDialog({
  required String title,
  required String message,
  String? primaryButtonLabel,
  String? secondaryButtonLabel,
  Function? primaryClick,
  Function? secondaryClick,
}) async {
  final sheetResponse = await bottomSheetService.showCustomSheet(
    variant: DialogType.informative,
    title: title,
    description: message,
    mainButtonTitle: primaryButtonLabel ?? AppStrings().acceptLabel,
    secondaryButtonTitle: secondaryButtonLabel ?? AppStrings().cancelLabel,
  );
  if (sheetResponse?.confirmed == true) {
    switch (sheetResponse!.data) {
      case 1:
        primaryClick?.call();
        break;
      case 2:
        secondaryClick?.call();
        break;
    }
  }
}

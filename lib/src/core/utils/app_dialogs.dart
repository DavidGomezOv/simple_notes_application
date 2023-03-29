import 'dart:math';

import 'package:flutter/material.dart';
import 'package:simple_notes_application/src/core/constants/constants.dart';
import 'package:simple_notes_application/src/core/constants/strings.dart';
import 'package:simple_notes_application/src/core/di/app_component.dart';
import 'package:simple_notes_application/src/core/dialogs/input_note_pin_center_sheet.dart';
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
  switch (sheetResponse?.confirmed) {
    case true:
      primaryClick?.call();
      break;
    case false:
      secondaryClick?.call();
      break;
  }
}

void showInputPinDialog({
  required String title,
  required String message,
  required Function(String? pin) acceptClick,
  required BuildContext context,
  Function? cancelClick,
  bool autoAccept = false,
}) async {
  showGeneralDialog(
    barrierDismissible: false,
    context: context,
    transitionDuration: const Duration(milliseconds: 300),
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position: Tween(
          begin: const Offset(0, 1),
          end: const Offset(0, 0),
        ).animate(animation),
        child: child,
      );
    },
    pageBuilder: (context, animation, secondaryAnimation) => WillPopScope(
      onWillPop: () async {
        cancelClick?.call();
        return true;
      },
      child: AlertDialog(
        contentPadding: EdgeInsets.zero,
        content: InputNotePinCenterSheet(
          title: title,
          description: message,
          mainButtonTitle: AppStrings().acceptLabel,
          secondaryButtonTitle: AppStrings().cancelLabel,
          accept: (pin) {
            Navigator.pop(context);
            acceptClick.call(pin);
          },
          cancel: () {
            Navigator.pop(context);
            cancelClick?.call();
          },
          autoAccept: autoAccept,
        ),
      ),
    ),
  );
}

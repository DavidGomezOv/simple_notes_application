import 'dart:ui';

import 'package:injectable/injectable.dart';
import 'package:simple_notes_application/src/core/base/base_reactive_service.dart';
import 'package:simple_notes_application/src/core/constants/constants.dart';
import 'package:simple_notes_application/src/core/extensions/generic_extensions.dart';
import 'package:stacked/stacked.dart';

@lazySingleton
class NoteDetailService extends BaseReactiveService {
  final colorValue =
      ReactiveValue<Color>(HexColor.fromHex(CustomColors.colorBlack74));

  @factoryMethod
  NoteDetailService.from() {
    listenToReactiveValues([
      loadingReactiveValue,
      colorValue,
    ]);
  }
}

import 'package:injectable/injectable.dart';
import 'package:simple_notes_application/src/core/utils/app_navigator.dart';
import 'package:stacked_services/stacked_services.dart';

@module
abstract class HelperModule {
  @lazySingleton
  BottomSheetService get bottomSheetService;

  @lazySingleton
  AppNavigator get appNavigator;
}

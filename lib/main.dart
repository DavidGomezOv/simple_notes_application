import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:simple_notes_application/routes.dart';
import 'package:simple_notes_application/src/core/di/app_component.dart';
import 'package:simple_notes_application/src/core/dialogs/error_bottom_sheet.dart';
import 'package:simple_notes_application/src/core/dialogs/informative_bottom_sheet.dart';
import 'package:simple_notes_application/src/core/dialogs/input_note_pin_center_sheet.dart';
import 'package:simple_notes_application/src/core/enums/enums.dart';
import 'package:simple_notes_application/src/home/model/note_image_model.dart';
import 'package:simple_notes_application/src/home/model/note_model.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  configureGetIt();
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  _setupBottomSheetUi();
  _initHive();
  runApp(const MyApp());
}

void _setupBottomSheetUi() {
  final bottomSheetService = locator<BottomSheetService>();
  final builders = {
    DialogType.error: (context, sheetRequest, completer) =>
        ErrorBottomSheet(request: sheetRequest, completer: completer),
    DialogType.informative: (context, sheetRequest, completer) =>
        InformativeBottomSheet(request: sheetRequest, completer: completer),
  };
  bottomSheetService.setCustomSheetBuilders(builders);
}

void _initHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(NoteModelAdapter());
  Hive.registerAdapter(NoteImageModelAdapter());
}

final appNavigatorKey = StackedService.navigatorKey;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: kDebugMode,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      title: 'Simple Notes Application',
      initialRoute: Routes.home,
      navigatorKey: appNavigatorKey,
      routes: Routes.routes,
      theme: ThemeData(brightness: Brightness.dark),
    );
  }
}

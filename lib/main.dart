import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:simple_notes_application/firebase_options.dart';
import 'package:simple_notes_application/routes.dart';
import 'package:simple_notes_application/src/core/di/app_component.dart';
import 'package:simple_notes_application/src/core/enums/enums.dart';
import 'package:simple_notes_application/src/core/widgets/alert_bottom_sheet.dart';
import 'package:simple_notes_application/src/core/widgets/alert_center_sheet.dart';
import 'package:simple_notes_application/src/home/model/note_image_model.dart';
import 'package:simple_notes_application/src/home/model/note_model.dart';
import 'package:stacked_services/stacked_services.dart';

void main() async {
  configureGetIt();
  WidgetsFlutterBinding.ensureInitialized();
  _setupBottomSheetUi();
  _initHive();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) {
    runApp(const MyApp());
  });
}

void _setupBottomSheetUi() {
  final bottomSheetService = locator<BottomSheetService>();
  final builders = {
    DialogType.error: (context, sheetRequest, completer) =>
        AlertBottomSheet(request: sheetRequest, completer: completer),
    DialogType.informative: (context, sheetRequest, completer) =>
        AlertCenterSheet(request: sheetRequest, completer: completer),
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
      title: 'Simple Notes Application',
      initialRoute: Routes.home,
      navigatorKey: appNavigatorKey,
      routes: Routes.routes,
    );
  }
}

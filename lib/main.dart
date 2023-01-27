import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:simple_notes_application/firebase_options.dart';
import 'package:simple_notes_application/routes.dart';
import 'package:simple_notes_application/src/core/di/app_component.dart';
import 'package:simple_notes_application/src/core/enums/enums.dart';
import 'package:simple_notes_application/src/core/utils/app_dialogs.dart';
import 'package:simple_notes_application/src/core/widgets/alert_bottom_sheet.dart';
import 'package:stacked_services/stacked_services.dart';

void main() async {
  configureGetIt();
  WidgetsFlutterBinding.ensureInitialized();
  _setupBottomSheetUi();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) {
    runApp(const MyApp());
  });
}

void _setupBottomSheetUi() {
  final bottomSheetService = locator<BottomSheetService>();
  final builders = {
    DialogType.floating: (context, sheetRequest, completer) =>
        AlertBottomSheet(request: sheetRequest, completer: completer),
  };
  bottomSheetService.setCustomSheetBuilders(builders);
}

final appNavigatorKey = StackedService.navigatorKey;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Chopper App Demo',
      initialRoute: Routes.home,
      navigatorKey: appNavigatorKey,
      routes: Routes.routes,
    );
  }
}

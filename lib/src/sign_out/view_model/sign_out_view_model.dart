import 'package:firebase_auth/firebase_auth.dart';
import 'package:simple_notes_application/routes.dart';
import 'package:simple_notes_application/src/core/base/base_view_model.dart';
import 'package:simple_notes_application/src/core/constants/constants.dart';
import 'package:simple_notes_application/src/core/di/app_component.dart';
import 'package:simple_notes_application/src/core/utils/app_dialogs.dart';
import 'package:simple_notes_application/src/core/utils/shared_preferences_helper.dart';

class SignOutViewModel extends AppBaseViewModel {
  SignOutViewModel(super.buildContext);

  void signOut() {
    showInformativeDialog(
      title: Messages.informationLabel,
      message: Messages.singOutConfirmationMessage,
      primaryClick: () => doSignOut(),
    );
  }

  void doSignOut() {
    FirebaseAuth.instance.signOut().then((value) {
      SharedPreferenceHelper.deleteSessionToken();
      appNavigator.pushNamedAndRemoveUntil(Routes.home);
    });
  }
}

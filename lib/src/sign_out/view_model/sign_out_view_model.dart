import 'package:firebase_auth/firebase_auth.dart';
import 'package:simple_notes_application/routes.dart';
import 'package:simple_notes_application/src/core/base/base_view_model.dart';
import 'package:simple_notes_application/src/core/di/app_component.dart';
import 'package:simple_notes_application/src/core/utils/app_dialogs.dart';
import 'package:simple_notes_application/src/core/utils/shared_preferences_helper.dart';

class SignOutViewModel extends AppBaseViewModel {
  void signOut() {
    showInformativeDialog(
      title: 'Information',
      message: '¿Are you sure you want to sign out?',
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

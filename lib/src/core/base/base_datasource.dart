import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:simple_notes_application/src/core/utils/shared_preferences_helper.dart';

abstract class BaseDatasource {
  Future<bool> validateConnection() async {
    final connectivity = await Connectivity().checkConnectivity();
    if (connectivity == ConnectivityResult.none) {
      throw ('The device is not connected to Internet');
    }
    return connectivity != ConnectivityResult.none;
  }

  Future<String?> get collectionName => SharedPreferenceHelper.getSessionToken();
}
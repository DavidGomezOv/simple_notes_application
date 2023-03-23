import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:simple_notes_application/src/core/constants/strings.dart';

abstract class BaseDatasource {
  Future<bool> validateConnection() async {
    final connectivity = await Connectivity().checkConnectivity();
    if (connectivity == ConnectivityResult.none) {
      throw (AppStrings().noInternetMessage);
    }
    return connectivity != ConnectivityResult.none;
  }
}

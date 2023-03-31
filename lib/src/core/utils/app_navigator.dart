import 'package:stacked_services/stacked_services.dart';

class AppNavigator extends NavigationService {
  Future<dynamic> push(String route, {dynamic arguments}) async =>
      await navigateTo(
        route,
        arguments: arguments,
      );
}

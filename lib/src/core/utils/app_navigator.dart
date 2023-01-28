import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

class AppNavigator extends NavigationService {
  pushReplacement(String route, {dynamic arguments}) =>
      pushNamedAndRemoveUntil(route, arguments: arguments);

  Future<dynamic> push(String route, {dynamic arguments}) async =>
      await navigateTo(
        route,
        arguments: arguments,
      );
}

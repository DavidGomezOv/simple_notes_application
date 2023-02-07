import 'package:injectable/injectable.dart';
import 'package:simple_notes_application/src/core/base/base_reactive_service.dart';
import 'package:stacked/stacked.dart';

@lazySingleton
class LoginService extends BaseReactiveService {
  final buttonLabel = ReactiveValue<String>('Get in');

  @factoryMethod
  LoginService.from() {
    listenToReactiveValues([
      loadingReactiveValue,
      buttonLabel,
    ]);
  }
}

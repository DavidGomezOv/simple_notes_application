import 'package:injectable/injectable.dart';
import 'package:simple_notes_application/src/auth/api/repository/auth_repository.dart';
import 'package:simple_notes_application/src/auth/model/login_model_request.dart';
import 'package:simple_notes_application/src/auth/model/register_model_request.dart';
import 'package:simple_notes_application/src/core/base/base_reactive_service.dart';
import 'package:simple_notes_application/src/core/constants/constants.dart';
import 'package:simple_notes_application/src/core/constants/strings.dart';
import 'package:simple_notes_application/src/core/utils/shared_preferences_helper.dart';
import 'package:stacked/stacked.dart';

@lazySingleton
class AuthService extends BaseReactiveService {
  final AuthRepository _repository;

  final buttonLabel = ReactiveValue<String>(AppStrings().loginButtonLabel);
  final ReactiveValue<LoginModelRequest> loginModelRequest =
      ReactiveValue(LoginModelRequest.init());
  final ReactiveValue<RegisterModelRequest> registerModelRequest =
      ReactiveValue(RegisterModelRequest.init());

  @factoryMethod
  AuthService.from(this._repository) {
    listenToReactiveValues([
      loadingReactiveValue,
      buttonLabel,
      loginModelRequest,
      registerModelRequest,
    ]);
  }

  Future<String?> doLogin(LoginModelRequest loginModelRequest) async {
    loadingReactiveValue.value = true;
    final userId = await _repository.doLogin(loginModelRequest).whenComplete(
          () => loadingReactiveValue.value = false,
        );
    if (userId != null && userId.isNotEmpty) {
      SharedPreferenceHelper.saveSessionToken(userId);
    }
    return userId;
  }

  Future<String?> register(RegisterModelRequest registerModelRequest) async {
    loadingReactiveValue.value = true;
    final userId =
        await _repository.register(registerModelRequest).whenComplete(
              () => loadingReactiveValue.value = false,
            );
    if (userId != null && userId.isNotEmpty) {
      SharedPreferenceHelper.saveSessionToken(userId);
    }
    return userId;
  }
}

import 'package:flutter/material.dart';
import 'package:simple_notes_application/src/auth/model/login_model_request.dart';
import 'package:simple_notes_application/src/auth/model/register_model_request.dart';
import 'package:simple_notes_application/src/auth/services/auth_service.dart';
import 'package:simple_notes_application/src/core/base/base_view_model.dart';
import 'package:simple_notes_application/src/core/constants/constants.dart';
import 'package:simple_notes_application/src/core/di/app_component.dart';
import 'package:stacked/stacked.dart';

class AuthViewModel extends AppBaseViewModel {
  final _authService = locator<AuthService>();

  bool get loading => _authService.loadingReactiveValue.value;

  String get buttonLabel => _authService.buttonLabel.value;

  LoginModelRequest get loginModelRequest =>
      _authService.loginModelRequest.value;

  RegisterModelRequest get registerModelRequest =>
      _authService.registerModelRequest.value;

  final BuildContext context;

  final TextEditingController controllerRegisterName = TextEditingController();
  final TextEditingController controllerRegisterEmail = TextEditingController();
  final TextEditingController controllerRegisterPassword =
      TextEditingController();

  TabController? tabController;

  bool isLogin = true;

  AuthViewModel(this.context);

  @override
  List<ListenableServiceMixin> get listenableServices => [
        _authService,
      ];

  void setTabController(TabController tabControllerView) {
    tabController = tabControllerView;
    tabController?.addListener(() {
      if (tabController!.index == 0) {
        isLogin = true;
        _authService.buttonLabel.value = Messages.loginButtonLabel;
      } else {
        isLogin = false;
        _authService.buttonLabel.value = Messages.registerButtonLabel;
      }
    });
  }

  @override
  void dispose() {
    tabController?.dispose();
    super.dispose();
  }

  void onEmailTextChanged(String value) {
    _authService.loginModelRequest.value.email = value;
  }

  void onPasswordTextChanged(String value) {
    _authService.loginModelRequest.value.password = value;
  }

  void onNameRegisterTextChanged(String value) {
    _authService.registerModelRequest.value.name = value;
  }

  void onEmailRegisterTextChanged(String value) {
    _authService.registerModelRequest.value.email = value;
  }

  void onPasswordRegisterTextChanged(String value) {
    _authService.registerModelRequest.value.password = value;
  }

  bool validateLoginButton() {
    if ((loginModelRequest.email != null &&
            loginModelRequest.email!.isNotEmpty) &&
        (loginModelRequest.password != null &&
            loginModelRequest.password!.isNotEmpty)) {
      return true;
    }
    handleApiResponse('Please enter all the information');
    return false;
  }

  bool validateRegisterButton() {
    if ((registerModelRequest.name != null &&
            registerModelRequest.name!.isNotEmpty) &&
        (registerModelRequest.email != null &&
            registerModelRequest.email!.isNotEmpty) &&
        (registerModelRequest.password != null &&
            registerModelRequest.password!.isNotEmpty)) {
      return true;
    }
    handleApiResponse('Please enter all the information');
    return false;
  }

  void handleButton() {
    if (isLogin) {
      doLogin();
    } else {
      doRegister();
    }
  }

  void doLogin() {
    if (!validateLoginButton()) return;
    _authService.doLogin(loginModelRequest).then((value) {
      if (value != null) {
        FocusScope.of(context).requestFocus(FocusNode());
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Authenticated Successfully')));
        appNavigator.back();
      }
    }).catchError((error) {
      handleApiResponse(error);
    });
  }

  void doRegister() {
    if (!validateRegisterButton()) return;
    _authService.register(registerModelRequest).then((value) {
      if (value != null) {
        FocusScope.of(context).requestFocus(FocusNode());
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Authenticated Successfully')));
        appNavigator.back();
      }
    }).catchError((error) {
      handleApiResponse(error);
    });
  }
}

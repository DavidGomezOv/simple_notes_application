import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_notes_application/src/core/base/base_view_model.dart';
import 'package:simple_notes_application/src/core/di/app_component.dart';
import 'package:simple_notes_application/src/login/services/login_service.dart';
import 'package:stacked/stacked.dart';

class LoginViewModel extends AppBaseViewModel {
  final _loginService = locator<LoginService>();

  bool get loading => _loginService.loadingReactiveValue.value;

  String get buttonLabel => _loginService.buttonLabel.value;

  final TextEditingController controllerRegisterName = TextEditingController();
  final TextEditingController controllerRegisterEmail = TextEditingController();
  final TextEditingController controllerRegisterPassword = TextEditingController();
  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();

  TabController? tabController;

  bool isLogin = true;

  @override
  List<ReactiveServiceMixin> get reactiveServices => [
        _loginService,
      ];

  void setTabController(TabController tabControllerView) {
    tabController = tabControllerView;
    tabController?.addListener(() {
      if (tabController!.index == 0) {
        isLogin = true;
        _loginService.buttonLabel.value = 'Get in';
      } else {
        isLogin = false;
        _loginService.buttonLabel.value = 'Sign up';
      }
    });
  }

  @override
  void dispose() {
    tabController?.dispose();
    super.dispose();
  }

  void handleButton() {
    _loginService.loadingReactiveValue.value = true;
    if (isLogin) {
      doLogin();
    } else {
      doRegister();
    }
  }

  void doLogin() {

  }

  void doRegister() {

  }
}

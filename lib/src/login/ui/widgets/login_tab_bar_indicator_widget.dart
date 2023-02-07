import 'package:flutter/material.dart';
import 'package:simple_notes_application/src/core/constants/constants.dart';
import 'package:simple_notes_application/src/core/extensions/generic_extensions.dart';
import 'package:simple_notes_application/src/login/view_mode/login_view_model.dart';
import 'package:stacked/stacked.dart';

class LoginTabBarIndicatorWidget extends ViewModelWidget<LoginViewModel> {
  const LoginTabBarIndicatorWidget({super.key});

  @override
  Widget build(BuildContext context, LoginViewModel viewModel) {
    return SizedBox(
      width: 300,
      height: 40,
      child: TabBar(
        labelStyle: const TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 16.0,
        ),
        indicatorColor: HexColor.fromHex(CustomColors.colorBlue),
        indicatorWeight: 3.0,
        unselectedLabelColor: HexColor.fromHex(CustomColors.colorWhite54),
        labelColor: HexColor.fromHex(CustomColors.colorBlue),
        controller: viewModel.tabController,
        tabs: const [
          Tab(
            text: 'Login',
          ),
          Tab(
            text: 'Register',
          ),
        ],
      ),
    );
  }
}

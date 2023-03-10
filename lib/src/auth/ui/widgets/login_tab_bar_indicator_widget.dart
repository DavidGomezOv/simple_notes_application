import 'package:flutter/material.dart';
import 'package:simple_notes_application/src/auth/view_mode/auth_view_model.dart';
import 'package:simple_notes_application/src/core/constants/constants.dart';
import 'package:simple_notes_application/src/core/constants/strings.dart';
import 'package:simple_notes_application/src/core/extensions/generic_extensions.dart';
import 'package:stacked/stacked.dart';

class LoginTabBarIndicatorWidget extends ViewModelWidget<AuthViewModel> {
  const LoginTabBarIndicatorWidget({super.key});

  @override
  Widget build(BuildContext context, AuthViewModel viewModel) {
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
        tabs: [
          Tab(
            text: AppStrings().loginTabLabel,
          ),
          Tab(
            text: AppStrings().registerTabLabel,
          ),
        ],
      ),
    );
  }
}

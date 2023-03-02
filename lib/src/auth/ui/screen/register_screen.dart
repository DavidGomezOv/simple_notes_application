import 'package:flutter/material.dart';
import 'package:simple_notes_application/src/auth/ui/widgets/login_text_field_widget.dart';
import 'package:simple_notes_application/src/auth/view_mode/auth_view_model.dart';
import 'package:simple_notes_application/src/core/constants/constants.dart';
import 'package:simple_notes_application/src/core/constants/strings.dart';
import 'package:simple_notes_application/src/core/extensions/generic_extensions.dart';
import 'package:stacked/stacked.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AuthViewModel>.reactive(
      viewModelBuilder: () => AuthViewModel(context),
      builder: (context, viewModel, child) => SingleChildScrollView(
        child: Container(
          color: HexColor.fromHex(CustomColors.colorBlack74),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LoginTextFieldWidget(
                      hintText: AppStrings().nameHint,
                      controller: viewModel.controllerRegisterName,
                      inputType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      onChanged: viewModel.onNameRegisterTextChanged,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    LoginTextFieldWidget(
                      hintText: AppStrings().emailHint,
                      controller: viewModel.controllerRegisterEmail,
                      inputType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      onChanged: viewModel.onEmailRegisterTextChanged,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    LoginTextFieldWidget(
                      hintText: AppStrings().passwordHint,
                      controller: viewModel.controllerRegisterPassword,
                      obscureText: true,
                      inputType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.done,
                      onChanged: viewModel.onPasswordRegisterTextChanged,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

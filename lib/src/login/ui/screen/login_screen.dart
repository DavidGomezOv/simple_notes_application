import 'package:flutter/material.dart';
import 'package:simple_notes_application/src/core/constants/constants.dart';
import 'package:simple_notes_application/src/core/extensions/generic_extensions.dart';
import 'package:simple_notes_application/src/login/ui/widgets/login_text_field_widget.dart';
import 'package:simple_notes_application/src/login/view_mode/login_view_model.dart';
import 'package:stacked/stacked.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () => LoginViewModel(),
      builder: (context, viewModel, child) => Container(
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
                    hintText: 'Email',
                    controller: viewModel.controllerEmail,
                    inputType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  LoginTextFieldWidget(
                    hintText: 'Password',
                    controller: viewModel.controllerPassword,
                    obscureText: true,
                    inputType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

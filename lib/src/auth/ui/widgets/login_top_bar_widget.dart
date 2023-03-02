import 'package:flutter/material.dart';
import 'package:simple_notes_application/src/auth/view_mode/auth_view_model.dart';
import 'package:simple_notes_application/src/core/constants/constants.dart';
import 'package:simple_notes_application/src/core/constants/strings.dart';
import 'package:simple_notes_application/src/core/extensions/generic_extensions.dart';
import 'package:stacked/stacked.dart';

class LoginTopBarWidget extends ViewModelWidget<AuthViewModel> {
  const LoginTopBarWidget({super.key});

  @override
  Widget build(BuildContext context, AuthViewModel viewModel) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        padding: const EdgeInsets.only(
          left: 14,
          right: 14,
          bottom: 30,
        ),
        height: MediaQuery.of(context).size.height / 5.5,
        width: double.infinity,
        decoration: BoxDecoration(
          color: HexColor.fromHex(CustomColors.colorTurquoise),
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(20),
          ),
        ),
        child: Align(
          alignment: AlignmentDirectional.bottomStart,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings().welcomeLabel,
                style: const TextStyle(
                  fontSize: 32,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                AppStrings().registerInvitationLabel,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

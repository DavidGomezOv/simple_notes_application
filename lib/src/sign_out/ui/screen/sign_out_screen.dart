import 'package:flutter/material.dart';
import 'package:simple_notes_application/src/core/constants/constants.dart';
import 'package:simple_notes_application/src/core/extensions/generic_extensions.dart';
import 'package:simple_notes_application/src/sign_out/view_model/sign_out_view_model.dart';
import 'package:stacked/stacked.dart';

class SignOutScreen extends StatelessWidget {
  const SignOutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignOutViewModel>.reactive(
      viewModelBuilder: () => SignOutViewModel(),
      builder: (context, viewModel, child) => SafeArea(
        child: Scaffold(
          body: Container(
            color: HexColor.fromHex(CustomColors.colorBlack74),
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(),
                const Text(
                  "You are already logged in",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Your information is saved so you wont lose it",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "You can log out but the notes will save locally on your phone",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "You can log in anytime you want",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                const Spacer(),
                MaterialButton(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  onPressed: viewModel.signOut,
                  child: const Text(
                    'Sign out',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

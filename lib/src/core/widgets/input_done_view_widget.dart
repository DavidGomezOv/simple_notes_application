import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_notes_application/src/core/constants/strings.dart';

class InputDoneView extends StatelessWidget {
  const InputDoneView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white12,
      child: Align(
        alignment: Alignment.topRight,
        child: CupertinoButton(
          padding: const EdgeInsets.only(right: 24.0, top: 8.0, bottom: 8.0),
          onPressed: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Text(AppStrings().doneLabel,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.normal)),
        ),
      ),
    );
  }
}

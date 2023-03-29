import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_notes_application/src/core/widgets/pin_code_fields_widgets.dart';

class InputNotePinCenterSheet extends StatelessWidget {
  final String title;
  final String description;
  final String mainButtonTitle;
  final String secondaryButtonTitle;
  final Function(String? pin)? accept;
  Function()? cancel;
  final bool autoAccept;

  String? _pinData;

  InputNotePinCenterSheet({
    Key? key,
    required this.title,
    required this.description,
    required this.mainButtonTitle,
    required this.secondaryButtonTitle,
    required this.accept,
    this.autoAccept = false,
    this.cancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SizedBox(
        width: double.maxFinite,
        child: Container(
          padding: const EdgeInsets.only(
            top: 10,
            right: 10,
            left: 10,
            bottom: 6,
          ),
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.only(left: 5, bottom: 10, top: 4),
                width: double.maxFinite,
                child: Text(
                  title ?? '',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: double.maxFinite,
                padding: const EdgeInsets.only(left: 5, bottom: 10),
                child: Text(
                  description ?? '',
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                  maxLines: 15,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              PinCodeFields(
                length: 4,
                obscureText: true,
                obscureCharacter: "●",
                borderWidth: 5.0,
                activeBorderColor: Colors.purpleAccent,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                autofocus: true,
                textStyle: const TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
                onComplete: (text) {
                  _pinData = text;
                  if (autoAccept) {
                    accept?.call(_pinData);
                  }
                  FocusScope.of(context).unfocus();
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  MaterialButton(
                    onPressed: cancel,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14.0),
                      child: Text(
                        secondaryButtonTitle.toUpperCase() ?? '',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.deepPurpleAccent,
                        ),
                      ),
                    ),
                  ),
                  MaterialButton(
                    onPressed: () => accept?.call(_pinData),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      child: Text(
                        mainButtonTitle.toUpperCase() ?? '',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.deepPurpleAccent,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}

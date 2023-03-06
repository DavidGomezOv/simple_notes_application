import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_notes_application/src/auth/view_mode/auth_view_model.dart';
import 'package:simple_notes_application/src/core/constants/constants.dart';
import 'package:simple_notes_application/src/core/extensions/generic_extensions.dart';
import 'package:stacked/stacked.dart';

class LoginTextFieldWidget extends ViewModelWidget<AuthViewModel> {
  final String? hintText;
  final TextInputType? inputType;
  final String? content;
  final double? fontSize;
  final int? maxLines;
  final bool? obscureText;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final bool? autoFocus;
  final Function(bool)? focusEvent;
  final TextCapitalization? textCapitalization;
  final Function? onTap;
  final bool? enabled;
  final TextInputAction? textInputAction;

  const LoginTextFieldWidget({
    super.key,
    required this.hintText,
    this.content = '',
    this.inputType = TextInputType.text,
    this.fontSize = CustomFontSize.loginInputField,
    this.maxLines = 1,
    this.obscureText = false,
    this.maxLength = 50,
    this.inputFormatters,
    this.controller,
    this.autoFocus = false,
    this.onChanged,
    this.focusEvent,
    this.textCapitalization = TextCapitalization.none,
    this.onTap,
    this.enabled = true,
    this.textInputAction = TextInputAction.done,
  });

  @override
  Widget build(BuildContext context, AuthViewModel viewModel) {
    return TextField(
      enabled: enabled,
      onTap: onTap?.call(),
      autofocus: autoFocus ?? false,
      controller: controller,
      cursorColor: HexColor.fromHex(CustomColors.colorBlue),
      keyboardType: inputType,
      maxLines: maxLines,
      maxLength: maxLength,
      maxLengthEnforcement: MaxLengthEnforcement.enforced,
      obscureText: obscureText!,
      textCapitalization: textCapitalization!,
      style: TextStyle(fontSize: fontSize, color: Colors.white),
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
          borderSide:
              BorderSide(color: HexColor.fromHex(CustomColors.colorBlue)),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide:
          BorderSide(color: HexColor.fromHex(CustomColors.colorWhite38)),
        ),
        counterText: "",
        labelText: hintText,
        labelStyle:
            TextStyle(color: HexColor.fromHex(CustomColors.colorWhite54)),
      ),
      inputFormatters: inputFormatters,
      onChanged: onChanged,
      textInputAction: textInputAction,
    );
  }
}

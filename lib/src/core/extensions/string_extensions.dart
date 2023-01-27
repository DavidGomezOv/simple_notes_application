import 'dart:convert';
import 'dart:core';
import 'dart:ui';

import 'package:simple_notes_application/src/core/enums/enums.dart';
import 'package:simple_notes_application/src/core/extensions/generic_extensions.dart';

extension StringExtension on String {
  FontStyle getFontStyle() {
    if (stringToEnum(this) == TextType.italicBold) {
      return FontStyle.italic;
    } else if (stringToEnum(this) == TextType.italic) {
      return FontStyle.italic;
    } else if (stringToEnum(this) == TextType.bold) {
      return FontStyle.normal;
    } else {
      return FontStyle.normal;
    }
  }

  FontWeight getFontWeight() {
    if (stringToEnum(this) == TextType.italicBold) {
      return FontWeight.bold;
    } else if (stringToEnum(this) == TextType.italic) {
      return FontWeight.normal;
    } else if (stringToEnum(this) == TextType.bold) {
      return FontWeight.bold;
    } else {
      return FontWeight.normal;
    }
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simple_notes_application/src/core/enums/enums.dart';

extension HexColor on Color {
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

extension TextTypeExtension on TextType {
  String asString() => toString().split('.').last;
}

TextType? stringToEnum(String? value) {
  return <String, TextType>{
    'bold': TextType.bold,
    'italic': TextType.italic,
    'italicBold': TextType.italicBold,
    'normal': TextType.normal,
  }[value];
}

extension DateString on DateTime {
  String formatDate() => DateFormat('MMM d, yyyy - h:mm aaa').format(this);
}

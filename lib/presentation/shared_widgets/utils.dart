import 'package:flutter/material.dart';

void navigateTo(context, destination) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
    return destination;
  }));
}

void navigateAndFinish(context, destination) {
  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) {
    return destination;
  }), (route) => false);
}

Color convertToColor(String colorStr) {
  String valueString =
      colorStr.split('(0x')[1].split(')')[0]; // kind of hacky..
  int value = int.parse(valueString, radix: 16);
  return Color(value);
}

bool toBoolean(String value) {
  if ((value.toLowerCase() == "true" || value.toLowerCase() == "1")) {
    return true;
  } else if ((value.toLowerCase() == "false" || value.toLowerCase() == "0")) {
    return false;
  } else {
    return false;
  }
}

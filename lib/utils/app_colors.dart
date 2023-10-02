import 'package:flutter/material.dart';

hexStringToColor(String hexColor, double opacity) {
  hexColor = hexColor.toUpperCase().replaceAll("#", "");
  if (hexColor.length == 6) {
    hexColor = "FF" + hexColor;
  }

  return Color(int.parse(hexColor, radix: 16)).withOpacity(opacity);
}

String colorShadow = "shadow";
String colorMidtone = "midtone";
String colorHighlight = "highlight";
String colorAccent = "accent";
String colorBlack = "black";
String colorWhite = "white";

// BROWN VERSION
String hexShadow = "0d253f";
// String hexMidtone = "01b4e4";
String hexHighlight = "01b4e4";
String hexAccent = "90cea1";

String hexBlack = "000b17";
String hexWhite = "ffffff";

appColor(String type, {double opacity = 1.0}) {
  if (type == colorShadow) {
    return hexStringToColor(hexShadow, opacity);
  } else if (type == colorHighlight) {
    return hexStringToColor(hexHighlight, opacity);
  } else if (type == colorAccent) {
    return hexStringToColor(hexAccent, opacity);
  } else if (type == colorBlack) {
    return hexStringToColor(hexBlack, opacity);
  } else if (type == colorWhite) {
    return hexStringToColor(hexWhite, opacity);
  }
}

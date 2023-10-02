import 'package:flutter/material.dart';

hexStringToColor(String hexColor) {
  hexColor = hexColor.toUpperCase().replaceAll("#", "");
  if (hexColor.length == 6) {
    hexColor = "FF" + hexColor;
  }
  return Color(int.parse(hexColor, radix: 16));
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

String hexBlack = "1f1f1f";
String hexWhite = "ffffff";

appColor(String type) {
  if (type == colorShadow) {
    return hexStringToColor(hexShadow);
  } else if (type == colorHighlight) {
    return hexStringToColor(hexHighlight);
  } else if (type == colorAccent) {
    return hexStringToColor(hexAccent);
  } else if (type == colorBlack) {
    return hexStringToColor(hexBlack);
  } else if (type == colorWhite) {
    return hexStringToColor(hexWhite);
  }
}

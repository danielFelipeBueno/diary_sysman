import 'package:flutter/material.dart';

//% CURRENT THEME

bool isDarkMode(BuildContext ctx){
  final Brightness brightness = Theme.of(ctx).brightness;
  return brightness == Brightness.dark;
}

//% COLORS

var kPrimaryColor =  const Color(0xff5856D6);
var kSecondaryColor =  const Color(0xffE6E5F9);
var kSecondaryDarkColor = const Color(0xff27253B);

//% Text Style

var h1Style = const TextStyle(
  fontSize: 32,
  fontWeight: FontWeight.bold,
  height: 1.1
);

var h2Style = const TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.w500,
  height: 1.1
);


var h3StyleSemiBold = const TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w600,
  height: 1.1,
  color: Color(0xff49454F)
);

var h3Style = const TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w600,
  height: 1.1
);

var h3ButtonStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w500,
  color: kPrimaryColor,
  height: 1.1
);

var h4Style = const TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w600,
  height: 1.1
);

var h5Style = const TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w600,
  color: Color(0xff8A8A8E),
  height: 1.1
);

var h1HintStyle = const TextStyle(
  color: Color(0xffB8B9B8),
  fontSize: 34,
  fontWeight: FontWeight.w500,
  height: 1.1
);

var h5HintStyle = const TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w600,
  color: Color(0xffB8B9B8),
  height: 1.1
);

//% BORDER RADIUS

var borderRadius12 = const BorderRadius.all(Radius.circular(12));


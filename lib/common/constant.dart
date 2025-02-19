import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

double defaultPadding = 20;
double defaultBorderRadius = 15;

String baseUrl() {
  return "http://138.91.164.57:5050";
  // return "http://192.168.87.227:5050";
}

String baseImageUrl() {
  return "http://138.91.164.57";
  // return "http://192.168.87.227:5050";
}

String baseApiUrl() {
  return "${baseUrl()}/api";
}
// String baseAPIURL() {
//   return "https://pengaduan-masyarakat.byraq-tech.com/api";
// }

Map<String, String> header(
  bool isNeedToken, {
  String? token,
}) {
  if (isNeedToken == true) {
    return {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
  } else {
    return {
      'Accept': 'application/json',
    };
  }
}

String formatTime(bool isDate, {DateTime? date}) {
  final DateFormat formatterDate = DateFormat('dd MMM yyyy', 'id');
  final DateFormat formatterJam = DateFormat('HH.mm');
  String formattedDate = "";

  if (isDate) {
    formattedDate = formatterDate.format(date!.add(const Duration(hours: 7)));

    return formattedDate;
  } else {
    formattedDate = formatterJam.format(date!.add(const Duration(hours: 7)));

    return formattedDate;
  }
}

void setStatusBarColorBasedOnTheme(BuildContext context) {
  final theme = Theme.of(context);
  final backgroundColor = white;
  final brightness = theme.brightness;

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: backgroundColor,
      statusBarIconBrightness:
          brightness == Brightness.light ? Brightness.dark : Brightness.light,
      statusBarBrightness: brightness,
    ),
  );
}

const storage = FlutterSecureStorage(
  aOptions: AndroidOptions(
    encryptedSharedPreferences: true,
  ),
);

double height(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

double width(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

bool isPotrait(BuildContext context) {
  return MediaQuery.of(context).orientation == Orientation.portrait;
}

bool keyboardIsOpen(BuildContext context) {
  return MediaQuery.of(context).viewInsets.bottom != 0;
}

Color primaryColor = const Color(0xffff7b00);
Color secondaryColor = const Color(0xFF43afc8);
Color sionYellowColor = const Color(0xffFFD600);
Color darkColor = const Color(0xff141118);
Color tertiary500 = const Color(0xFF2632ff);
Color tertiary400 = const Color(0xFF6569ff);
Color tertiary300 = const Color(0xFF9597FF);
Color grey700 = const Color(0xFF111114);
Color grey600 = const Color(0xFF2b2b30);
Color grey500 = const Color(0xFF4b4b53);
Color grey400 = const Color(0xFF6d6d75);
Color black1 = const Color(0xFF18181b);
Color black2 = const Color(0xFF09090b);
Color white = const Color(0xFFFFFFFF);

BoxShadow primaryShadow = BoxShadow(
  blurRadius: 5,
  color: grey400.withOpacity(0.3),
);

FontWeight light = FontWeight.w300;
FontWeight regular = FontWeight.w400;
FontWeight medium = FontWeight.w500;
FontWeight semiBold = FontWeight.w600;
FontWeight bold = FontWeight.w700;
FontWeight extraBold = FontWeight.w800;

TextStyle primaryTextStyle = GoogleFonts.poppins(
  color: white,
  fontWeight: regular,
);

TextStyle secondaryTextStyle = GoogleFonts.poppins(
  color: black1,
  fontWeight: regular,
);

TextStyle eduPelitaTextStyle = GoogleFonts.comfortaa(
  color: black1,
  fontWeight: regular,
);

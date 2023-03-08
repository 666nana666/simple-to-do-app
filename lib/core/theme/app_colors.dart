// ignore_for_file: use_full_hex_values_for_flutter_colors

import 'package:flutter/material.dart';

class AppColors {
  ///Hex from backend
  static Color stringToColor(String? source) {
    try {
      return Color(int.parse('0XFF$source'));
    } catch (e) {
      return Colors.white;
    }
  }

// SETUP COLORS
  static const MaterialColor secondary = MaterialColor(0xff00AB55, <int, Color>{
    300: Color(0xffC8FACD),
    400: Color(0xff5BE584),
    500: Color(0xff00AB55),
    600: Color(0xff007B55),
    700: Color(0xff005249),
  });

  static const MaterialColor primary = MaterialColor(0xff3366FF, <int, Color>{
    300: Color(0xffD6E4FF),
    400: Color(0xff84A9FF),
    500: Color(0xff3366FF),
    600: Color(0xff1939B7),
    700: Color(0xff091A7A),
  });

  static const MaterialColor info = MaterialColor(0xff1890FF, <int, Color>{
    300: Color(0xffD0F2FF),
    400: Color(0xff74CAFF),
    500: Color(0xff1890FF),
    600: Color(0xff0C53B7),
    700: Color(0xff04297A),
  });

  static const MaterialColor success = MaterialColor(0xff54D62C, <int, Color>{
    300: Color(0xffE9FCD4),
    400: Color(0xffAAF27F),
    500: Color(0xff54D62C),
    600: Color(0xff229A16),
    700: Color(0xff08660D),
  });

  static const MaterialColor warning = MaterialColor(0xffFFC107, <int, Color>{
    300: Color(0xffFFF7CD),
    400: Color(0xffFFE16A),
    500: Color(0xffFFC107),
    600: Color(0xffB78103),
    700: Color(0xff7A4F01),
  });

  static const MaterialColor error = MaterialColor(0xffFF4842, <int, Color>{
    300: Color(0xffFFE7D9),
    400: Color(0xffFFA48D),
    500: Color(0xffFF4842),
    600: Color(0xffB72136),
    700: Color(0xff7A0C2E),
  });

  static const MaterialColor grey = MaterialColor(0xff919EAB, <int, Color>{
    0: Color(0xffFFFFFF),
    100: Color(0xffF9FAFB),
    200: Color(0xffF4F6F8),
    300: Color(0xffDFE3E8),
    400: Color(0xffC4CDD5),
    500: Color(0xff919EAB),
    600: Color(0xff637381),
    700: Color(0xff454F5B),
    800: Color(0xff212B36),
    900: Color(0xff161C24),
  });

   static const Color textPrimary =  Color(0xff3333333);
   static const Color textSecondary=  Color(0xff5F605F);
   static const Color textWhite =  Color(0xFFFFFFFF);
   static const Color iconGrey =  Color(0xFF8C8D8C);
   static const Color border =  Color(0xFFE5E6E5);
}

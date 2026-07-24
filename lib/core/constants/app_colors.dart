import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  //========================
  // Brand Colors
  //========================

  static const Color primary = Color(0xff6C63FF);
  static const Color secondary = Color(0xff03DAC6);
  static const Color accent = Color(0xffFF6584);

  static const Color success = Color(0xff4CAF50);
  static const Color warning = Color(0xffFFB74D);
  static const Color danger = Color(0xffEF5350);

  //========================
  // Light Theme
  //========================

  static const Color lightBackground = Color(0xffF7F9FC);

  static const Color lightSurface = Colors.white;

  static const Color lightCard = Colors.white;

  static const Color lightText = Color(0xff1D1D35);

  static const Color lightSubtitle = Color(0xff6B7280);

  //========================
  // Dark Theme
  //========================

  static const Color darkBackground = Color(0xff0F172A);

  static const Color darkSurface = Color(0xff1E293B);

  static const Color darkCard = Color(0xff243447);

  static const Color darkText = Colors.white;

  static const Color darkSubtitle = Color(0xffB0BEC5);

  //========================
  // Light Gradient
  //========================

  static const List<Color> lightBackgroundGradient = [

    Color(0xffF6F8FC),

    Color(0xffE3F2FD),

    Color(0xffD6E4FF),

    Color(0xffEDF2FF),

  ];

  //========================
  // Dark Gradient
  //========================

  static const List<Color> darkBackgroundGradient = [

    Color(0xff081120),

    Color(0xff0F1C2E),

    Color(0xff182A46),

    Color(0xff1E3558),

  ];

  //========================
  // Button Gradient
  //========================

  static const List<Color> primaryGradient = [

    Color(0xff6C63FF),

    Color(0xff7B74FF),

    Color(0xff928DFF),

  ];

  static const List<Color> secondaryGradient = [

    Color(0xff03DAC6),

    Color(0xff00BFA5),

  ];

  //========================
  // Card Gradient
  //========================

  static const List<Color> glassGradient = [

    Color.fromRGBO(255, 255, 255, .25),

    Color.fromRGBO(255, 255, 255, .08),

  ];

  //========================
  // Avatar Colors
  //========================

  static const List<Color> avatarGradient = [

    Color(0xff6C63FF),

    Color(0xff03DAC6),

  ];

  //========================
  // Shadow
  //========================

  static Color shadow = Colors.black.withOpacity(.08);

  static Color glow = const Color(0xff6C63FF).withOpacity(.28);

  //========================
  // Category Colors
  //========================

  static const Color work = Color(0xff6C63FF);

  static const Color personal = Color(0xff03DAC6);

  static const Color study = Color(0xffFF9800);

  static const Color fitness = Color(0xffE91E63);

  static Color categoryColor(String category) {
    switch (category) {
      case "Work":
        return work;

      case "Personal":
        return personal;

      case "Study":
        return study;

      case "Fitness":
        return fitness;

      default:
        return primary;
    }
  }
}
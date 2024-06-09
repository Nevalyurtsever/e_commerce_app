import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class AppTypography {
  static final lightTitleStyle = GoogleFonts.poppins(
    fontSize: 24,
    fontWeight: FontWeight.w600,
  );
  static final darkTitleStyle = GoogleFonts.poppins(
    fontSize: 24,
    fontWeight: FontWeight.w600,
  );

  static final boldSubtitleStyle = GoogleFonts.poppins(
    height: 0.5,
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );

  static final bodyMedium = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );
  static const contentMedium = TextStyle(
    fontSize: 12,
    fontFamily: "AirbnbCereal_W_Bk",
    color: Colors.black45,
  );
  static const contentMediumDark = TextStyle(
    fontSize: 12,
    fontFamily: "AirbnbCereal_W_Bk",
    color: Colors.white30,
  );
}

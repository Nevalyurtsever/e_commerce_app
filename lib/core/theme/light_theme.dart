import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_palette.dart';

ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppPalette.primary,
        textStyle: GoogleFonts.poppins(
          color: AppPalette.primary,
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.all<Color>(const Color(0xFF53B175)),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
    ),
    iconButtonTheme: IconButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppPalette.primary,
        textStyle: GoogleFonts.poppins(
          color: AppPalette.primary,
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppPalette.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        foregroundColor: Colors.white,
        textStyle: GoogleFonts.poppins(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    badgeTheme: const BadgeThemeData(textColor: AppPalette.lightBorderGray));

// ThemeData(
//     scaffoldBackgroundColor: const Color(0xfff6f6f6),
//     useMaterial3: true,
//     bottomSheetTheme: const BottomSheetThemeData(
//       backgroundColor: AppPalette.neutralDarkest,
//     ),
//     bottomNavigationBarTheme: const BottomNavigationBarThemeData(
//       selectedItemColor: Color(0xff00AB67),
//       unselectedItemColor: Colors.black45,
//       selectedIconTheme: IconThemeData(
//         color: Color(0xff00AB67),
//       ),
//       unselectedIconTheme: IconThemeData(
//         color: Colors.black45,
//       ),
//     ),
//     inputDecorationTheme: InputDecorationTheme(
//       fillColor: Colors.white,
//       filled: true,
//       suffixIconColor: Colors.grey.shade400,
//       hintStyle: GoogleFonts.poppins(
//         color: const Color(0xFF667084),
//         fontSize: 14,
//         fontWeight: FontWeight.w400,
//       ),
//       border: OutlineInputBorder(
//         borderSide: const BorderSide(
//           color: Color(0xffd6d6d6),
//           width: 1,
//         ),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderSide: const BorderSide(
//           color: AppPalette.primary,
//           width: 1,
//         ),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       enabledBorder: OutlineInputBorder(
//         borderSide: const BorderSide(
//           color: Color(0xffd6d6d6),
//           width: 1,
//         ),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       labelStyle: GoogleFonts.poppins(
//         color: const Color(0xff667084),
//         fontSize: 14,
//         fontWeight: FontWeight.w500,
//       ),
//     ),
//     textSelectionTheme: TextSelectionThemeData(
//       cursorColor: Colors.grey.shade400,
//     ),
//     elevatedButtonTheme: ElevatedButtonThemeData(
//       style: ElevatedButton.styleFrom(
//         backgroundColor: AppPalette.neutralDarker,
//         disabledBackgroundColor: AppPalette.neutralDarker.withOpacity(.5),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12),
//         ),
//         textStyle: GoogleFonts.poppins(
//           color: Colors.white,
//           fontSize: 16,
//           fontWeight: FontWeight.w500,
//         ),
//       ),
//     ),
//     outlinedButtonTheme: OutlinedButtonThemeData(
//       style: OutlinedButton.styleFrom(
//         textStyle: GoogleFonts.poppins(
//           color: const Color(0xFF273142),
//           fontSize: 14,
//           fontWeight: FontWeight.w500,
//         ),
//         foregroundColor: AppPalette.neutralDarker,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10),
//         ),
//         side: const BorderSide(
//           color: AppPalette.secondry,
//           width: 1,
//         ),
//       ),
//     ),
//     floatingActionButtonTheme: const FloatingActionButtonThemeData(
//         backgroundColor: AppPalette.neutralDarkest),
//     textButtonTheme: TextButtonThemeData(
//       style: TextButton.styleFrom(
//         foregroundColor: AppPalette.primary,
//         textStyle: GoogleFonts.poppins(
//           color: AppPalette.primary,
//           fontSize: 15,
//           fontWeight: FontWeight.w500,
//         ),
//       ),
//     ),
//     appBarTheme: AppBarTheme(
//       backgroundColor: Colors.white,
//       elevation: 0,
//       iconTheme: const IconThemeData(color: Colors.black87),
//       titleTextStyle: GoogleFonts.poppins(
//         color: const Color(0xff0b0c0e),
//         fontSize: 16,
//         fontWeight: FontWeight.w500,
//       ),
//     ),
//     listTileTheme: ListTileThemeData(
//         tileColor: Colors.white,
//         style: ListTileStyle.list,
//         titleTextStyle: GoogleFonts.poppins(
//           color: const Color(0xFF2D3139),
//           fontSize: 14,
//           fontWeight: FontWeight.w500,
//         ),
//         textColor: AppPalette.neutralDarker),
//     tabBarTheme: TabBarTheme(
//       labelColor: AppPalette.neutralDarkest,
//       unselectedLabelColor: const Color(0xff808080),
//       indicatorColor: AppPalette.neutralDarkest,
//       unselectedLabelStyle: GoogleFonts.poppins(
//         fontSize: 14,
//         fontWeight: FontWeight.w500,
//       ),
//       labelStyle: GoogleFonts.poppins(
//         fontSize: 14,
//         fontWeight: FontWeight.w500,
//       ),
//       labelPadding: EdgeInsets.zero,
//       indicator: const UnderlineTabIndicator(
//         borderSide: BorderSide(color: AppPalette.neutralDarkest, width: 2),
//       ),
//     ),
//     sliderTheme: const SliderThemeData(
//         thumbShape: RoundSliderThumbShape(enabledThumbRadius: 0),
//         trackHeight: 2),
//     primaryColor: const Color.fromRGBO(173, 20, 87, 1),
//     textTheme: TextTheme(
//       titleLarge: GoogleFonts.poppins(
//         color: AppPalette.primary,
//         fontSize: 24,
//         fontWeight: FontWeight.w500,
//       ),
//       titleMedium: GoogleFonts.poppins(
//         // Default text input style
//         color: const Color(0xFF0F1728),
//         fontSize: 14,
//         fontWeight: FontWeight.w500,
//       ),
//       titleSmall: GoogleFonts.poppins(
//         color: const Color(0xFF2D3139),
//         fontSize: 20,
//         fontWeight: FontWeight.w500,
//       ),
//       headlineLarge: GoogleFonts.poppins(
//         // 16 / Semibold
//         color: Colors.black,
//         fontSize: 16,
//         fontWeight: FontWeight.w600,
//       ),
//       headlineMedium:

//           //  GoogleFonts.poppins(
//           //   // 16 / medium
//           //   color: Colors.black,
//           //   fontSize: 16,
//           //   fontWeight: FontWeight.w500,
//           // ),

//           const TextStyle(
//               fontSize: 16,
//               fontFamily: "AirbnbCereal_W_Bd",
//               color: Colors.black87),
//       headlineSmall:
//           //  GoogleFonts.poppins(
//           //   // 16 / Regular
//           //   color: Colors.black,
//           //   fontSize: 16,
//           //   fontWeight: FontWeight.w400,
//           // ),
//           const TextStyle(
//               fontFamily: "AirbnbCereal_W_Bk",
//               fontSize: 12,
//               color: Colors.white),
//       displayLarge: GoogleFonts.poppins(
//         // 14 / Semibold
//         color: Colors.black,
//         fontSize: 14,
//         fontWeight: FontWeight.w600,
//       ),
//       displayMedium:
//           //  GoogleFonts.poppins(
//           //   // 14 / medium
//           //   // color: neutralDarker,
//           //   fontSize: 14,
//           //   fontWeight: FontWeight.w500,
//           //   color: const Color(0xFF344053),
//           // ),

//           const TextStyle(
//               fontSize: 14,
//               fontFamily: "AirbnbCereal_W_Md",
//               color: Colors.black87),
//       displaySmall: GoogleFonts.poppins(
//         // 14 / Regular
//         color: const Color(0xFF344053),
//         fontSize: 14,
//         fontWeight: FontWeight.w400,
//       ),
//       bodyLarge: GoogleFonts.poppins(
//         // 12 / Semibold
//         color: Colors.black,
//         fontSize: 12,
//         fontWeight: FontWeight.w600,
//       ),
//       bodyMedium: GoogleFonts.poppins(
//         // 12 / medium
//         color: const Color(0xff344053),
//         fontSize: 12,
//         fontWeight: FontWeight.w500,
//       ),
//       bodySmall: GoogleFonts.poppins(
//         // 12 / Regular
//         color: Colors.black,
//         fontSize: 12,
//         fontWeight: FontWeight.w400,
//       ),
//       labelLarge: GoogleFonts.poppins(
//         // 10 / Semibold
//         color: Colors.black,
//         fontSize: 10,
//         fontWeight: FontWeight.w600,
//       ),
//       labelMedium: GoogleFonts.poppins(
//         // 10 / Medium
//         color: Colors.black,
//         fontSize: 10,
//         fontWeight: FontWeight.w500,
//       ),
//       labelSmall: GoogleFonts.poppins(
//         // 10 / Regular
//         //   color: const Color(0xff667085),
//         color: Colors.black,
//         fontSize: 10,
//         fontWeight: FontWeight.w400,
//       ),
//     ),
//     cardColor: Colors.white);

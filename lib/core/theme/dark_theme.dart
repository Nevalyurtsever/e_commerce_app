import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_palette.dart';

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
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
    fillColor: MaterialStateProperty.all<Color>(
      AppPalette.primary,
    ),
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
      textStyle: GoogleFonts.poppins(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    ),
  ),
  badgeTheme: const BadgeThemeData(textColor: AppPalette.darkBorderGray),
);

// ThemeData(
//   useMaterial3: true,
//   cupertinoOverrideTheme: const NoDefaultCupertinoThemeData(
//       brightness: Brightness.dark, primaryColor: eAppPaltte.primary),
//   brightness: Brightness.dark,
//   scaffoldBackgroundColor: AppPalette.neutralDarker,
//   hintColor: AppPalette.neutralLightest,
//   bottomSheetTheme: const BottomSheetThemeData(
//     backgroundColor: AppPalette.neutralDarkest,
//   ),
//   bottomNavigationBarTheme: const BottomNavigationBarThemeData(
//     selectedItemColor: Color(0xff00AB67),
//     unselectedItemColor: Colors.white60,
//     selectedIconTheme: IconThemeData(
//       color: Color(0xff00AB67),
//     ),
//     unselectedIconTheme: IconThemeData(color: Colors.white60),
//   ),
//   inputDecorationTheme: InputDecorationTheme(
//     filled: true,
//     suffixIconColor: Colors.grey.shade400,
//     hintStyle: GoogleFonts.poppins(
//       color: Colors.white70,
//       fontSize: 14,
//       fontWeight: FontWeight.w400,
//     ),
//     border: OutlineInputBorder(
//       borderSide: const BorderSide(
//         color: Color(0xffd6d6d6),
//         width: 1,
//       ),
//       borderRadius: BorderRadius.circular(12),
//     ),
//     focusedBorder: OutlineInputBorder(
//       borderSide: const BorderSide(
//         color: AppPalette.primary,
//         width: 1,
//       ),
//       borderRadius: BorderRadius.circular(12),
//     ),
//     enabledBorder: OutlineInputBorder(
//       borderSide: const BorderSide(
//         color: Color(0xffd6d6d6),
//         width: 1,
//       ),
//       borderRadius: BorderRadius.circular(12),
//     ),
//     labelStyle: GoogleFonts.poppins(
//       color: const Color(0xff667084),
//       fontSize: 14,
//       fontWeight: FontWeight.w500,
//     ),
//   ),
//   textSelectionTheme: TextSelectionThemeData(
//     cursorColor: Colors.grey.shade400,
//   ),
//   chipTheme: const ChipThemeData(
//     backgroundColor: Colors.grey,
//   ),
//   dividerColor: Colors.white,
//   elevatedButtonTheme: ElevatedButtonThemeData(
//     style: ElevatedButton.styleFrom(
//       backgroundColor: AppPalette.primary,
//       disabledBackgroundColor: AppPalette.primaryContrast,
//       disabledForegroundColor: Colors.black,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12),
//       ),
//       textStyle: GoogleFonts.poppins(
//         color: Colors.white,
//         fontSize: 16,
//         fontWeight: FontWeight.w500,
//       ),
//     ),
//   ),
//   outlinedButtonTheme: OutlinedButtonThemeData(
//     style: OutlinedButton.styleFrom(
//       textStyle: GoogleFonts.poppins(
//         color: Colors.white,
//         fontSize: 14,
//         fontWeight: FontWeight.w500,
//       ),
//       foregroundColor: Colors.white,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10),
//       ),
//       side: const BorderSide(
//         color: Colors.white,
//         width: 1,
//       ),
//     ),
//   ),
//   floatingActionButtonTheme: const FloatingActionButtonThemeData(
//       backgroundColor: AppPalette.neutralDarkest),
//   textButtonTheme: TextButtonThemeData(
//     style: TextButton.styleFrom(
//       foregroundColor: AppPalette.primary,
//       textStyle: GoogleFonts.poppins(
//         color: AppPalette.primary,
//         fontSize: 15,
//         fontWeight: FontWeight.w500,
//       ),
//     ),
//   ),
//   appBarTheme: AppBarTheme(
//     backgroundColor: Colors.black87,
//     elevation: 0,
//     iconTheme: const IconThemeData(color: Colors.white),
//     titleTextStyle: GoogleFonts.poppins(
//       color: Colors.white,
//       fontSize: 16,
//       fontWeight: FontWeight.w500,
//     ),
//   ),
//   listTileTheme: ListTileThemeData(
//     tileColor: AppPalette.neutralDarkest,
//     style: ListTileStyle.list,
//     textColor: AppPalette.neutralLighter,
//     titleTextStyle: GoogleFonts.poppins(
//       color: Colors.white,
//       fontSize: 14,
//       fontWeight: FontWeight.w500,
//     ),
//   ),
//   tabBarTheme: TabBarTheme(
//     labelColor: AppPalette.neutralLightest,
//     unselectedLabelColor: AppPalette.neutralLighter,
//     indicatorColor: AppPalette.neutralLightest,
//     unselectedLabelStyle: GoogleFonts.poppins(
//       fontSize: 14,
//       fontWeight: FontWeight.w500,
//     ),
//     labelStyle: GoogleFonts.poppins(
//       fontSize: 14,
//       fontWeight: FontWeight.w500,
//     ),
//     labelPadding: EdgeInsets.zero,
//     indicator: const UnderlineTabIndicator(
//       borderSide: BorderSide(color: AppPalette.neutralLightest, width: 2),
//     ),
//   ),
//   sliderTheme: const SliderThemeData(
//       thumbShape: RoundSliderThumbShape(enabledThumbRadius: 0), trackHeight: 2),
//   primaryColor: const Color.fromRGBO(173, 20, 87, 1),
//   textTheme: TextTheme(
//     titleLarge: GoogleFonts.poppins(
//       color: AppPalette.primary,
//       fontSize: 24,
//       fontWeight: FontWeight.w500,
//     ),
//     titleMedium: GoogleFonts.poppins(
//       // Default text input style
//       color: Colors.white,
//       fontSize: 14,
//       fontWeight: FontWeight.w500,
//     ),
//     titleSmall: GoogleFonts.poppins(
//       color: Colors.white,
//       fontSize: 20,
//       fontWeight: FontWeight.w500,
//     ),
//     headlineLarge: GoogleFonts.poppins(
//       // 16 / Semibold
//       color: Colors.white,
//       fontSize: 16,
//       fontWeight: FontWeight.w600,
//     ),
//     headlineMedium:

//         // GoogleFonts.poppins(
//         //   // 16 / medium
//         //   color: Colors.white,
//         //   fontSize: 16,
//         //   fontWeight: FontWeight.w500,
//         // ),

//         const TextStyle(
//             fontSize: 16, fontFamily: "AirbnbCereal_W_Bd", color: Colors.white),
//     headlineSmall:

//         // GoogleFonts.poppins(
//         //   // 16 / Regular
//         //   color: Colors.white,
//         //   fontSize: 16,
//         //   fontWeight: FontWeight.w400,
//         // ),
//         const TextStyle(
//             fontFamily: "AirbnbCereal_W_Bk", fontSize: 12, color: Colors.white),
//     displayLarge: GoogleFonts.poppins(
//       // 14 / Semibold
//       color: Colors.white,
//       fontSize: 14,
//       fontWeight: FontWeight.w600,
//     ),
//     displayMedium:

//         //  GoogleFonts.poppins(
//         //   color: Colors.white,
//         //   fontSize: 14,
//         //   fontWeight: FontWeight.w500,
//         // ),

//         const TextStyle(
//             fontSize: 14, fontFamily: "AirbnbCereal_W_Md", color: Colors.white),
//     displaySmall: GoogleFonts.poppins(
//       color: AppPalette.neutralLighter,
//       fontSize: 14,
//       fontWeight: FontWeight.w400,
//     ),
//     bodyLarge: GoogleFonts.poppins(
//       // 12 / Semibold
//       color: Colors.white,
//       fontSize: 12,
//       fontWeight: FontWeight.w600,
//     ),
//     bodyMedium: GoogleFonts.poppins(
//       // 12 / medium
//       color: Colors.white,
//       fontSize: 12,
//       fontWeight: FontWeight.w500,
//     ),
//     bodySmall: GoogleFonts.poppins(
//       color: AppPalette.neutralLightest,
//       fontSize: 12,
//       fontWeight: FontWeight.w400,
//     ),
//     labelLarge: GoogleFonts.poppins(
//       // 10 / Semibold
//       color: Colors.white,
//       fontSize: 10,
//       fontWeight: FontWeight.w600,
//     ),
//     labelMedium: GoogleFonts.poppins(
//       // 10 / Medium
//       color: Colors.white,
//       fontSize: 10,
//       fontWeight: FontWeight.w500,
//     ),
//     labelSmall: GoogleFonts.poppins(
//       // 10 / Regular
//       color: Colors.white,
//       fontSize: 10,
//       fontWeight: FontWeight.w400,
//     ),
//   ),
//   cardColor: AppPalette.neutralDarkest,
// );

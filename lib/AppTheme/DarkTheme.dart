import 'package:eventlyy/AppTheme/appTheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class DarkTheme {
  static final ThemeData darkMode = ThemeData(
    focusColor: AppTheme.blueColor,
    cardColor: AppTheme.whiteColor,
    hintColor: AppTheme.whiteColor,
    canvasColor: AppTheme.darkBlueColor,
    hoverColor: AppTheme.whiteColor,
    scaffoldBackgroundColor: AppTheme.darkBlueColor,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedIconTheme: IconThemeData(color: AppTheme.whiteColor),
      unselectedIconTheme: IconThemeData(color: AppTheme.whiteColor),
      showSelectedLabels: true,
      showUnselectedLabels: true,
      backgroundColor: Colors.transparent,
      selectedLabelStyle: TextStyle(color: AppTheme.whiteColor),
      unselectedLabelStyle: TextStyle(color: AppTheme.whiteColor),
    ),
    bottomAppBarTheme: BottomAppBarTheme(
      color: AppTheme.darkBlueColor,
      elevation: 0,
      shape: CircularNotchedRectangle(),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: AppTheme.darkBlueColor,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppTheme.darkBlueColor,
      foregroundColor: Colors.white,
      shape: StadiumBorder(
        side: BorderSide(width: 4, color: AppTheme.whiteColor),
      ),
    ),
    textTheme: TextTheme(
      titleSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppTheme.whiteColor,
      ),
      displaySmall: GoogleFonts.inter(
        color: AppTheme.whiteColor,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      headlineSmall: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 14,
        color: AppTheme.darkBlueColor,
      ),
      titleLarge: GoogleFonts.inter(
        fontWeight: FontWeight.bold,
        fontSize: 24,
        color: AppTheme.whiteColor,
      ),
      labelSmall: TextStyle(
        color: AppTheme.whiteColor,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      titleMedium: GoogleFonts.inter(
        fontWeight: FontWeight.w500,
        fontSize: 24,
        color: AppTheme.whiteColor,
      ),
      bodySmall: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w400,
        color: AppTheme.whiteColor,
      ),
      bodyLarge: GoogleFonts.inter(
        textStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: AppTheme.whiteColor,
        ),
      ),
      labelMedium: TextStyle(
        color: AppTheme.whiteColor,
        fontWeight: FontWeight.w500,
        fontSize: 16,
      ),
      headlineMedium: GoogleFonts.inter(
        textStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: AppTheme.whiteColor,
          fontSize: 20,
        ),
      ),
      labelLarge: TextStyle(
        fontWeight: FontWeight.w500,
        color: AppTheme.whiteColor,
        fontSize: 16,
      ),
      headlineLarge: GoogleFonts.inter(
        textStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: AppTheme.blueColor,
          fontSize: 20,
        ),
      ),
      bodyMedium: GoogleFonts.inter(
        textStyle: TextStyle(
          fontWeight: FontWeight.w500,
          color: AppTheme.whiteColor,
          fontSize: 16,
        ),
      ),
    ),
    appBarTheme: AppBarTheme(color: AppTheme.darkBlueColor),
  );
}

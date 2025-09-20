import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'appTheme.dart';

abstract class LightTheme {
  static final ThemeData lightMode = ThemeData(

    cardColor: AppTheme.grayColor,
    focusColor: AppTheme.whiteColor,
    hintColor: AppTheme.grayColor,
    canvasColor: AppTheme.blueColor,
    hoverColor: AppTheme.blueColor,
    scaffoldBackgroundColor: AppTheme.whiteColor,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedIconTheme: IconThemeData(color: AppTheme.whiteColor),
      unselectedIconTheme: IconThemeData(),
      showSelectedLabels: true,
      showUnselectedLabels: true,
      elevation: 0,
      selectedItemColor: AppTheme.whiteColor,
      backgroundColor: Colors.transparent,
      selectedLabelStyle: TextStyle(color: Colors.white),
      unselectedLabelStyle: TextStyle(color: Colors.white),
    ),
    bottomAppBarTheme: BottomAppBarTheme(
      shape: CircularNotchedRectangle(),
      color: AppTheme.blueColor,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Color(0xFF5669FF),
      foregroundColor: Colors.white,
      shape: StadiumBorder(
        side: BorderSide(width: 4, color: AppTheme.whiteColor),
      ),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: AppTheme.whiteColor,
    ),
    textTheme: TextTheme(
      bodyLarge: GoogleFonts.inter(
        textStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: AppTheme.blackColor,
        ),
      ),

      headlineMedium: GoogleFonts.inter(
        textStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: AppTheme.blackColor,
          fontSize: 20,
        ),
      ),
      labelSmall: TextStyle(
        color: AppTheme.whiteColor,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      headlineLarge: GoogleFonts.inter(
        textStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: AppTheme.blueColor,
          fontSize: 20,
        ),
      ),
      displaySmall: GoogleFonts.inter(
        color: AppTheme.grayColor,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      titleMedium: GoogleFonts.inter(
        fontWeight: FontWeight.w500,
        fontSize: 24,
        color: AppTheme.whiteColor,
      ),
      titleLarge: GoogleFonts.inter(
        fontWeight: FontWeight.bold,
        fontSize: 24,
        color: AppTheme.whiteColor,
      ),
      bodySmall: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w400,
        color: AppTheme.whiteColor,
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppTheme.whiteColor,
      ),
      headlineSmall: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 14,
        color: AppTheme.blueColor,
      ),
      bodyMedium: GoogleFonts.inter(
        textStyle: TextStyle(
          fontWeight: FontWeight.w500,
          color: AppTheme.blackColor,
          fontSize: 16,
        ),
      ),
      labelMedium: TextStyle(
        color: AppTheme.blueColor,
        fontWeight: FontWeight.w500,
        fontSize: 16,
      ),
      labelLarge: TextStyle(
        fontWeight: FontWeight.w500,
        color: AppTheme.whiteColor,
        fontSize: 16,
      ),
    ),
    appBarTheme: AppBarTheme(color: AppTheme.blueColor),
  );
}

import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:stuartappclone/screens/constants/constants.dart';

class StuartTextStyles{

  static TextStyle get normal16 => GoogleFonts.workSans(
    textStyle: const TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 15.0
    )
  );

  static TextStyle get bold16 => GoogleFonts.workSans(
    textStyle: const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 15.0
    )
  );

  static TextStyle get w60016 => GoogleFonts.workSans(
    textStyle: const TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 16.0
    )
  );

  static TextStyle get w50014 => GoogleFonts.workSans(
    textStyle: const TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 14.0
    )
  );

  static TextStyle get w40014 => GoogleFonts.workSans(
    textStyle: const TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 14.0
    )
  );

  static TextStyle get w40016 => GoogleFonts.workSans(
    textStyle: const TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 16.0
    )
  );

  static TextStyle get w50022 => GoogleFonts.workSans(
    textStyle: const TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 22.0
    )
  );

  static TextStyle get w60030 => GoogleFonts.workSans(
    textStyle: const TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 30.0
    )
  );

  static TextStyle get w60012 => GoogleFonts.workSans(
    textStyle: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 12.0,
      color: Colors.grey.shade500
    )
  );

  static TextStyle get w50013 => GoogleFonts.workSans(
    textStyle: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 13.0,
      color: getRedColor
    )
  );

  static TextStyle get w50016 => GoogleFonts.workSans(
    textStyle: const TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 16.0,
      color: Colors.black87
    )
  );

  static TextStyle get w50018 => GoogleFonts.workSans(
    textStyle: const TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 18.0,
      color: Colors.black87
    )
  );

  static TextStyle get w60018 => GoogleFonts.workSans(
    textStyle: const TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 18.0,
      color: Colors.black87
    )
  );

  static TextStyle get w50015 => GoogleFonts.workSans(
    textStyle: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 15.0,
      color: Colors.grey.shade600
    )
  );

}
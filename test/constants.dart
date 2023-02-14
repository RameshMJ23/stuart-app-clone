import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


Widget mockMaterialWrap(Widget child) => MaterialApp(
  debugShowCheckedModeBanner: false,
  title: 'Stuart clone',
  theme: ThemeData(
      primarySwatch: Colors.blue,
      textTheme: TextTheme(
        // For auth title
        titleLarge: GoogleFonts.workSans(
          textStyle: const TextStyle(
            fontSize: 40.0,
            fontWeight: FontWeight.bold
          )
        ),
        // For auth sub-title
        titleMedium: GoogleFonts.workSans(
          textStyle: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w500
          )
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          textStyle: MaterialStateProperty.all(GoogleFonts.workSans(
            textStyle: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.normal
            )
          ))
        )
      )
  ),
  home: child,
);



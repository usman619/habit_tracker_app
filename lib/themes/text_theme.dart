import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle titleTextTheme = TextStyle(
  fontFamily: GoogleFonts.firaCode().fontFamily,
  fontWeight: FontWeight.bold,
  letterSpacing: 3,
  fontSize: 18,
);

TextStyle drawerTextTheme(BuildContext context) => TextStyle(
      fontFamily: GoogleFonts.firaCode().fontFamily,
      fontWeight: FontWeight.bold,
      letterSpacing: 2,
      fontSize: 16,
      color: Theme.of(context).colorScheme.primary,
    );

TextStyle bodyTextTheme = TextStyle(
  fontFamily: GoogleFonts.firaCode().fontFamily,
  fontWeight: FontWeight.normal,
  letterSpacing: 2,
  fontSize: 16,
);

TextStyle heatMapTextTheme = TextStyle(
  fontFamily: GoogleFonts.firaCode().fontFamily,
  fontWeight: FontWeight.normal,
  letterSpacing: 2,
  fontSize: 12,
);

TextStyle loginTextTheme(BuildContext context) => TextStyle(
      fontFamily: GoogleFonts.firaCode().fontFamily,
      fontWeight: FontWeight.bold,
      letterSpacing: 1,
      fontSize: 24,
      color: Theme.of(context).colorScheme.primary,
    );

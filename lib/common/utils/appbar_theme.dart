import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rss/common/constants/strings.dart';

AppBarTheme appBarTheme() {
  return  AppBarTheme(
    backgroundColor: primaryColor,
    elevation: 0,
    titleTextStyle: GoogleFonts.poppins(fontSize: 16),
    iconTheme: IconThemeData(color: Colors.white),
  );
}

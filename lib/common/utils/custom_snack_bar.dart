import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

customSnackBar(
  BuildContext context,
  String message,
 {bool isError=true} 
) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor:isError? Colors.red:Colors.green,
    behavior: SnackBarBehavior.floating,
    margin: const EdgeInsets.all(10),
    content: Text(
      message,
      style: GoogleFonts.poppins(fontSize: 13),
    ),
    duration: Duration(milliseconds: 1200),
  ));
}

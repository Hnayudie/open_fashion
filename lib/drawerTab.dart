import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget drawerTab(String title) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    height: 50,
    child: Align(
      alignment: Alignment.center,
      child: Text(
        title,
        style: GoogleFonts.tenorSans(
          fontSize: 18
        ),
        overflow: TextOverflow.visible,
      ),
    ),
  );
}
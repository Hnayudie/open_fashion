import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buildCustomTab(String title) {
  return Tab(
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      height: 50,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(30),
      ),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          title,
          style: GoogleFonts.tenorSans(
            fontWeight: FontWeight.bold
          ),
          overflow: TextOverflow.visible,
        ),
      ),
    ),
  );
}
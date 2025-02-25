import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryChip extends StatelessWidget {
  final String label;
  final bool isSelected;

  const CategoryChip({super.key, required this.label, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? Colors.transparent : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
          label,
          style: GoogleFonts.tenorSans(
            textStyle: TextStyle(
              color: isSelected ? Colors.black : Colors.grey[400],
              fontWeight: FontWeight.bold,
            ),
          )
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductCard extends StatelessWidget {
  final String image;
  final String name;
  final String price;

  const ProductCard({
    required this.image,
    required this.name,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AspectRatio(
          aspectRatio: 3 / 4,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        SizedBox(height: 4),
        Text(
            name,
            textAlign: TextAlign.center,
            style: GoogleFonts.tenorSans(
              textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),

            )
        ),
        SizedBox(height: 4),
        Center(
          child: Text(
              textAlign: TextAlign.center,
              price,
              style: GoogleFonts.tenorSans(
                textStyle: TextStyle(color: Color(0xffDD8560), fontSize: 14),
              )
          ),
        )
      ],
    );
  }
}
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:open_fashion/Screen/CollectionDetail.dart';

class CollectionCard extends StatelessWidget {
  final String image;
  final String name;

  CollectionCard({
    super.key,
    required this.image,
    required this.name,
  });

  int index = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => CollectionDetail(imagePath: image)));
      },
      child: Column(
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
            style: GoogleFonts.tenorSans( fontSize: 16, color: Colors.white, letterSpacing: 2),
          ),
        ],
      ),
    );
  }
}
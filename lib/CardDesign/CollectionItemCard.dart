import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Screen/DetailedItem.dart';

class CollectionItemCard extends StatefulWidget {
  final int id;
  final String brand;
  final String name;
  final String price;
  final String image;
  final List sizes;

  const CollectionItemCard({super.key,
    required this.id,
    required this.brand,
    required this.name,
    required this.price,
    required this.image,
    required this.sizes
  });

  @override
  _CollectionItemCardState createState() => _CollectionItemCardState();
}

class _CollectionItemCardState extends State<CollectionItemCard> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ItemDetail(
              brand: widget.brand,
              name: widget.name,
              price: widget.price,
              image: widget.image,
              sizes: widget.sizes,
              id: widget.id,
            ),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Stack to overlay the image and the favorite icon
          Stack(
            children: [
              AspectRatio(
                aspectRatio: 3 / 4,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(widget.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              // Positioned Heart Icon (favorite)
              Positioned(
                bottom: 0,
                right: 0,
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      isFavorite = !isFavorite; // Toggle favorite status
                    });
                  },
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          // Brand Name
          Text(
            widget.brand,
            style: GoogleFonts.tenorSans(
              fontSize: 14,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 4),
          // Item Name
          Text(
            widget.name,
            style: GoogleFonts.tenorSans(
              fontSize: 12,
              color: Colors.grey[700],
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 4),
          // Price
          Text(
            widget.price,
            style: GoogleFonts.tenorSans(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color(0xffDD8560),
            ),
          ),
        ],
      ),
    );
  }
}
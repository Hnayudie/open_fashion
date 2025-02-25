import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Screen/DetailedItem.dart';

class ItemListView extends StatefulWidget {
  final int id;
  final String brand;
  final String name;
  final String price;
  final String image;
  final String rating;
  final List sizes;

  const ItemListView({super.key,
    required this.id,
    required this.brand,
    required this.name,
    required this.price,
    required this.image,
    required this.rating,
    required this.sizes,
  });

  @override
  _ItemListViewState createState() => _ItemListViewState();
}

class _ItemListViewState extends State<ItemListView> {
  String? selectedSize;
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
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          children: [
            Image.asset(
              widget.image,
              width: 100,
              height: 130,
              fit: BoxFit.cover,
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.brand,
                    style: GoogleFonts.tenorSans(
                        fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 2),
                  ),
                  Text(
                    widget.name,
                    style: GoogleFonts.tenorSans(fontSize: 14, color: Colors.grey[700]),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    widget.price,
                    style: GoogleFonts.tenorSans(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xffDD8560),
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.star, size: 16, color: Colors.orange),
                      SizedBox(width: 4),
                      Text(
                        widget.rating,
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        'Size ',
                        style: GoogleFonts.tenorSans(color: Colors.grey[600]),
                      ),
                      Row(
                        children: widget.sizes.map((size) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedSize = selectedSize == size ? null : size;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4.0),
                              child: Container(
                                width: 28,
                                height: 28,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: selectedSize == size
                                      ? Colors.black
                                      : Colors.white,
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 1,
                                  ),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  size,
                                  style: TextStyle(
                                    color: selectedSize == size
                                        ? Colors.white
                                        : Colors.grey[600],
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 70),
              child: IconButton(
                onPressed: () {
                  setState(() {
                    isFavorite = !isFavorite;
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
      ),
    );
  }
}
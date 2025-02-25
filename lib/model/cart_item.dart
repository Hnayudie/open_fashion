import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../bloc/cart_bloc.dart';
import '../bloc/cart_event.dart';

class CartItemModel extends StatelessWidget {
  final Map<String, dynamic> item;

  const CartItemModel({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: EdgeInsets.only(left: 16, bottom: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              child: Image.asset(
                item['image'],
                width: 100,
                height: 130,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['brand'].toUpperCase(),
                    style: GoogleFonts.tenorSans(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item['name'],
                    style: GoogleFonts.tenorSans(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          BlocProvider.of<CartBloc>(context).add(RemoveFromCart(item));
                        },
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.remove, size: 16),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          "${item['quantity']}",
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          BlocProvider.of<CartBloc>(context).add(AddToCart(item));
                        },
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.add, size: 16),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "${item['price']}",
                    style: const TextStyle(fontSize: 18, color: Color(0xffDD8560)),
                  ),
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}

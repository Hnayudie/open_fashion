import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../bloc/cart_bloc.dart';
import '../bloc/cart_state.dart';
import '../model/cart_item.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.close)
        ),
      ),


      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state.cartItems.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 25),
                    child: Text(
                      'CART',
                      style: GoogleFonts.tenorSans(fontSize: 18),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      'You have no items in your Shopping Bag.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.tenorSans(color: Colors.grey[600], fontSize: 17),
                    ),
                  ),
                ),
                OutlinedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black),
                    minimumSize: MaterialStateProperty.all(const Size(double.infinity, 60)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)))
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset('images/shopping bag.svg'),
                      SizedBox(width: 24,),
                      Text(
                        'CONTINUE SHOPPING',
                        style: GoogleFonts.tenorSans(color: Colors.white),
                      ),
                    ],
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            );
          }
          return Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 25),
                  child: Text(
                    'CART',
                    style: GoogleFonts.tenorSans(fontSize: 18),
                  ),
                ),
              ),
              
              Expanded(
                child: ListView.builder(
                  itemCount: state.cartItems.length,
                  itemBuilder: (context, index) {
                    final item = state.cartItems[index];
                    return CartItemModel(item: item);
                  },
                ),
              ),
              const Divider(height: 24, thickness: 1),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('SUB TOTAL', style: GoogleFonts.tenorSans(fontSize: 16)),
                        Text("\$${state.cartTotal}",
                            style: const TextStyle(fontSize: 18, color: Color(0xffDD8560))),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "*Shipping charges, taxes, and discount codes are calculated at checkout.",
                      style: GoogleFonts.tenorSans(fontSize: 16, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 36),
              OutlinedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.black),
                  minimumSize: MaterialStateProperty.all(const Size(double.infinity, 60)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)))
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset('images/shopping bag.svg'),
                    SizedBox(width: 24,),
                    Text(
                      'BUY NOW',
                      style: GoogleFonts.tenorSans(color: Colors.white),
                    ),
                  ],
                ),
                onPressed: () {},
              ),
            ],
          );
        },
      ),
    );
  }
}
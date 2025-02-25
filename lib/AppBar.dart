import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'Screen/Cart.dart';

AppBar myAppBar(BuildContext context, Function toggleSearchView) {
  return AppBar(
    iconTheme: const IconThemeData(color: Colors.black),
    title: SvgPicture.asset('images/OpenFashion.svg'),
    centerTitle: true,
    backgroundColor: Colors.transparent,
    systemOverlayStyle: SystemUiOverlayStyle.dark,
    actions: [
      IconButton(
        icon: SvgPicture.asset('images/Search.svg'),
        onPressed: () {
          toggleSearchView(); // Toggle the search view visibility
        },
      ),
      SizedBox(width: 16),
      IconButton(
        icon: SvgPicture.asset('images/Shopping.svg'),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => Cart()));
        },
      ),
      SizedBox(width: 16),
    ],
  );
}


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import 'Screen/Cart.dart';

AppBar darkAppBar(context, toggleSearchView) {
  return AppBar(
    iconTheme: const IconThemeData(color: Colors.white),
    title: SvgPicture.asset('images/OpenFashion.svg', color: Colors.white,),
    centerTitle: true,
    backgroundColor: Colors.black,
    systemOverlayStyle: SystemUiOverlayStyle.dark,
    actions: [
      IconButton(
        icon: SvgPicture.asset('images/Search.svg', color: Colors.white,),
        onPressed: () {
          toggleSearchView();
        }
      ),

      SizedBox(width: 16),
      IconButton(
          icon: SvgPicture.asset('images/Shopping.svg',color: Colors.white,),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Cart(),
              ),
            );
          }
      ),
      SizedBox(width: 16),
    ],
  );
}

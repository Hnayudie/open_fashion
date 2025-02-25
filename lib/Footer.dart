import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:open_fashion/Screen/contactView.dart';

import 'Screen/Blog.dart';
import 'Screen/aboutView.dart';

class MyFooter extends StatelessWidget {
  const MyFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 18),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 95),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SvgPicture.asset('images/Twitter.svg'),
                SvgPicture.asset('images/Instagram (1).svg'),
                SvgPicture.asset('images/YouTube.svg'),
              ],
            ),
          ),
          SizedBox(height: 20),
          SvgPicture.asset('images/Divider.svg'),
          SizedBox(height: 20),
          Text(
            'support@openui.design \n+60 825 876 \n08:00 - 22:00 - Everyday',
            textAlign: TextAlign.center,
            style: GoogleFonts.tenorSans(),
          ),
          SizedBox(height: 20),
          SvgPicture.asset('images/Divider.svg'),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                child: Text(
                  'About',
                  style: GoogleFonts.tenorSans(
                    textStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => About()));
                },
              ),
              TextButton(
                child: Text(
                  'Contact',
                  style: GoogleFonts.tenorSans(
                    textStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Contact()));
                },
              ),
              TextButton(
                child: Text(
                  'Blog',
                  style: GoogleFonts.tenorSans(
                    textStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Blog())
                  );
                },
              ),
            ],
          ),
          Container(
            width: double.infinity,
            height: 45,
            decoration: BoxDecoration(
              color: Colors.grey[50],
            ),
            child: Center(
              child: Text(
                'Copyright© OpenUI All Rights Reserved.',
                textAlign: TextAlign.center,
                style: GoogleFonts.tenorSans(
                  textStyle: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
import 'package:open_fashion/AppBar.dart';
import 'package:open_fashion/Drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'SearchView.dart';


class About extends StatefulWidget {
  const About({super.key});

  @override
  AboutState createState() =>AboutState();
}

class AboutState extends State<About> {

  bool _isSearching = false;
  void toggleSearchView() {
    setState(() {
      _isSearching = !_isSearching;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _isSearching
            ? null
            : myAppBar(context, toggleSearchView),
        drawer: MyDrawer(),
        body: AnimatedSwitcher(
          duration: Duration(milliseconds: 500),
          transitionBuilder: (widget, animation) {
            return FadeTransition(
              opacity: animation,
              child: widget,
            );
          },
          child: _isSearching
              ? SearchView(onClose: toggleSearchView, key: ValueKey(1))
              : SingleChildScrollView(
            key: ValueKey(2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                Text(
                  'OUR STORY',
                  style: GoogleFonts.tenorSans(
                    textStyle: TextStyle(
                      fontSize: 20,
                      letterSpacing: 3
                    ),
                  ),
                ),
                SvgPicture.asset('images/Divider.svg'),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 17),
                  child: Text('Open Fashion - Free Ecommerce UI Kit is a free download UI kit. You can open Open Fashion - Free Ecommerce UI Kit file by Figma. \n \nCreate stunning shop with bulletproof guidelines and thoughtful components. Its library contains more than 50+ components supporting Light & Dark Mode and 60+ ready to use mobile screens.', style: GoogleFonts.tenorSans(fontSize: 16),)
                ),
                SizedBox(height: 30),
                Container(
                  height: 240,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/image 3.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 50),
                Text(
                  'SIGN UP',
                  style: GoogleFonts.tenorSans(
                    textStyle: TextStyle(
                      fontSize: 20,
                      letterSpacing: 3
                    ),
                  ),
                ),
                SvgPicture.asset('images/Divider.svg'),
                SizedBox(height: 8),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 23),
                  child: Text(
                    'Receive early access to new arrivals, sales, exclusive content, events and much more!',
                    style: GoogleFonts.tenorSans(
                      textStyle: TextStyle(
                        color: Color(0xff888888),
                      ),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 16),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Email address',
                      hintStyle: TextStyle(color: Colors.grey)
                    ),
                  ),
                ),
                SizedBox(height: 28),
                OutlinedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                    ),
                    minimumSize: MaterialStateProperty.all(Size(double.infinity, 60)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('SUBMIT', style: GoogleFonts.tenorSans(color: Colors.white),),
                      SizedBox(width: 26,),
                      SvgPicture.asset('images/Forward Arrow.svg')
                    ],
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },


                ),
              ],
            ),
          ),
        )
    );
  }
}

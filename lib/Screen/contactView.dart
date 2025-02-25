import 'package:flutter/gestures.dart';
import 'package:open_fashion/AppBar.dart';
import 'package:open_fashion/CardDesign/buildCustomTab.dart';
import 'package:open_fashion/Drawer.dart';
import 'package:open_fashion/Footer.dart';
import 'package:open_fashion/Screen/BlogPost.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'SearchView.dart';


class Contact extends StatefulWidget {
  const Contact({super.key});

  @override
  ContactState createState() =>ContactState();
}

class ContactState extends State<Contact> {

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
                  'CONTACT US',
                  style: GoogleFonts.tenorSans(
                    textStyle: TextStyle(
                        fontSize: 20,
                        letterSpacing: 3
                    ),
                  ),
                ),
                SvgPicture.asset('images/Divider.svg'),
                SizedBox(height: 50),
                SvgPicture.asset('images/Chat Message.svg'),
                SizedBox(height: 16),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text('Need an ASAP answer? Contact us via chat, 24/7! For existing furniture orders, please call us.', style: GoogleFonts.tenorSans(fontSize: 17),)
                ),
                SizedBox(height: 16),
                SizedBox(
                  height: 50,
                  width: 210,
                  child: OutlinedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                    ),
                    child: Text('CHAT WITH US', style: GoogleFonts.tenorSans(color: Colors.white),),
                    onPressed: () {
                      Navigator.pop(context);
                    },


                  ),
                ),
                SizedBox(height: 50),
                SvgPicture.asset('images/Add Message.svg'),
                SizedBox(height: 16),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'You can text us at 800-309-2622 or click on the "text us" link below on your mobile device. Please allow the system to acknowledge a simple greeting (even "Hi" will do!) before providing your question/ order details. Consent is not required for any purchase. Messages and data rates may apply. Text messaging may not be available via all carriers.',
                    style: GoogleFonts.tenorSans(
                      textStyle: TextStyle(
                        fontSize: 17
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                SizedBox(
                  height: 50,
                  width: 140,
                  child: OutlinedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0)
                        ),
                      ),
                    ),
                    child: Text('TEXT US', style: GoogleFonts.tenorSans(color: Colors.white)),
                    onPressed: (){},
                  ),
                ),
                SizedBox(height: 50),
                SvgPicture.asset('images/Twitter_ora.svg'),
                SizedBox(height: 16),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: 'To send us a private or direct message, like @Open Fashion on ',
                          style: GoogleFonts.tenorSans(fontSize: 17, color: Colors.black),
                        ),
                        TextSpan(
                          text: 'Facebook ',
                          style: GoogleFonts.tenorSans(
                            fontSize: 17,
                            color: Colors.black,
                            decoration: TextDecoration.underline
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => launchUrlString('https://www.facebook.com/hnayudie'),
                        ),
                        TextSpan(
                          text: 'or follow us on ',
                          style: GoogleFonts.tenorSans(fontSize: 17, color: Colors.black),
                        ),
                        TextSpan(
                          text: 'Twitter. ',
                          style: GoogleFonts.tenorSans(
                            fontSize: 17,
                            color: Colors.black,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => launchUrlString('https://www.instagram.com/idk_hna.yudie/')
                        ),
                        TextSpan(
                          text: 'We\'ll get back to you ASAP. Please include your name, order number, and email address for a faster response!',
                          style: GoogleFonts.tenorSans(
                            fontSize: 17,
                            color: Colors.black,
                          ),
                        ),
                      ]
                    ),
                  ),
                ),
                SizedBox(height: 30),
                MyFooter(),
              ],
            ),
          ),
        )
    );
  }
}

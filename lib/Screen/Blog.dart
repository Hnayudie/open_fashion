import 'package:open_fashion/AppBar.dart';
import 'package:open_fashion/CardDesign/buildCustomTab.dart';
import 'package:open_fashion/Drawer.dart';
import 'package:open_fashion/Footer.dart';
import 'package:open_fashion/Screen/BlogPost.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'SearchView.dart';


class Blog extends StatefulWidget {
  const Blog({super.key});

  @override
  BlogState createState() =>BlogState();
}

class BlogState extends State<Blog> {
  final List<Map<String, Widget>> articles = [
    {
      "image": Image.asset('images/article1.png'),
      "title": Text("2021 STYLE GUIDE: THE BIGGEST FALL TRENDS", style: GoogleFonts.tenorSans(fontWeight: FontWeight.bold)),
      "subtitle":
          Text("The excitement of fall fashion is here and I’m already loving some of the trend forecasts", style: GoogleFonts.tenorSans(color: Colors.grey[800])),
      "timestamp": Text("4 days ago", style: GoogleFonts.tenorSans(color: Colors.grey[600]))
    },

    {
      "image": Image.asset('images/article2.png'),
      "title": Text("3 Pairs of Denim You Won’t Believe", style: GoogleFonts.tenorSans(fontWeight: FontWeight.bold)),
      "subtitle":
          Text("The excitement of fall fashion is here and I’m already loving some of the trend forecasts", style: GoogleFonts.tenorSans(color: Colors.grey[800])),
      "timestamp": Text("5 days ago", style: GoogleFonts.tenorSans(color: Colors.grey[600])),
    },

    {
      "image": Image.asset('images/article3.png'),
      "title": Text("5 Fall Looks I’m Loving", style: GoogleFonts.tenorSans(fontWeight: FontWeight.bold)),
      "subtitle":
          Text("The excitement of fall fashion is here and I’m already loving some of the trend forecasts", style: GoogleFonts.tenorSans(color: Colors.grey[800])),
      "timestamp": Text("01/11/2021", style: GoogleFonts.tenorSans(color: Colors.grey[600]))
    },

    {
      "image": Image.asset('images/article4.png'),
      "title": Text("5 Fall Boot Trends You Need to Try", style: GoogleFonts.tenorSans(fontWeight: FontWeight.bold)),
      "subtitle":
          Text("The excitement of fall fashion is here and I’m already loving some of the trend forecasts", style: GoogleFonts.tenorSans(color: Colors.grey[800])),
      "timestamp": Text("25/10/2021", style: GoogleFonts.tenorSans(color: Colors.grey[600]))
    },

    {
      "image": Image.asset('images/article5.png',),
      "title": Text("2021 STYLE GUIDE: THE BIGGEST FALL TRENDS", style: GoogleFonts.tenorSans(fontWeight: FontWeight.bold)),
      "subtitle":
          Text("The excitement of fall fashion is here and I’m already loving some of the trend forecasts", style: GoogleFonts.tenorSans(color: Colors.grey[800])),
      "timestamp": Text("16/10/2021", style: GoogleFonts.tenorSans(color: Colors.grey[600]))
    },

    {
      "image": Image.asset('images/article6.png'),
      "title": Text("3 Pairs of Denim You Won’t Believe", style: GoogleFonts.tenorSans(fontWeight: FontWeight.bold)),
      "subtitle":
          Text("The excitement of fall fashion is here and I’m already loving some of the trend forecasts", style: GoogleFonts.tenorSans(color: Colors.grey[800])),
      "timestamp": Text("10/10/2021", style: GoogleFonts.tenorSans(color: Colors.grey[600]))
    },
  ];

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
                'BLOG',
                style: GoogleFonts.tenorSans(
                  textStyle: TextStyle(
                    fontSize: 20,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
              SvgPicture.asset('images/Divider.svg'),
              SizedBox(height: 20),
              DefaultTabController(
                length: 5,
                child: Column(
                  children: [
                    TabBar(
                      isScrollable: true,
                      dividerColor: Colors.transparent,
                      automaticIndicatorColorAdjustment: false,
                      overlayColor: WidgetStateProperty.all<Color>(Colors.transparent),
                      unselectedLabelColor: Colors.black,
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      tabAlignment: TabAlignment.center,
                      tabs: [
                        buildCustomTab("Fashion"),
                        buildCustomTab("Promo"),
                        buildCustomTab("Policy"),
                        buildCustomTab("LookBook"),
                        buildCustomTab("Sale"),
                      ],
                    ),
                  ],
                ),
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: double.infinity,
                ),
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: articles.length,
                  itemBuilder: (context, index) {
                    final article = articles[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlogPost(article: article),
                          ),
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.only(left: 16, right: 16, top: 22,),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              child: article["image"]!,
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  article["title"]!,
                                  SizedBox(height: 5),
                                  article["subtitle"]!,
                                  SizedBox(height: 5),
                                  article["timestamp"]!,
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 110),
                child: OutlinedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'LOAD MORE',
                        style: GoogleFonts.tenorSans(
                            color: Colors.black
                        ),
                      ),
                      SizedBox(width: 10,),
                      Icon(Icons.add, size: 22, color: Colors.black,)
                    ],
                  ),
                  onPressed: () {},
                ),
              ),
              MyFooter(),
            ],
          ),
        ),
      )
    );
  }
}

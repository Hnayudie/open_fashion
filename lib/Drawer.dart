import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:open_fashion/Screen/ItemView.dart';
import 'package:open_fashion/drawerTab.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  void _navigateToCategory(BuildContext context, String category) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ItemView()),
    );
  }

  Widget _buildExpansionTile(String title, BuildContext context) {
    List<String> items = [
      'Outer', 'Dress', 'Blouse/Shirt', 'T-shirt', 'Knitwear', 'Skirt', 'Pants', 'Denim', 'Kids'
    ];

    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        title: GestureDetector(
          onTap: () => _navigateToCategory(context, title), // Navigate when title is tapped
          child: Text(
            title,
            style: GoogleFonts.tenorSans(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black,
            ),
          ),
        ),
        tilePadding: EdgeInsets.only(right: 41),
        children: items.map((item) => ListTile(
          title: Text(item, style: GoogleFonts.tenorSans()),
          onTap: () => _navigateToCategory(context, item), // Navigate when sub-item is tapped
        )).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Drawer(
        backgroundColor: Colors.white,
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            DefaultTabController(
              length: 3,
              child: Expanded(
                child: Column(
                  children: [
                    TabBar(
                      isScrollable: true,
                      automaticIndicatorColorAdjustment: false,
                      overlayColor: MaterialStateProperty.all(Colors.transparent),
                      unselectedLabelColor: Colors.grey[500],
                      labelColor: Colors.black,
                      dividerColor: Colors.transparent,
                      indicatorColor: Colors.orange,
                      indicatorSize: TabBarIndicatorSize.tab,
                      labelPadding: EdgeInsets.only(left: 0, right: 0),
                      tabAlignment: TabAlignment.start,
                      tabs: [
                        drawerTab("Women"),
                        drawerTab("Men"),
                        drawerTab("Kids"),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          _buildTabContent([
                            "New", "Apparel", "Bag", "Shoes", "Beauty", "Accessories"
                          ], context),
                          _buildTabContent([
                            "Trending", "Suits", "Shirts", "Casual Wear", "Sports", "Accessories"
                          ], context),
                          _buildTabContent([
                            "New Arrivals", "Tops", "Bottoms", "Footwear", "Toys", "Essentials"
                          ], context),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabContent(List<String> categories, BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(left: 17),
      children: [
        ...categories.map((category) => _buildExpansionTile(category, context)).toList(),
        SizedBox(height: 20),

        // Contact Information
        Row(
          children: [
            Icon(CupertinoIcons.phone, size: 26, color: Colors.grey[700]),
            SizedBox(width: 10),
            Text("(786) 713-8616",
                style: GoogleFonts.tenorSans(fontSize: 16, color: Colors.grey[800], letterSpacing: 1.08))
          ],
        ),
        SizedBox(height: 20),
        Row(
          children: [
            Icon(IconlyLight.location, size: 26, color: Colors.grey[700]),
            SizedBox(width: 10),
            Text("Store locator",
                style: GoogleFonts.tenorSans(fontSize: 16, color: Colors.grey[800]))
          ],
        ),

        // Divider
        SizedBox(height: 20),
        SvgPicture.asset("images/Divider.svg"),
        SizedBox(height: 25),

        // Social Media Icons
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 95),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SvgPicture.asset("images/Twitter.svg"),
              SvgPicture.asset("images/Instagram (1).svg"),
              SvgPicture.asset("images/YouTube.svg"),
            ],
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}

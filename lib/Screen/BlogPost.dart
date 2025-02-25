import 'package:open_fashion/AppBar.dart';
import 'package:open_fashion/Drawer.dart';
import 'package:open_fashion/Footer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'SearchView.dart';

class BlogPost extends StatefulWidget {
  final Map<String, Widget> article;

  const BlogPost({super.key, required this.article});

  @override
  State<BlogPost> createState() => BlogPostState();
}

class BlogPostState extends State<BlogPost> {
  bool _isSearching = false;

  // Toggle search view
  void toggleSearchView() {
    setState(() {
      _isSearching = !_isSearching;
    });
  }

  final List<String> imagePath = [
    'images/product4.png',
    'images/product2.png',
    'images/product3.png',
  ];

  late List<Widget> _pages;
  late PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pages = List.generate(
      imagePath.length,
          (index) => ImagePlaceHolder(imagePath: imagePath[index]),
    );
    _pageController = PageController();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final article = widget.article;

    return Scaffold(
      appBar: _isSearching
          ? null // When searching, hide the AppBar
          : myAppBar(context, toggleSearchView), // Use your existing AppBar
      drawer: MyDrawer(),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                child: SizedBox(
                  width: double.infinity,
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: article["image"] ?? Container(),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      (article["title"] as Text).data ?? 'No Title',
                      style: GoogleFonts.tenorSans(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      (article["subtitle"] as Text).data ?? 'No Subtitle',
                      style: GoogleFonts.tenorSans(
                        color: Colors.grey[800],
                        fontSize: 16,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              // PageView to display images
              SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 2,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: imagePath.length,
                  itemBuilder: (context, index) {
                    return _pages[index];
                  },
                  onPageChanged: _onPageChanged,
                ),
              ),
              // Page indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  imagePath.length,
                      (index) => Container(
                    width: 8.0,
                    height: 8.0,
                    margin: EdgeInsets.symmetric(horizontal: 4.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      shape: BoxShape.circle,
                      color: _currentIndex == index
                          ? Colors.grey
                          : Colors.transparent,
                    ),
                  ),
                ),
              ),
              MyFooter(),
            ],
          ),
        ),
      ),
    );
  }
}

class ImagePlaceHolder extends StatelessWidget {
  final String? imagePath;
  const ImagePlaceHolder({super.key, this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Image.asset(imagePath!, width: double.infinity);
  }
}

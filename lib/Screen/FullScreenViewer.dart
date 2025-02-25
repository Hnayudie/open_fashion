import 'package:flutter/material.dart';

class FullScreenViewer extends StatefulWidget {
  final List<String> images;
  final int initialIndex;

  FullScreenViewer({required this.images, required this.initialIndex});

  @override
  _FullScreenViewerState createState() => _FullScreenViewerState();
}

class _FullScreenViewerState extends State<FullScreenViewer> {
  late PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.initialIndex);

    // Listen for page changes to update the indicator
    _pageController.addListener(() {
      if (_pageController.page?.toInt() != _currentIndex) {
        setState(() {
          _currentIndex = _pageController.page?.toInt() ?? 0;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: widget.images.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return Center(
                child: Image.asset(
                  widget.images[index],
                  fit: BoxFit.contain,
                  scale: 0.3,
                ),
              );
            },
          ),

          // Position the indicator on the right side of the screen
          Positioned(
            bottom: 400,
            right: 16.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                widget.images.length,
                    (index) => Container(
                  width: 8.0,
                  height: 8.0,
                  margin: const EdgeInsets.symmetric(vertical: 4.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    shape: BoxShape.circle,
                    color: _currentIndex == index
                        ? Color(0xffA8715A)
                        : Colors.white,
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            top: 30.0,
            right: 16.0,
            child: IconButton(
              icon: Icon(Icons.close, color: Colors.white, size: 32),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }
}

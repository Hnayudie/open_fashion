import 'package:carousel_slider/carousel_slider.dart';
import 'package:open_fashion/AppBar.dart';
import 'package:open_fashion/CardDesign/product_card.dart';
import 'package:open_fashion/Drawer.dart';
import 'package:open_fashion/Footer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../CardDesign/category_chip.dart';
import '../CardDesign/feature_card.dart';
import '../CardDesign/ig_card.dart';
import 'package:open_fashion/Screen/Collection.dart';

import 'SearchView.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentBannerIndex = 0;
  int _currentJustForYouIndex = 0;

  bool _isSearching = false;
  void toggleSearchView() {
    setState(() {
      _isSearching = !_isSearching;
    });
  }

  final List<String> _brandLogos = [
    'images/Prada.svg',
    'images/Burberry.svg',
    'images/Boss.svg',
    'images/Catier.svg',
    'images/Gucci.svg',
    'images/Tiffany & Co.svg',
  ];

  final List<String> _hastagTrend = [
    '#2021',
    '#spring',
    '#collection',
    '#fall',
    '#dress',
    '#autumncollection',
    '#openfashion'
  ];

  final List<String> _bannerImages = [
    'images/banner_image1.png',
    'images/product2.png',
    'images/product3.png',
  ];


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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Banner Section with Image Slider
              SizedBox(
                height: 700,
                width: double.infinity,
                child: Stack(
                  children: [
                    // Background Image Carousel
                    CarouselSlider(
                      items: _bannerImages.map((image) {
                        return Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(image),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      }).toList(),
                      options: CarouselOptions(
                        height: 700,
                        viewportFraction: 1.0,
                        enableInfiniteScroll: true,
                        autoPlay: false,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _currentBannerIndex = index;
                          });
                        },
                      ),
                    ),
                    // Text Overlay
                    Positioned(
                      bottom: 285,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                                      child: Text(
                                        'LUXURY',
                                        style: GoogleFonts.bodoniModa(
                                          textStyle: TextStyle(
                                              color: Colors.grey[700],
                                              fontSize: 40,
                                              letterSpacing: 1.2,
                                              fontStyle: FontStyle.italic
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'FASHION',
                                      style: GoogleFonts.bodoniModa(
                                        textStyle: TextStyle(
                                          color: Colors.grey[700],
                                          fontSize: 40,
                                          letterSpacing: 1.2,
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                      child: Text(
                                        '&ACCESSORIES',
                                        style: GoogleFonts.bodoniModa(
                                          textStyle: TextStyle(
                                              color: Colors.grey[700],
                                              fontSize: 40,
                                              letterSpacing: 1.2,
                                              fontStyle: FontStyle.italic
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Explore Button
                    Positioned(
                      bottom: 50,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Collection()));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black.withOpacity(0.3),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Text(
                              'EXPLORE COLLECTION',
                              style: GoogleFonts.tenorSans(
                                textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              )
                          ),
                        ),
                      ),
                    ),
                    // Dot Indicators
                    Positioned(
                      bottom: 16,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: _bannerImages.asMap().entries.map((entry) {
                          return Container(
                            width: 8.0,
                            height: 8.0,
                            margin: EdgeInsets.symmetric(horizontal: 4.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              shape: BoxShape.circle,
                              color: _currentBannerIndex == entry.key
                                  ? Colors.white
                                  : Colors.transparent,
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 35),
              // Categories Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    Text(
                      'NEW ARRIVAL',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        letterSpacing: 3.5,
                      ),
                    ),
                    SvgPicture.asset('images/Divider.svg',),

                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CategoryChip(label: 'All', isSelected: true,),
                        CategoryChip(label: 'Apparel'),
                        CategoryChip(label: 'Dress'),
                        CategoryChip(label: 'Tshirt'),
                        CategoryChip(label: 'Bag'),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              // Product Grid
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    childAspectRatio: 0.55,
                  ),
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return ProductCard(
                      image: 'images/product${index + 1}.png',
                      name: '21WN reversible angora cardigan',
                      price: '\$120',
                    );
                  },
                ),
              ),
              // Explore More Button
              Center(
                child: TextButton(
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Explore More',
                        style: GoogleFonts.tenorSans(
                          textStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward, color: Colors.black),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 35),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 16),
                    SvgPicture.asset('images/Divider.svg', alignment: Alignment.center,),
                    // Logos Grid
                    GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 18,
                      ),
                      itemCount: _brandLogos.length,
                      itemBuilder: (context, index) {
                        return Center(
                          child: SvgPicture.asset(
                            _brandLogos[index],
                            fit: BoxFit.contain,
                            height: 26, // Adjust logo size
                          ),
                        );
                      },
                    ),
                    SvgPicture.asset('images/Divider.svg', alignment: Alignment.center,),
                  ],
                ),
              ),
              SizedBox(height: 47,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'COLLECTIONS',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      letterSpacing: 3.5,
                    ),
                  ),
                  SizedBox(height: 18,),
                  Container(
                    height: 240,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('images/image 12.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(45),
                    child: Image.asset('images/image 9.png',),
                  ),
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('images/image 13.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        'images/PlayButton.svg',
                        height: 50,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 49),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'JUST FOR YOU',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      letterSpacing: 3.5,
                    ),
                  ),
                  SizedBox(height: 10,),
                  SvgPicture.asset('images/Divider.svg'),
                  SizedBox(height: 22),
                  CarouselSlider.builder(
                    itemCount: 3, // Set to the total number of items in the carousel
                    itemBuilder: (context, index, realIndex) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: ProductCard(
                          image: 'images/product${index + 1}.png',
                          name: [
                            '21WN reversible angora cardigan',
                            'Cashmere Blend Cropped Jacket SW1WJ285-AM',
                            'Harris Tweed Three-button Jacket'
                          ][index],
                          price: '\$120',
                        ),
                      );
                    },
                    options: CarouselOptions(
                      height: 490,
                      viewportFraction: 0.8,
                      enableInfiniteScroll: false,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentJustForYouIndex = index;
                        });
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      3,
                          (index) => Container(
                        width: 8.0,
                        height: 8.0,
                        margin: EdgeInsets.symmetric(horizontal: 4.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          shape: BoxShape.circle,
                          color: _currentJustForYouIndex == index
                              ? Colors.grey
                              : Colors.transparent,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 38,),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '@TRENDING',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      letterSpacing: 3.5,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Hashtags
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: _hastagTrend.map((hashtag) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          hashtag,
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
              SizedBox(height: 22,),
              Container(
                decoration: BoxDecoration(color: Colors.grey[100]),
                child: Column(
                  children: [
                    SizedBox(height: 28,),
                    SvgPicture.asset('images/OpenFashion.svg',),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                          'Making a luxurious lifestyle accessible \nfor a generous group of women is our \ndaily drive.',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.tenorSans(
                            textStyle: TextStyle(fontSize: 16, color: Colors.black54),
                          )
                      ),
                    ),
                    SizedBox(height: 5,),
                    SvgPicture.asset('images/Divider.svg',),
                    const SizedBox(height: 20),
                    GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        childAspectRatio: 1.7,
                      ),
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        final subtitles = [
                          'Fast Shipping. Free on \norders over \$25.',
                          'Sustainable process \nfrom start to finish.',
                          'Unique designs \nand high-quality materials.',
                          'Fast shipping. \nFree on orders over \$25.',
                        ];
                        final icons = [
                          'images/Miroodles - Sticker1.png',
                          'images/Miroodles - Sticker2.png',
                          'images/Miroodles - Sticker3.png',
                          'images/Miroodles - Sticker4.png',
                        ];
                        return FeatureCard(
                            icon: Image.asset(icons[index]),
                            subtitle: subtitles[index]
                        );
                      },
                    ),
                    SvgPicture.asset('images/footer.svg')
                  ],
                ),
              ),
              SizedBox(height: 16,),
              Column(
                children: [
                  Text(
                    'FOLLOW US',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      letterSpacing: 1.5,
                    ),
                  ),
                  SizedBox(height: 5,),
                  SvgPicture.asset('images/Instagram.svg'),
                  SizedBox(height: 16,),
                  GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Two columns,
                      mainAxisSpacing: 16, // Vertical spacing
                      childAspectRatio: 1.1, // Make items square
                    ),
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      final tags = [
                        '@mia',
                        '@_jihyn',
                        '@mia',
                        '@_jihyn',
                      ];
                      final images = [
                        'images/followus1.png',
                        'images/followus2.png',
                        'images/followus3.png',
                        'images/followus4.png',
                      ];
                      return IgCard(
                        ig: Image.asset(
                          images[index],
                          fit: BoxFit.cover,
                        ),
                        tag: tags[index],
                      );
                    },
                  ),
                ],
              ),
              MyFooter(),
              // SizedBox(height: 18,),
              // Column(
              //   children: [
              //     Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //       children: [
              //         SvgPicture.asset('images/Twitter.svg'),
              //         SvgPicture.asset('images/Instagram (1).svg'),
              //         SvgPicture.asset('images/YouTube.svg')
              //       ],
              //     ),
              //     SizedBox(height: 20,),
              //     SvgPicture.asset('images/Divider.svg'),
              //     SizedBox(height: 25,),
              //     Text(
              //       'support@openui.design \n+60 825 876 \n08:00 - 22:00 - Everyday',
              //       textAlign: TextAlign.center,
              //       style: GoogleFonts.tenorSans(),
              //     ),
              //     SizedBox(height: 25,),
              //     SvgPicture.asset('images/Divider.svg'),
              //     SizedBox(height: 20,),
              //     Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //       children: [
              //         TextButton(
              //           child: Text(
              //             'About',
              //             style: GoogleFonts.tenorSans(
              //                 textStyle: TextStyle(
              //                     fontWeight: FontWeight.bold,
              //                     color: Colors.black
              //                 )
              //             ),
              //           ),
              //           onPressed: () {},
              //         ),
              //         TextButton(
              //           child: Text(
              //             'Contact',
              //             style: GoogleFonts.tenorSans(
              //                 textStyle: TextStyle(
              //                     fontWeight: FontWeight.bold,
              //                     color: Colors.black
              //                 )
              //             ),
              //           ),
              //           onPressed: () {},
              //         ),
              //         TextButton(
              //           child: Text(
              //             'Blog',
              //             style: GoogleFonts.tenorSans(
              //                 textStyle: TextStyle(
              //                   fontWeight: FontWeight.bold,
              //                   color: Colors.black
              //                 )
              //             ),
              //           ),
              //           onPressed: () {
              //             Navigator.push(
              //               context,
              //               MaterialPageRoute(builder: (context) => Blog())
              //             );
              //           },
              //         ),
              //       ],
              //     )
              //   ],
              // ),
              // SizedBox(height: 12,),
              // Container(
              //     width: double.infinity,
              //     height: 45,
              //     decoration: BoxDecoration(
              //       color: Colors.grey[50],
              //     ),
              //     child: Center(
              //       child: Text(
              //           'Copyright© OpenUI All Rights Reserved.',
              //           textAlign: TextAlign.center,
              //           style: GoogleFonts.tenorSans(
              //             textStyle: TextStyle(
              //                 color: Colors.grey[600],
              //                 fontSize: 12
              //             ),
              //           )
              //       ),
              //     )
              // )
            ],
          ),
        ),
      ),
    );
  }
}
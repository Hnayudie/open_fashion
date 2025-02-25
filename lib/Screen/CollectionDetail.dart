import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:open_fashion/AppBar.dart';
import 'package:open_fashion/Drawer.dart';
import 'package:open_fashion/Footer.dart';
import 'package:open_fashion/Screen/SearchView.dart';
import 'package:open_fashion/model/collection_model.dart';

import '../CardDesign/CollectionCard.dart';
import '../CardDesign/CollectionItemCard.dart';
import '../CardDesign/product_card.dart';
import '../dark_Appbar.dart';

class CollectionDetail extends StatefulWidget {
  final String imagePath;
  const CollectionDetail({
    super.key,
    required this.imagePath
  });


  @override
  State<CollectionDetail> createState() => CollectionDetailState();

}

class CollectionDetailState extends State<CollectionDetail> {
  int _currentJustForYouIndex = 0;

  bool _isSearching = false;
  void toggleSearchView() {
    setState(() {
      _isSearching = !_isSearching;
    });
  }

  final List<Map<String, dynamic>> collectionItem = List.generate(
      6,
          (index) => {
        "id": index + 1,
        "name": index % 2 == 0 ? "Reversible Angora Cardigan" : "mnemo",
        "brand": "October Collection",
        "price": "\$${120 + index}",
        "image": "images/collectionItem${index + 1}.png",
        "sizes": ["S", "M", "L"],
      }
  );

  final List<CollectionModel> collectionList = [
    CollectionModel(index: 'images/01.svg', image: 'images/collection1.png', name: "OCTOBER COLLECTION"),
    CollectionModel(index: 'images/02.svg', image: "images/collection2.png", name: "BLACK COLLECTION"),
    CollectionModel(index: 'images/03.svg', image: 'images/collection3.png', name: "HAE BY HAEKIM")
  ];

  List<CollectionModel> getOtherCollections() {
    return collectionList.where((col) => col.image != widget.imagePath).toList();
  }



  @override
  Widget build(BuildContext context) {
    List<CollectionModel> otherCollections = getOtherCollections();
    return Scaffold(
      appBar: _isSearching
        ? null
        : darkAppBar(context, toggleSearchView),
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
            children: [
              Container(
                decoration: const BoxDecoration(color: Colors.black),
                height: 2470,
                width: double.infinity,
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 100, top: 30),
                          child: SvgPicture.asset(
                            'images/10.svg',
                            width: 195,
                            height: 147,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 120, top: 47),
                          child: Column(
                            children: [
                              Text(
                                'October',
                                style: GoogleFonts.bodoniModa(
                                  fontSize: 54,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 125, top: 107),
                          child: Text(
                            'COLLECTION',
                            style: GoogleFonts.tenorSans(
                              fontSize: 17,
                              color: Colors.white,
                              letterSpacing: 6,
                            ),
                          ),
                        ),
                        Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 140, left: 8, right: 8),
                              child: Image.asset(
                                widget.imagePath,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              left: 170,
                              top: 445,
                              child: ConstrainedBox(
                                constraints: const BoxConstraints(maxWidth: 265),
                                child: SvgPicture.asset(
                                  'images/11.svg',
                                  width: 265,
                                  height: 197,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 30,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio: 0.53,
                          ),
                          itemCount: collectionItem.length,
                          itemBuilder: (context, index) {
                            final item = collectionItem[index];
                            return CollectionItemCard(
                                brand: item["brand"]!,
                                name: item["name"]!,
                                price: item["price"]!,
                                image: item["image"]!,
                                id: index + 1,
                                sizes: item["sizes"]
                            );
                          }
                      ),
                    ),

                    SizedBox(height: 40,),
                    Text('YOU MAY ALSO LIKE', style: GoogleFonts.tenorSans(fontSize: 20, letterSpacing: 4, color: Colors.white),),
                    SizedBox(height: 6,),
                    SvgPicture.asset('images/Divider.svg', color: Colors.white,),
                    SizedBox(height: 30,),
                    CarouselSlider.builder(
                      itemCount: otherCollections.length,
                      itemBuilder: (context, index, realIndex) {
                        final collection = otherCollections[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: CollectionCard(
                            image: collection.image,
                            name: collection.name,
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
                  ],
                ),
              ),
              MyFooter()
            ],
          ),
        ),
      )
    );
  }
}

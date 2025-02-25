import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:open_fashion/Screen/CollectionDetail.dart';
import 'package:open_fashion/Screen/SearchView.dart';
import 'package:open_fashion/model/collection_model.dart';
import '../dark_Appbar.dart';
import '../Drawer.dart';
import '../Footer.dart';

class Collection extends StatefulWidget {
  const Collection({Key? key}) : super(key: key);

  @override
  CollectionState createState() => CollectionState();
}

class CollectionState extends State<Collection> {
  
  bool _isSearching = false;
  void toggleSearchView() {
    setState(() {
      _isSearching = !_isSearching;
    });
  }
  
  final List<CollectionModel> collectionList = [
    CollectionModel(index: 'images/01.svg', image: 'images/collection1.png', name: "OCTOBER COLLECTION"),
    CollectionModel(index: 'images/02.svg', image: "images/collection2.png", name: "BLACK COLLECTION"),
    CollectionModel(index: 'images/03.svg', image: 'images/collection3.png', name: "HAE BY HAEKIM")
  ];
  @override
  Widget build(BuildContext context) {
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
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => CollectionDetail(imagePath: 'images/collection1.png')));
                          },
                          child: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 140, left: 8, right: 8),
                                child: Image.asset(
                                  'images/collection1.png',
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
                        )
                      ],
                    ),
                    const SizedBox(height: 5),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => CollectionDetail(imagePath: 'images/collection1.png')));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5, left: 8, right: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SvgPicture.asset('images/01.svg'),
                            SvgPicture.asset(
                              'images/Line 23.svg',
                              color: Colors.white,
                              width: 150,
                            ),
                            Text(
                              'OCTOBER COLLECTION',
                              style: GoogleFonts.tenorSans(
                                color: Colors.white,
                                letterSpacing: 2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 2,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => CollectionDetail(imagePath: collectionList[index + 1].image)));
                            },
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 70, left: 8, right: 8),
                                  child: Image.asset(collectionList[index + 1].image, width: double.infinity, fit: BoxFit.cover,),
                                ),
                                const SizedBox(height: 5),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5, left: 8, right: 8),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      SvgPicture.asset(collectionList[index + 1].index),
                                      SvgPicture.asset(
                                        'images/Line 23.svg',
                                        color: Colors.white,
                                        width: 150,
                                      ),
                                      Text(
                                        collectionList[index + 1].name,
                                        style: GoogleFonts.tenorSans(
                                          color: Colors.white,
                                          letterSpacing: 2,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                    )
                  ],
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

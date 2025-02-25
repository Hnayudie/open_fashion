import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:open_fashion/AppBar.dart';
import 'package:open_fashion/CardDesign/ItemCard.dart';
import 'package:open_fashion/Drawer.dart';
import 'package:open_fashion/Footer.dart';
import 'package:open_fashion/Screen/FullScreenViewer.dart';
import 'package:open_fashion/bloc/cart_bloc.dart';
import 'package:open_fashion/bloc/cart_event.dart';
import 'SearchView.dart';
class ItemDetail extends StatefulWidget {
  final int id;
  final String brand;
  final String name;
  final String price;
  final String image;
  final List<dynamic> sizes;

  const ItemDetail({super.key,
    required this.id,
    required this.brand,
    required this.name,
    required this.price,
    required this.image,
    required this.sizes,
  });

  @override
  State<ItemDetail> createState() => ItemDetailState();
}

class ItemDetailState extends State<ItemDetail> {
  late PageController _pageController;
  String? selectedSize;
  String? selectedColor;
  int _currentIndex = 0;
  final int imageCount = 5;
  bool isFavorite = false;

  bool _isSearching = false;
  void toggleSearchView() {
    setState(() {
      _isSearching = !_isSearching;
    });
  }

  final List<Map<String, String>> careOptions = [
    {
      'icon': 'images/Shipping.svg',
      'title': 'Free Flat Rate Shipping',
      'details': 'Estimated to be delivered on \n09/11/2021 - 12/11/2021.',
    },
    {
      'icon': 'images/Tag.svg',
      'title': 'COD Policy',
      'details': '1'
    },
    {
      'icon': 'images/Refresh.svg',
      'title': 'Return Policy',
      'details': '1'
    },
  ];

  final List<Map<String, String>> mayAlsoLike = List.generate(
    4,
    (index) => {
      "name": "Reversible Angora Cardigan",
      "brand": index % 2 == 0 ? "21WN" : "Lamerel",
      "price": "\$${120 + index}",
      "image": "images/item${index + 1}.png",
    }
  );



  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _isSearching
        ? null
        : myAppBar(context, toggleSearchView),
      drawer: MyDrawer(),
      backgroundColor: Colors.white,
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
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height / 2,
                          child: PageView.builder(
                            controller: _pageController,
                            itemCount: imageCount,
                            itemBuilder: (context, index) {
                              return Image.asset(widget.image, fit: BoxFit.cover);
                            },
                            onPageChanged: _onPageChanged,
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          right: 10,
                          child: ClipOval(
                            child: Container(
                              height: 36,
                              width: 36,
                              color: Colors.black.withOpacity(0.4),
                              child: IconButton(
                                icon: SvgPicture.asset("images/Resize.svg"),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => FullScreenViewer(
                                        images: List.generate(
                                          imageCount,
                                              (_) => widget.image,
                                        ),
                                        initialIndex: _currentIndex,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        imageCount,
                            (index) => Container(
                          width: 8.0,
                          height: 8.0,
                          margin: const EdgeInsets.symmetric(horizontal: 4.0),
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
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.brand,
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          icon: SvgPicture.asset('images/Export.svg'),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.name,
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.price,
                      style: const TextStyle(fontSize: 18, color: Colors.orange),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Text(
                          'Color ',
                          style: GoogleFonts.tenorSans(color: Colors.grey[600]),
                        ),
                        Row(
                          children: [
                            Text(
                              'Color ',
                              style: GoogleFonts.tenorSans(color: Colors.grey[600]),
                            ),
                            Row(
                              children: [
                                'Red', 'Blue', 'Green'
                              ].map((color) {
                                Color colorValue;
                                switch (color) {
                                  case 'Red':
                                    colorValue = Colors.black;
                                    break;
                                  case 'Blue':
                                    colorValue = Color(0xffDD8560);
                                    break;
                                  default:
                                    colorValue = Color(0xffE1E0DB);
                                }
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedColor = selectedColor == color ? null : color;
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                    child: Container(
                                      width: 28,
                                      height: 28,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: selectedColor == color ? Colors.grey : Colors.transparent,
                                          width: 1,
                                        ),
                                      ),
                                      child: Center(
                                        child: Container(
                                          width: 20,
                                          height: 20,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: colorValue,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),

                        SizedBox(width: 30,),
                        Text(
                          'Size ',
                          style: GoogleFonts.tenorSans(color: Colors.grey[600]),
                        ),
                        Row(
                          children: widget.sizes.map((size) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedSize = selectedSize == size ? null : size;
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                child: Container(
                                  width: 28,
                                  height: 28,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: selectedSize == size
                                        ? Colors.black
                                        : Colors.white,
                                    border: Border.all(
                                      color: Colors.grey,
                                      width: 1,
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    size,
                                    style: TextStyle(
                                      color: selectedSize == size
                                          ? Colors.white
                                          : Colors.grey[600],
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16,),
              OutlinedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                  ),
                  minimumSize: MaterialStateProperty.all(Size(double.infinity, 65)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [Icon(Icons.add, size: 30, color: Colors.white,),
                        SizedBox(width: 5,),
                        Text('ADD TO BASKET', style: GoogleFonts.tenorSans(color: Colors.white),)],
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          isFavorite = !isFavorite; // Toggle favorite status
                        });
                      },
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: Colors.white,
                        size: 33,
                      ),
                    ),
                  ],
                ),
                onPressed: () {
                  if (selectedSize != null && selectedColor != null) {
                    BlocProvider.of<CartBloc>(context).add(
                      AddToCart({
                        'id': widget.id,
                        'brand': widget.brand,
                        'name': widget.name,
                        'price': widget.price,
                        'image': widget.image,
                        'size': widget.sizes,
                        'color': selectedColor,
                      }),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Item added to cart!')),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please select a size and color!'))
                    );
                  }
                },
              ),
              SizedBox(height: 30,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 26),
                child: Column(
                  children: <Widget>[
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text('MATERIALS', style: GoogleFonts.tenorSans(letterSpacing: 2, fontWeight: FontWeight.bold),),
                    ),
                    SizedBox(height: 8,),
                    Text('We work with monitoring programmes to ensure compliance with safety, health and quality standards for our products. ', style: GoogleFonts.tenorSans(fontSize: 14, color: Color(0xff555555), height: 1.8)),
                    SizedBox(height: 26,),
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text('CARE', style: GoogleFonts.tenorSans(letterSpacing: 2, fontWeight: FontWeight.bold),),
                    ),
                    SizedBox(height: 8,),
                    Text("To keep your jackets and coats clean, you only need to freshen them up and go over them with a cloth or a clothes brush. If you need to dry clean a garment, look for a dry cleaner that uses technologies that are respectful of the environment.", style: GoogleFonts.tenorSans(fontSize: 14, color: Color(0xff555555), height: 1.8)),
                    SizedBox(height: 24,),
                    Row(
                      children: [
                        SvgPicture.asset('images/Do Not Bleach.svg'),
                        SizedBox(width: 10,),
                        Text('Do not use bleach', style: GoogleFonts.tenorSans(color: Color(0xff555555)),)
                      ],
                    ),
                    SizedBox(height: 15,),
                    Row(
                      children: [
                        SvgPicture.asset('images/Do Not Tumble Dry.svg'),
                        SizedBox(width: 10,),
                        Text('Do Not Tumble Dry', style: GoogleFonts.tenorSans(color: Color(0xff555555)),)
                      ],
                    ),
                    SizedBox(height: 15,),
                    Row(
                      children: [
                        SvgPicture.asset('images/Do Not Wash.svg'),
                        SizedBox(width: 10,),
                        Text('Dry clean with tetrachloroethylene', style: GoogleFonts.tenorSans(color: Color(0xff555555)),)
                      ],
                    ),
                    SizedBox(height: 15,),
                    Row(
                      children: [
                        SvgPicture.asset('images/Iron Low Temperature.svg'),
                        SizedBox(width: 10,),
                        Text('Iron at a maximum of 110ºC/230ºF', style: GoogleFonts.tenorSans(color: Color(0xff555555)),)
                      ],
                    ),
                    SizedBox(height: 35,),
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text('CARE', style: GoogleFonts.tenorSans(letterSpacing: 2, fontWeight: FontWeight.bold),),
                    ),
                    SizedBox(height: 16,),
                    Theme(
                      data: Theme.of(context).copyWith(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        dividerColor: Colors.transparent,
                      ),
                      child: ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        separatorBuilder: (BuildContext context, int index) => Padding(
                          padding: EdgeInsets.only(left: 37),
                          child: Divider(
                            color: Colors.grey[300],
                          ),
                        ),
                        itemCount: careOptions.length,
                        itemBuilder: (context, index) {
                          final option = careOptions[index];
                          return ExpansionTile(
                            childrenPadding: EdgeInsets.zero,
                            tilePadding: EdgeInsets.zero,
                            minTileHeight: 0,
                            title: Row(
                              children: [
                                SvgPicture.asset(option['icon']!),
                                SizedBox(width: 12),
                                Text(
                                  option['title']!,
                                  style: GoogleFonts.tenorSans(),
                                ),
                              ],
                            ),
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(width: 37),
                                  Text(
                                    option['details']!,
                                    style: GoogleFonts.tenorSans(color: Color(0xff555555)),
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 35,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('YOU MAY ALSO LIKE', style: GoogleFonts.tenorSans(letterSpacing: 2.5, fontSize: 20),),
                    SizedBox(height: 3,),
                    SvgPicture.asset('images/Divider.svg'),
                    SizedBox(height: 16),
                    // Product Grid
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio: 0.53,
                          ),
                          itemCount: mayAlsoLike.length,
                          itemBuilder: (context, index) {
                            final item = mayAlsoLike[index];
                            return ItemCard(
                                brand: item["brand"]!,
                                name: item["name"]!,
                                price: item["price"]!,
                                image: item["image"]!,
                              id: index + 1,
                              sizes: [],
                            );
                          }
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

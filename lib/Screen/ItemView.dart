import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:open_fashion/AppBar.dart';
import 'package:open_fashion/Drawer.dart';
import 'package:open_fashion/Screen/SearchView.dart';
import '../CardDesign/ItemCard.dart';
import '../Footer.dart';
import '../model/item_list_view.dart';

class ItemView extends StatefulWidget {
  @override
  _ItemViewState createState() => _ItemViewState();



  final List<Map<String, dynamic>> items = List.generate(
    51,
        (index) => {
      "id": index + 1,
      "name": "Reversible Angora Cardigan $index",
      "brand": index % 2 == 0 ? "21WN" : "Lamerel",
      "price": "\$${120 + index}",
      "image": "images/item${index + 1}.png",
      "rating": "4.8 Rating",
      "sizes": ["S", "M", "L"],
    },
  );

  ItemView({super.key});
}

class _ItemViewState extends State<ItemView> {
  String dropDownMenu = "New";
  int itemsPerPage = 10;
  int currentPage = 1;
  int status = 0;

  bool _isSearching = false;
  void toggleSearchView() {
    setState(() {
      _isSearching = !_isSearching;
    });
  }
  @override
  Widget build(BuildContext context) {
    final totalPages = (widget.items.length / itemsPerPage).ceil();
    final startIndex = (currentPage - 1) * itemsPerPage;
    final endIndex = (startIndex + itemsPerPage > widget.items.length)
        ? widget.items.length
        : startIndex + itemsPerPage;
    final currentItems = widget.items.sublist(startIndex, endIndex);

    // Define the range of page numbers to display (5 pages at a time)
    List<int> pageNumbers = [];
    int startPage = currentPage - 2;
    int endPage = currentPage + 2;

    if (startPage < 1) {
      startPage = 1;
      endPage = startPage + 4;
    }
    if (endPage > totalPages) {
      endPage = totalPages;
      startPage = endPage - 4;
    }

    for (int i = startPage; i <= endPage; i++) {
      pageNumbers.add(i);
    }

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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "4500 APPAREL",
                          style: GoogleFonts.tenorSans(fontSize: 16),
                        ),
                        Spacer(),
                        Container(
                          width: 86, // Adjust the width to match the image
                          height: 35, // Adjust the height to match the image
                          decoration: BoxDecoration(
                            color: Colors.grey[200], // Background color
                            borderRadius: BorderRadius.circular(20), // Rounded edges
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: dropDownMenu,
                              icon: Icon(Icons.arrow_drop_down),
                              isExpanded: true,
                              items: ["New", "Apparel", "Bag", "Shoes", "Beauty", "Accessories"]
                                  .map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Center(
                                    child: Text(
                                      value,
                                      style: GoogleFonts.tenorSans(fontSize: 16),
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropDownMenu = newValue!;
                                });
                              },
                            ),
                          ),
                        ),
                        IconButton(
                          icon: status == 0
                              ? Icon(Icons.grid_view)
                              : Icon(Icons.list),
                          onPressed: () {
                            setState(() {
                              if(status == 0) {
                                status = 1;
                              } else {
                                status = 0;
                              }
                            });
                          },
                          tooltip: "Grid/List View",
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.filter_list),
                          tooltip: "Filter",
                          color: Colors.orange,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Row(
                        children: [
                          FilterChipWidget(label: "Women"),
                          SizedBox(width: 8),
                          FilterChipWidget(label: "All apparel"),
                        ],
                      ),
                    ),
                    SizedBox(height: 12),
                    status == 0
                        ? ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: currentItems.length,
                        itemBuilder: (context, index) {
                          final item = currentItems[index];
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: ItemListView(
                              id: index + 1,
                              brand: item["brand"]!,
                              name: item["name"]!,
                              price: item["price"]!,
                              image: item["image"]!,
                              rating: item["rating"],
                              sizes: item["sizes"],
                            ),
                          );
                        }
                    )
                        : GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 0.57,
                        ),
                        itemCount: currentItems.length,
                        itemBuilder: (context, index) {
                          final item = currentItems[index];
                          return ItemCard(
                            id: index + 1,
                              brand: item["brand"]!,
                              name: item["name"]!,
                              price: item["price"]!,
                              image: item["image"]!,
                            sizes: item["sizes"],

                          );
                        }
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (currentPage > 1)
                          IconButton(
                            icon: Icon(Icons.navigate_before),
                            onPressed: () {
                              setState(() {
                                currentPage--;
                              });
                            },
                          ),
                        ...pageNumbers.map(
                              (pageNumber) => Padding(
                            padding: EdgeInsets.symmetric(horizontal: 0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: pageNumber == currentPage
                                    ? Colors.black
                                    : Colors.grey[300],
                                foregroundColor: pageNumber == currentPage
                                    ? Colors.white
                                    : Colors.black,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.zero
                                ),
                                minimumSize: Size(32, 32),
                                padding: EdgeInsets.zero,
                              ),
                              onPressed: () {
                                setState(() {
                                  currentPage = pageNumber;
                                });
                              },
                              child: Center(
                                child: Text(
                                  '$pageNumber',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                            ),
                          ),
                        ),
                        if (currentPage < totalPages)
                          IconButton(
                            icon: Icon(Icons.navigate_next),
                            onPressed: () {
                              setState(() {
                                currentPage++;
                              });
                            },
                          ),
                      ],
                    ),
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

class FilterChipWidget extends StatelessWidget {
  final String label;

  const FilterChipWidget({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return InputChip(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      label: Text(label),
      deleteIcon: Icon(Icons.close),
      onDeleted: () {
        // Handle chip deletion
      },
      labelStyle: TextStyle(color: Colors.black),
    );
  }
}








import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchView extends StatefulWidget {
  final VoidCallback onClose;

  const SearchView({Key? key, required this.onClose}) : super(key: key);

  @override
  SearchViewState createState() => SearchViewState();
}

class SearchViewState extends State<SearchView> {
  final List<String> popularSearchTerms = [
    "Trend",
    "Dress",
    "Bag",
    "Tshirt",
    "Beauty",
    "Accessories",
  ];

  final List<String> recentSearchTerms = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: widget.onClose, // Close when tapping outside
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),

              // Search Bar Row
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      onTapOutside: (event) {
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      onSubmitted: (value) {
                        if (value.isNotEmpty &&
                            !recentSearchTerms.contains(value)) {
                          setState(() {
                            recentSearchTerms.add(value);
                          });
                        }
                      },
                      decoration: InputDecoration(
                        hintText: 'Search items',
                        hintStyle: const TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: SvgPicture.asset('images/Search.svg'),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: widget.onClose, // Close button
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Divider(thickness: 1, color: Colors.black),
              ),

              // Recent Search Terms Section
              if (recentSearchTerms.isNotEmpty) ...[
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Text(
                    'Recent search',
                    style: GoogleFonts.tenorSans(
                      fontSize: 15,
                      color: Colors.grey,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 10,
                  children: recentSearchTerms.map((term) {
                    return Chip(
                      deleteIconColor: Color(0xff000000),
                      deleteIcon: SvgPicture.asset('images/Close.svg'),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      side: BorderSide(style: BorderStyle.none),
                      backgroundColor: Colors.grey[100],
                      label: Text(
                        term,
                        style: GoogleFonts.tenorSans(
                          color: Color(0xff555555),
                        ),
                      ),
                      onDeleted: () {
                        setState(() {
                          recentSearchTerms.remove(term);
                        });
                      },
                    );
                  }).toList(),
                ),
              ],

              const SizedBox(height: 12),

              // Popular Search Terms Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Text(
                  'Popular search terms',
                  style: GoogleFonts.tenorSans(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: popularSearchTerms.map(
                      (term) => TextButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(horizontal: 14),
                      ),
                      overlayColor:
                      MaterialStateProperty.all(Colors.transparent),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    onPressed: () {
                      setState(() {
                        if (!recentSearchTerms.contains(term)) {
                          recentSearchTerms.add(term);
                        }
                      });
                    },
                    child: Text(
                      term,
                      style: GoogleFonts.tenorSans(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        height: 1.0,
                      ),
                    ),
                  ),
                ).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

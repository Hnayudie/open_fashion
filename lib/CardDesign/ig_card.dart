import 'package:flutter/material.dart';

class IgCard extends StatelessWidget {
  final Widget ig;
  final String tag;

  const IgCard({
    super.key,
    required this.ig,
    required this.tag,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Stack(
        children: [
          Positioned.fill(
            child: ig,
          ),
          Positioned(
            bottom: 8,
            left: 0,
            right: 110,
            child: Text(
              tag,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                backgroundColor: Colors.black54,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
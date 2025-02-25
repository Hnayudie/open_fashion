import 'package:flutter/material.dart';

class FeatureCard extends StatelessWidget {
  final Widget icon;
  final String subtitle;

  const FeatureCard({super.key,
    required this.icon,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 40, width: 40, child: icon),
        const SizedBox(height: 10),

        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black54),
        ),
      ],
    );
  }
}
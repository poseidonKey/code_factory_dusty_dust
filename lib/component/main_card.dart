import "package:flutter/material.dart";

import "../const/colors.dart";

class MainCard extends StatelessWidget {
  final Widget child;
  const MainCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      color: lightColor,
      child: child,
    );
  }
}

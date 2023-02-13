import "package:flutter/material.dart";

class MainCard extends StatelessWidget {
  final Widget child;
  final Color backgroundColor;
  const MainCard(
      {super.key, required this.child, required this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      color: backgroundColor,
      child: child,
    );
  }
}

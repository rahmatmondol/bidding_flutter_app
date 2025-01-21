import 'package:flutter/material.dart';

class MyScaffoldBackground extends StatelessWidget {
  MyScaffoldBackground({
    super.key,
    required this.size,
    required this.child,
  });

  final Size size;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height,
      width: size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xff4C5B7D),
            Color(0xff303030),
            Color(0xff5A5D63),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: child,
    );
  }
}

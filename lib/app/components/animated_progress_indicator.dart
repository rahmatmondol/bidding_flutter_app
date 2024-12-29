import 'package:dirham_uae/config/theme/light_theme_colors.dart';
import 'package:flutter/material.dart';

class AnimatedLinearProgressIndicator extends StatelessWidget {
  final double percentage;

  const AnimatedLinearProgressIndicator({Key? key, required this.percentage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      child: Center(
        child: TweenAnimationBuilder(
          tween: Tween<double>(begin: 0, end: percentage),
          duration: Duration(seconds: 1),
          builder: (context, double value, child) => LinearProgressIndicator(
            value: value,
            color: LightThemeColors.primaryColor,
            backgroundColor: LightThemeColors.dividerColor,
          ),
        ),
      ),
    );
  }
}

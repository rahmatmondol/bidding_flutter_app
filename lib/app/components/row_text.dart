import 'package:dirham_uae/config/theme/light_theme_colors.dart';
import 'package:dirham_uae/config/theme/my_styles.dart';
import 'package:flutter/material.dart';

class RowText extends StatelessWidget {
  final String title;
  final String buttonName;
  final VoidCallback ontap;
  const RowText({
    super.key,
    required this.title,
    required this.buttonName,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kTitleTextstyle.copyWith(fontWeight: FontWeight.bold),
        ),
        InkWell(
          onTap: ontap,
          child: Text(
            buttonName,
            style: kSubtitleStyle.copyWith(
                color: LightThemeColors.primaryColor,
                fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}

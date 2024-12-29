import 'package:dirham_uae/config/theme/light_theme_colors.dart';
import 'package:dirham_uae/config/theme/my_styles.dart';
import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  final String name;
  final String iconName;
  final VoidCallback ontap;
  const ProfileCard({
    super.key,
    required this.name,
    required this.ontap,
    required this.iconName,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Row(
        children: [
          ImageIcon(
            AssetImage(iconName),
            color: LightThemeColors.whiteColor,
          ),
          gapWidth(size: 20),
          Expanded(
              child: Text(
            name,
            style: kTitleTextstyle,
          )),
          Icon(
            Icons.arrow_right,
            color: LightThemeColors.whiteColor,
          )
        ],
      ),
    );
  }
}

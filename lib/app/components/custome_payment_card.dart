import 'package:dirham_uae/config/theme/light_theme_colors.dart';
import 'package:dirham_uae/config/theme/my_styles.dart';
import 'package:flutter/material.dart';

Widget customPaymentCard(
    {required final String title,
    final String? subtitle,
    required final String price,
    final Color? color,
    final Icon? icon}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(
        children: [
          Text(title),
          gapWidth(size: 5),
          subtitle != null
              ? Container(
                  height: 30,
                  decoration: BoxDecoration(
                      color: LightThemeColors.primaryColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Center(child: Text(subtitle.toString())),
                  ),
                )
              : SizedBox.shrink()
        ],
      ),
      Row(
        children: [
          icon != null
              ? Container(
                  height: 30,
                  width: 30,
                  decoration:
                      BoxDecoration(shape: BoxShape.circle, color: color),
                  child: Icon(icon.icon),
                )
              : SizedBox.shrink(),
          gapWidth(size: 5),
          Text(price),
        ],
      )
    ],
  );
}

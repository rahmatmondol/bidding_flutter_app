import 'package:dirham_uae/config/theme/light_theme_colors.dart';
import 'package:dirham_uae/config/theme/my_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../../config/theme/my_images.dart';

class SearchButton extends StatelessWidget {
  final String hintsText;
  final VoidCallback ontap;

  const SearchButton({
    super.key,
    required this.hintsText,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return InkWell(
      onTap: ontap,
      child: Container(
          height: size.height / 15,
          width: size.width,
          decoration: BoxDecoration(
            color: LightThemeColors.secounderyColor,
            boxShadow: [
              BoxShadow(
                color: LightThemeColors.shadowColor,
                offset: Offset(0, 2),
                blurRadius: 5,
              )
            ],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 15.0.w),
            child: Row(
              children: [
                Image.asset(Img.searchIcon),
                gapWidth(size: 10.0),
                Text(
                  hintsText,
                  style: kSubtitleStyle.copyWith(
                    color: LightThemeColors.grayColor,
                  ),
                ),
              ],
            ),
          )),
    );
  }
}

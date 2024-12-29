import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../config/theme/light_theme_colors.dart';

class CustomBackButton extends StatelessWidget {
  final VoidCallback ontap;
  const CustomBackButton({
    super.key,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 6.r, vertical: 3.r),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: LightThemeColors.borderColor,
          ),
        ),
        child: Icon(
          Icons.arrow_back,
          color: LightThemeColors.midBlackColor,
        ),
      ),
    );
  }
}

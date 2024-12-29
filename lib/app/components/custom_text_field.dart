import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../config/theme/light_theme_colors.dart';
import '../../config/theme/my_styles.dart';

class CustomTextField extends StatelessWidget {
  final String? labelText;
  final String hintText;
  final TextEditingController? controller;
  final Function()? onTap;
  final bool? isSuffixIcon;
  final bool readOnly;
  final TextInputType? textInputType;
  final bool? isIcon;
  final String? icon;
  final FormFieldValidator<String>? validator;
  final double? prefixIconScale;
  final int? maxLength;
  final Color? fillColor;
  final int? maxLines;
  CustomTextField(
      {super.key,
      this.readOnly = true,
      this.isSuffixIcon,
      this.labelText,
      required this.hintText,
      required this.controller,
      this.textInputType,
      this.isIcon = false,
      this.icon,
      this.prefixIconScale,
      this.validator,
      this.onTap,
      this.maxLength,
      this.maxLines = 1, this.fillColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 20,
      decoration: BoxDecoration(
        color: LightThemeColors.secounderyColor,
        borderRadius: BorderRadius.circular(10),
        // boxShadow: [
        //   BoxShadow(
        //     color: LightThemeColors.shadowColor,
        //     offset: Offset(0, 1),
        //     blurRadius: 5,
        //   )
        // ],
      ),
      child: TextFormField(
        maxLength: maxLength,
        maxLines: maxLength,
        onTap: onTap,
        style: TextStyle(color: fillColor),
        keyboardType: textInputType,
        validator: validator,
        autovalidateMode: AutovalidateMode.always,
        enabled: readOnly,
        cursorColor: LightThemeColors.primaryColor,
        controller: controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: LightThemeColors.secounderyColor,
          floatingLabelBehavior: FloatingLabelBehavior.always,

          labelText: labelText,
          labelStyle: kTitleTextstyle.copyWith(
              fontSize: 12.sp, color: LightThemeColors.whiteColor),
          hintText: hintText,
          hintStyle: kSubtitleStyle.copyWith(
              color: LightThemeColors.grayColor, fontSize: 12.sp),
          // prefixIcon:
          //     isIcon == true ? ImageIcon(AssetImage(icon.toString())) : null,
          prefixIcon: isIcon == true
              ? Image.asset(
                  icon.toString(),
                  scale: prefixIconScale,
                )
              : null,
          // border: InputBorder.none,
          // focusedBorder: InputBorder.none,
          // enabledBorder: InputBorder.none
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide:
                BorderSide(color: LightThemeColors.secounderyColor, width: 0.0),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide:
                BorderSide(color: LightThemeColors.secounderyColor, width: 0.0),
          ),
          // border: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(8.r),
          //   borderSide: const BorderSide(
          //       color: LightThemeColors.scaffoldBackgroundColor, width: 0.0),
          // ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide:
                BorderSide(color: LightThemeColors.secounderyColor, width: 0.0),
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../config/theme/light_theme_colors.dart';
import '../../config/theme/my_images.dart';
import '../../config/theme/my_styles.dart';

class CustomPasswordTextField extends StatefulWidget {
  final String? labelText;
  final String hintText;
  final TextEditingController? controller;
  final RxBool isVisible = true.obs;
  final FormFieldValidator<String>? validate;
    final Color? fillColor;


  CustomPasswordTextField({
    super.key,
    this.labelText,
    this.validate,
    required this.hintText,
    required this.controller, this.fillColor,
  });

  @override
  State<CustomPasswordTextField> createState() =>
      _CustomPasswordTextFieldState();
}

class _CustomPasswordTextFieldState extends State<CustomPasswordTextField> {
  // final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          decoration: BoxDecoration(
            color: LightThemeColors.secounderyColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextFormField(
            cursorColor: LightThemeColors.primaryColor,
            // enabled: widget.readOnly,
            controller: widget.controller,
          
            obscureText: widget.isVisible.value,
            validator: widget.validate,
            style: TextStyle(color: LightThemeColors.bodyTextColor),
            decoration: InputDecoration(
              // filled: true,
              fillColor: LightThemeColors.secounderyBackgroundColor,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              labelText: widget.labelText,
              labelStyle: kSubtitleStyle.copyWith(color: Colors.black),
              hintText: widget.hintText,
              hintStyle: kSubtitleStyle.copyWith(
                color: LightThemeColors.secounderyTextColor,
              ),
              prefixIcon: Image.asset(
                Img.passwordIcon,
                scale: 3,
              ),
              suffixIcon: Obx(
                () => IconButton(
                  onPressed: () {
                    widget.isVisible.value = !widget.isVisible.value;
                  },
                  icon: widget.isVisible == false
                      ? const Icon(Icons.visibility_outlined,
                          color: LightThemeColors.primaryColor)
                      : Icon(Icons.visibility_off_outlined,
                          color: LightThemeColors.primaryColor),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(
                    color: LightThemeColors.secounderyColor, width: 0.0),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(
                    color: LightThemeColors.secounderyColor, width: 0.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(
                    color: LightThemeColors.secounderyColor, width: 0.0),
              ),
            ),
          ),
        ));
  }
}

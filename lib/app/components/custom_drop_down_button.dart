import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../config/theme/light_theme_colors.dart';
import '../../config/theme/my_styles.dart';

class CustomDropdown extends StatelessWidget {
  final String hintText;
  final List<String> items;
  final RxString value;
  final Function(String?)? onChanged;
  final Function(String?)? onSaved;
  final String? Function(String?)? validator;

  const CustomDropdown({
    Key? key,
    required this.hintText,
    required this.items,
    required this.value,
    this.onChanged,
    this.onSaved,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      // itemHeight: 30,
      menuMaxHeight: 300.h,
      isExpanded: true,
      
      dropdownColor: LightThemeColors.scaffoldBackgroundColor,
      decoration: InputDecoration(
        // floatingLabelStyle: TextStyle(color: Colors.red),
        // labelStyle: TextStyle(color: Colors.red),
        fillColor: LightThemeColors.whiteColor,
        iconColor: LightThemeColors.primaryColor,
        errorBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        hintText: hintText,
        hintStyle: kTitleTextstyle.copyWith(color: Colors.green),
      ),
      value: value.value,
      onChanged: onChanged ??
          (newValue) {
            value.value = newValue!;
          },
      onSaved: onSaved ??
          (newValue) {
            value.value = newValue!;
          },
      validator: validator ??
          (newValue) {
            if (newValue == null || newValue.isEmpty) {
              return "can't be empty";
            } else {
              return null;
            }
          },
      items: items.map((val) {
        return DropdownMenuItem(
          value: val,
          child: Text(val),
        );
      }).toList(),
    );
  }
}

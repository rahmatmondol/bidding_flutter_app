// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:dirham_uae/app/components/custom_button.dart';
import 'package:dirham_uae/config/theme/light_theme_colors.dart';
import 'package:dirham_uae/config/theme/my_images.dart';
import 'package:dirham_uae/config/theme/my_styles.dart';
import '../controllers/customer_language_controller.dart';


class CustomerLanguageView extends GetView<CustomerLanguageController> {
  const CustomerLanguageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
          top: MediaQuery.paddingOf(context).top + 20.r,
          left: 15.r,
          right: 15.r,
        ),
        decoration: BoxDecoration(gradient: buildCustomGradient()),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Language',
                style: kTitleTextstyle.copyWith(
                    fontWeight: FontWeight.bold, fontSize: 16.sp),
              ),
            ),
            gapHeight(size: 20),
            Text(
              'Select Language',
              style: kTitleTextstyle.copyWith(fontWeight: FontWeight.bold),
            ),
            gapHeight(size: 20),
            InkWell(
              onTap: () {
                controller.changeLanguage("English");
              },
              child: Obx(() => Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.r, horizontal: 10.r),
                    //height: 160.h,
                    // width: 160.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      color: controller.selectedLanguage == "English"
                          ? LightThemeColors.secounderyButtonColor
                          : LightThemeColors.secounderyColor,
                      boxShadow: [
                        BoxShadow(
                          color: LightThemeColors.shadowColor,
                          offset: Offset(1, 0),
                          blurRadius: 3,
                        )
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(Img.engLanguageIcon),
                        gapWidth(size: 10),
                        Text(
                          "English",
                          style: kTitleTextstyle,
                        ),
                      ],
                    ),
                  )),
            ),
            gapHeight(size: 20),
            InkWell(
              onTap: () {
                controller.changeLanguage("Arabic");
              },
              child: Obx(
                () => Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.r, horizontal: 10.r),

                  //height: 160.h,
                  // width: 160.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    color: controller.selectedLanguage == "Arabic"
                        ? LightThemeColors.secounderyButtonColor
                        : LightThemeColors.secounderyColor,
                    boxShadow: [
                      BoxShadow(
                        color: LightThemeColors.shadowColor,
                        offset: Offset(1, 0),
                        blurRadius: 3,
                      )
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(Img.arabicLannguageIcon),
                      gapWidth(size: 10),
                      Text(
                        "Arabic",
                        style: kTitleTextstyle,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            gapHeight(size: 10),
            Text(
              "You can change language later form menu ber ",
              style: kSubtitleStyle,
            ),
            gapHeight(size: 10),
            Spacer(),
            CustomButton(
              bgColor: LightThemeColors.primaryColor,
              ontap: () {},
              widget: Text(
                "Get Started",
                style: kTitleTextstyle.copyWith(
                  color: LightThemeColors.whiteColor,
                ),
              ),
            ),
            gapHeight(size: 20),
          ],
        ),
      ),
    );
  
  }
}

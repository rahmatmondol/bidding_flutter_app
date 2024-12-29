import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:dirham_uae/config/theme/light_theme_colors.dart';
import 'package:dirham_uae/config/theme/my_images.dart';
import 'package:dirham_uae/config/theme/my_styles.dart';

import '../controllers/thanks_controller.dart';

class ThanksView extends GetView<ThanksController> {
  const ThanksView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.sizeOf(context).width,
        padding: EdgeInsets.only(
          // top: MediaQuery.paddingOf(context).top + 20.r,
          left: 15.r,
          right: 15.r,
        ),
        decoration: BoxDecoration(gradient: buildCustomGradient()),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(Img.thanksImg),
            // gapHeight(size: 10),
            Text(
              "Thank You",
              style: kHeadingTextStyle,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "You Bidding has been successful submitted. You will receive a conformation soon",
                textAlign: TextAlign.center,
                style: kTitleTextstyle.copyWith(
                  color: LightThemeColors.secounderyTextColor,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

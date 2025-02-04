import 'package:dirham_uae/app/components/custom_appBar.dart';
import 'package:dirham_uae/config/theme/light_theme_colors.dart';
import 'package:dirham_uae/config/theme/my_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/customer_privacy_and_policy_controller.dart';

class PrivacyAndPolicyView extends GetView<PrivacyAndPolicyController> {
  const PrivacyAndPolicyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
          top: 0,
          left: 15.r,
          right: 15.r,
        ),
        decoration: BoxDecoration(gradient: buildCustomGradient()),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomHeaderBar(title: 'Privacy and policy'),
            //gapHeight(size: 10),
            Text(
              "Last updated Jly 2023",
              style: kTitleTextstyle.copyWith(
                color: LightThemeColors.secounderyTextColor,
              ),
            ),

            gapHeight(size: 20),

            Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                "01 YOUR AGREMENTT",
                style: kTitleTextstyle.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            gapHeight(size: 10),

            Text(
              "This summary provides key points from our privacy notice, but you can find out more details about any of these topics by clicking the link following each key point or by using our table of contents below to find the section you are looking for. You can also click here to go directly to our table of contents.",
              style: kSubtitleStyle.copyWith(
                color: LightThemeColors.secounderyTextColor,
                fontSize: 12.sp,
              ),
            ),

            gapHeight(size: 10),

            Text(
              "This summary provides key points from our privacy notice, but you can find out more details about any of these topics by clicking the link following each key point or by using our table of contents below to find the section you are looking for. You can also click here to go directly to our table of contents.",
              style: kSubtitleStyle.copyWith(
                color: LightThemeColors.secounderyTextColor,
              ),
            ),
            gapHeight(size: 20),

            Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                "02 PRIVACY",
                style: kTitleTextstyle.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            gapHeight(size: 10),

            Text(
              "This summary provides key points from our privacy notice, but you can find out more details about any of these topics by clicking the link following each key point or by using our table of contents below to find the section you are looking for. You can also click here to go directly to our table of contents.",
              style: kSubtitleStyle.copyWith(
                color: LightThemeColors.secounderyTextColor,
                fontSize: 12.sp,
              ),
            ),

            gapHeight(size: 10),
          ],
        ),
      ),
    );
  }
}

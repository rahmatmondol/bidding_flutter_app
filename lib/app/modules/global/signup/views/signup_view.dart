import 'package:dirham_uae/config/theme/light_theme_colors.dart';
import 'package:dirham_uae/config/theme/my_styles.dart';
import 'package:dirham_uae/utils/global_variable/divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/signup_controller.dart';

class SignupView extends GetView<SignupController> {
  const SignupView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);

    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff4C5B7D),
              // Color(0xff303030),
              Color(0xff5A5D63),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              divider,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                child: Text(
                  "Create Account",
                  style: kHeadingTextStyle,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                child: Text(
                  "Explore the SMART BIDDING World",
                  style: kSubtitleStyle,
                ),
              ),
              divider,
              //**********Text************ */
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                child: Text(
                  "Select Category",
                  style: kSubtitleStyle,
                ),
              ),
              gapHeight(size: 12.0.h),

              // ***********CustomTabBar*************

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                child: SizedBox(
                  height: size.height / 16,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      return Obx(
                        () => InkWell(
                          onTap: () {
                            controller.currentIndex.value = index;
                          },
                          child: Container(
                            width: size.width / 2.3,
                            height: size.height / 16,
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                              color: LightThemeColors.secounderyColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              // crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                controller.currentIndex.value == index
                                    ? Container(
                                        height: 20.0.h,
                                        width: 20.0.w,
                                        decoration: BoxDecoration(
                                          color: LightThemeColors.primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                              color: Colors.blueAccent),
                                        ),
                                        child: Icon(
                                          Icons.check,
                                          size: 18,
                                          color: LightThemeColors.whiteColor,
                                        ),
                                      )
                                    : Container(
                                        height: 20.0.h,
                                        width: 20.0.w,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                              color: Colors.blueAccent),
                                        ),
                                      ),
                                gapWidth(size: 6.0.w),
                                Image.asset(
                                  controller.itemIcons[index].toString(),
                                  scale: 5,
                                ),
                                gapWidth(size: 6.0.w),
                                Text(
                                  controller.items[index].toString(),
                                  style: kTitleTextstyle,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),

              //********tabview************ */

              Obx(
                () => Expanded(
                  child: controller.tabScreen[controller.currentIndex.value],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

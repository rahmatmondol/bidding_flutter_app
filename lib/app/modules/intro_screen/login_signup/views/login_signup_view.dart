import 'package:dirham_uae/app/components/custom_button.dart';
import 'package:dirham_uae/app/modules/global/login/controllers/login_controller.dart';
import 'package:dirham_uae/app/routes/app_pages.dart';
import 'package:dirham_uae/config/theme/light_theme_colors.dart';
import 'package:dirham_uae/config/theme/my_images.dart';
import 'package:dirham_uae/config/theme/my_styles.dart';
import 'package:dirham_uae/utils/global_variable/divider.dart';
import 'package:dirham_uae/utils/global_variable/my_scaffold_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LoginSignupView extends GetView<LoginController> {
  const LoginSignupView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: MyScaffoldBackground(
        size: size,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(left: 15.0.w, right: 15.0.w, top: 45.0.h),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome to SMAET BIDDING",
                  style: kTitleTextstyle,
                ),
                divider,

                // **********row text*****************
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "You, Work smart without cutting gandha,",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: kHeadingTextStyle.copyWith(
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return LinearGradient(
                          colors: [Colors.blue, Colors.green],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ).createShader(bounds);
                      },
                      child: Text(
                        '\nStay with us.',
                        style: kHeadingTextStyle,
                      ),
                    ),
                  ],
                ),
                divider,
                divider,
                Spacer(),
                Spacer(),
                // **********Images*****************
                Image.asset(
                  Img.introTwo,
                ),
                gapHeight(size: 2.0.h),
                Spacer(),
                Spacer(),
                Text(
                    "now on need to worry if you want Togo anywhere, find lost flight tickets to various destinations want in jest an app!"),
                divider,
                Spacer(),
                CustomButton(
                  bgColor: LightThemeColors.primaryColor,
                  widget: Text(
                    "Login",
                    style: kTitleTextstyle,
                  ),
                  ontap: () => Get.toNamed(Routes.LOGIN),
                ),
                divider,
                CustomButton(
                  bgColor: LightThemeColors.secounderyColor,
                  widget: Text(
                    "Create Account",
                    style: kTitleTextstyle,
                  ),
                  ontap: () => Get.toNamed(Routes.SIGNUP),
                ),
                gapHeight(size: 33.0.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

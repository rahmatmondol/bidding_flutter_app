import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:dirham_uae/app/components/custom_button.dart';
import 'package:dirham_uae/app/routes/app_pages.dart';
import 'package:dirham_uae/config/theme/light_theme_colors.dart';
import 'package:dirham_uae/config/theme/my_images.dart';
import 'package:dirham_uae/config/theme/my_styles.dart';
import 'package:dirham_uae/utils/global_variable/divider.dart';
import 'package:dirham_uae/utils/global_variable/my_scaffold_background.dart';
import '../controllers/intro_one_controller.dart';

class IntroOneView extends GetView<IntroOneController> {
  const IntroOneView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: MyScaffoldBackground(
        size: size,
        child: Column(
          children: [
            divider,
            Expanded(
              flex: 1,
              child: Image.asset(
                Img.appLogo,
                scale: 6,
              ),
            ),
            Expanded(flex: 3, child: Image.asset(Img.introOne)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0.w),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          child: Text(
                            "You, Work smart without cutting Gandha",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: kHeadingTextStyle.copyWith(
                              fontWeight: FontWeight.w400,
                            ),
                          ),
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
                  gapHeight(size: 5.0.h),
                  Text(
                      "now on need to worry if you want Togo anywhere, find lost flight tickets to various destinations want in jest an app!")
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 15.0.w, vertical: 37.0.h),
                child: CustomButton(
                  bgColor: LightThemeColors.primaryColor,
                  widget: Text(
                    "Get Start",
                    style: kTitleTextstyle,
                  ),
                  ontap: () => Get.toNamed(Routes.LOGIN_SIGNUP),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

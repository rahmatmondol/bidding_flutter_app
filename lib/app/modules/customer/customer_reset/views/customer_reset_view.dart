import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:dirham_uae/app/components/custom_button.dart';
import 'package:dirham_uae/app/components/custom_text_field.dart';
import 'package:dirham_uae/config/theme/light_theme_colors.dart';
import 'package:dirham_uae/config/theme/my_images.dart';
import 'package:dirham_uae/utils/global_variable/my_scaffold_background.dart';
import '../../../../../config/theme/my_styles.dart';
import '../../../../../utils/global_variable/divider.dart';
import '../../../../routes/app_pages.dart';
import '../controllers/customer_reset_controller.dart';

class CustomerResetView extends GetView<CustomerResetController> {
  const CustomerResetView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: MyScaffoldBackground(
        size: size,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0.w),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                divider,
                divider,
                //********Titile is here***** */
                Text(
                  "Reset Password",
                  style: kHeadingTextStyle,
                ),
                Text(
                  "Enter the email associated with your account \nand we'll send an email with instructions to reset your password.",
                  style: kSubtitleStyle,
                ),
                divider,
                divider,
                Image.asset(Img.resetImg),
                Text(
                  "Email Address",
                  style: kTitleTextstyle,
                ),
                gapHeight(size: 5.0.h),
                CustomTextField(
                  hintText: "user@gmail.com",
                  controller: null,
                ),
                divider,
                CustomButton(
                  bgColor: LightThemeColors.primaryColor,
                  ontap: () => Get.toNamed(Routes.CUSTOMER_CREATE_PASSWORD),
                  widget: Text(
                    "Send Instruction",
                    style: kTitleTextstyle,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

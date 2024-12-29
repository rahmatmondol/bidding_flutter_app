import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:dirham_uae/app/components/custom_pass_field.dart';
import 'package:dirham_uae/config/theme/my_styles.dart';
import 'package:dirham_uae/utils/global_variable/my_scaffold_background.dart';
import '../../../../../config/theme/light_theme_colors.dart';
import '../../../../../utils/global_variable/divider.dart';
import '../../../../components/custom_button.dart';
import '../../../../routes/app_pages.dart';
import '../controllers/customer_create_password_controller.dart';

class CustomerCreatePasswordView
    extends GetView<CustomerCreatePasswordController> {
  const CustomerCreatePasswordView({Key? key}) : super(key: key);
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                divider,
                divider,
                //********Titile is here***** */
                Center(
                  child: Text(
                    "Create Password",
                    style: kHeadingTextStyle,
                  ),
                ),
                gapHeight(size: 5.0.h),
                Center(
                  child: Text(
                    "Your new password must be different\n from previous used passwords",
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: kSubtitleStyle,
                  ),
                ),
                divider,
                divider,
                divider,
                Text(
                  "Password",
                  style: kTitleTextstyle,
                ),
                gapHeight(size: 5.0.h),
                CustomPassField(
                  hintText: "Password",
                  controller: null,
                ),
                divider,
                //***********TextField************ */
                Text(
                  "Confirmation Password",
                  style: kTitleTextstyle,
                ),
                gapHeight(size: 5.0.h),
                CustomPassField(
                  hintText: "Confirmation Password",
                  controller: null,
                ),
                divider,
                divider,
                CustomButton(
                  bgColor: LightThemeColors.primaryColor,
                  ontap: () => Get.toNamed(Routes.CUSTOMER_OTP),
                  widget: Text(
                    "Reset Password",
                    style: kTitleTextstyle,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

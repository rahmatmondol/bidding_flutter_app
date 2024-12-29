import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:dirham_uae/app/components/custom_button.dart';
import 'package:dirham_uae/app/components/custom_snackbar.dart';
import 'package:dirham_uae/app/components/custom_text_field.dart';
import 'package:dirham_uae/config/theme/light_theme_colors.dart';
import 'package:dirham_uae/config/theme/my_styles.dart';
import '../controllers/customer_change_password_controller.dart';

class CustomerChangePasswordView extends GetView<CustomerChangePasswordController> {
  const CustomerChangePasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                'Change Password',
                style: kTitleTextstyle.copyWith(
                    fontWeight: FontWeight.bold, fontSize: 16.sp),
              ),
            ),
            gapHeight(size: 20),
            //******************************************* Personal Information *******************************/

            Text(
              "If you want to change your password, do it from here",
              style: kTitleTextstyle,
            ),

            gapHeight(size: 10),

            //*********************************** Current Password Section ********************************** */

            Text(
              "Current Password",
              style: kTitleTextstyle.copyWith(fontWeight: FontWeight.w500),
            ),
            gapHeight(size: 5),
            CustomTextField(
              hintText: "******",
              controller: controller.oldPassController,
            ),
            gapHeight(size: 30),

            //*********************************** Password Section ********************************** */

            Text(
              "New Password",
              style: kTitleTextstyle.copyWith(fontWeight: FontWeight.w500),
            ),
            gapHeight(size: 5),
            CustomTextField(
              hintText: "******",
              controller: controller.newPassController,
            ),
            gapHeight(size: 10),

            //*********************************** Password Section ********************************** */

            Text(
              "Confirm password",
              style: kTitleTextstyle.copyWith(fontWeight: FontWeight.w500),
            ),
            gapHeight(size: 5),
            CustomTextField(
              hintText: "******",
              controller: controller.confirmPassController,
            ),
            gapHeight(size: 20),

            //*********************************** Change pass Section ********************************** */

            Spacer(),

            CustomButton(
              bgColor: LightThemeColors.primaryColor,
              ontap: () {
                if (controller.newPassController.text ==
                    controller.confirmPassController.text) {
                  controller.changedPassword(context);
                } else {
                  CustomSnackBar.showCustomToast(
                    message: "New Password and Confirm Password Don't Match",
                    color: LightThemeColors.redColor,
                  );
                }
              },
              widget: Text(
                "Confirm",
                style: kTitleTextstyle.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
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

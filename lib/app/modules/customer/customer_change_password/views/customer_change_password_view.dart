import 'package:dirham_uae/app/components/custom_button.dart';
import 'package:dirham_uae/app/components/custom_snackbar.dart';
import 'package:dirham_uae/app/components/custom_text_field.dart';
import 'package:dirham_uae/config/theme/light_theme_colors.dart';
import 'package:dirham_uae/config/theme/my_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../components/custom_appBar.dart';
import '../controllers/customer_change_password_controller.dart';

class CustomerChangePasswordView
    extends GetView<CustomerChangePasswordController> {
  const CustomerChangePasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(gradient: buildCustomGradient()),
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomHeaderBar(title: 'Change Password'),
                gapHeight(size: 20),

                Text(
                  "If you want to change your password, do it from here",
                  style: kTitleTextstyle,
                ),

                gapHeight(size: 20),

                // Current Password Section
                Text(
                  "Current Password",
                  style: kTitleTextstyle.copyWith(fontWeight: FontWeight.w500),
                ),
                gapHeight(size: 10),
                CustomTextField(
                  hintText: "******",
                  controller: controller.oldPassController,
                ),
                gapHeight(size: 20),

                // New Password Section
                Text(
                  "New Password",
                  style: kTitleTextstyle.copyWith(fontWeight: FontWeight.w500),
                ),
                gapHeight(size: 10),
                CustomTextField(
                  hintText: "******",
                  controller: controller.newPassController,
                ),
                gapHeight(size: 20),

                // Confirm Password Section
                Text(
                  "Confirm password",
                  style: kTitleTextstyle.copyWith(fontWeight: FontWeight.w500),
                ),
                gapHeight(size: 10),
                CustomTextField(
                  hintText: "******",
                  controller: controller.confirmPassController,
                ),

                // Button Section
                SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                CustomButton(
                  bgColor: LightThemeColors.primaryColor,
                  ontap: () {
                    if (controller.newPassController.text ==
                        controller.confirmPassController.text) {
                      controller.changedPassword(context);
                    } else {
                      CustomSnackBar.showCustomToast(
                        message:
                            "New Password and Confirm Password Don't Match",
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
        ),
      ),
    );
  }
}

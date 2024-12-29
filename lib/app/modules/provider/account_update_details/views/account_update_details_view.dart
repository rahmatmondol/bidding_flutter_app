// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:dirham_uae/app/components/custom_button.dart';
import 'package:dirham_uae/app/components/custom_text_field.dart';
import 'package:dirham_uae/app/modules/provider/account_details/controllers/account_details_controller.dart';
import 'package:dirham_uae/app/routes/app_pages.dart';
import 'package:dirham_uae/config/theme/light_theme_colors.dart';
import 'package:dirham_uae/config/theme/my_styles.dart';
import '../controllers/account_update_details_controller.dart';

class AccountUpdateDetailsView extends GetView<AccountUpdateDetailsController> {
  const AccountUpdateDetailsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    AccountDetailsController providerInfo = Get.put(AccountDetailsController());

    return Scaffold(
      body: Container(
        height: MediaQuery.sizeOf(context).height,
        padding: EdgeInsets.only(
          top: MediaQuery.paddingOf(context).top + 20.r,
          left: 15.r,
          right: 15.r,
        ),
        decoration: BoxDecoration(gradient: buildCustomGradient()),
        child: Obx(
          () => SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'Account Details',
                    style: kTitleTextstyle.copyWith(
                        fontWeight: FontWeight.bold, fontSize: 16.sp),
                  ),
                ),
                gapHeight(size: 20),

                // ***************** Profile Image view ****************

                gapHeight(size: 30),
                Text(
                  "Full Name",
                  style: kSubtitleStyle.copyWith(fontWeight: FontWeight.bold),
                ),
                gapHeight(size: 5),
                CustomTextField(
                  hintText: "Enter Your Full Name",
                  controller: controller.providerNameController.value,
                ),
                gapHeight(size: 10),
                Text(
                  "Email",
                  style: kSubtitleStyle.copyWith(fontWeight: FontWeight.bold),
                ),
                gapHeight(size: 5),
                CustomTextField(
                  hintText: "Enter Your Email",
                  controller: controller.providerEmailController.value,
                ),
                gapHeight(size: 10),
                Text(
                  "Phone Number",
                  style: kSubtitleStyle.copyWith(fontWeight: FontWeight.bold),
                ),
                gapHeight(size: 5),
                CustomTextField(
                  hintText: "+971",
                  controller: controller.providerPhoneController.value,
                ),
                gapHeight(size: 10),
                Text(
                  "Bio",
                  style: kSubtitleStyle.copyWith(fontWeight: FontWeight.bold),
                ),
                gapHeight(size: 5),
                SizedBox(
                  height: 200,
                  child: CustomTextField(
                    hintText: "Type here...",
                    controller: controller.providerBioController.value,
                  ),
                ),
                gapHeight(size: 20),
                CustomButton(
                  bgColor: LightThemeColors.secounderyColor,
                  ontap: () {
                    Get.toNamed(Routes.CHANGE_PASSWORD);
                  },
                  widget: Row(
                    children: [
                      Text(
                        "Change Password",
                        style: kSubtitleStyle.copyWith(
                          color: LightThemeColors.secounderyTextColor,
                        ),
                      ),
                      Spacer(),
                      Icon(
                        Icons.arrow_right,
                        color: LightThemeColors.whiteColor,
                      )
                    ],
                  ),
                ),
                gapHeight(size: 20),
                CustomButton(
                    bgColor: LightThemeColors.primaryColor,
                    ontap: () {
                      controller.providerUpdateProfile();
                    },
                    widget: Text("Save")),
                gapHeight(size: 20)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

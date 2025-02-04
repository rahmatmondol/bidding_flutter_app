import 'dart:ui';

import 'package:dirham_uae/app/components/profile_card.dart';
import 'package:dirham_uae/app/components/small_custom_button.dart';
import 'package:dirham_uae/config/theme/light_theme_colors.dart';
import 'package:dirham_uae/config/theme/my_images.dart';
import 'package:dirham_uae/config/theme/my_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../routes/app_pages.dart';
import '../../account_details/controllers/account_details_controller.dart';
import '../controllers/profile_data_controller.dart';

class CustomerProfileView extends GetView<CustomerProfileController> {
  const CustomerProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CustomerProfileController customerProfileController =
        Get.put(CustomerProfileController());
    final CustomerAccountDetailsController customerAccountDetailsController =
        Get.put(CustomerAccountDetailsController());

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        padding: EdgeInsets.only(
          top: MediaQuery.paddingOf(context).top + 20.r,
          left: 15.r,
          right: 15.r,
        ),
        decoration: BoxDecoration(gradient: buildCustomGradient()),
        child: RefreshIndicator(
          onRefresh: () => customerAccountDetailsController.getCustomerInfo(),
          child: Obx(() {
            if (customerAccountDetailsController.isCustomerInfoloading.value) {
              return const Center(child: CircularProgressIndicator());
            }
            final customerInfo =
                customerAccountDetailsController.customerInfo.value;

            return Column(
              children: [
                Center(
                  child: Text(
                    'Profile',
                    style: kTitleTextstyle.copyWith(
                        fontWeight: FontWeight.bold, fontSize: 16.sp),
                  ),
                ),
                gapHeight(size: 20),

                // Profile Image
                CircleAvatar(
                  radius: 60.r,
                  backgroundImage:
                      _getProfileImage(customerInfo?.profile?.image),
                  backgroundColor: LightThemeColors.secounderyColor,
                  child: _shouldShowDefaultIcon(customerInfo?.profile?.image)
                      ? Icon(
                          Icons.person,
                          size: 60.r,
                          color: LightThemeColors.whiteColor,
                        )
                      : null,
                ),

                gapHeight(size: 10),
                Text(
                  customerInfo?.name ?? 'User',
                  style: kTitleTextstyle.copyWith(fontWeight: FontWeight.bold),
                ),

                gapHeight(size: 30),

                // Profile Options
                _buildProfileOptions(),
              ],
            );
          }),
        ),
      ),
    );
  }

  ImageProvider _getProfileImage(String? imageUrl) {
    if (imageUrl != null && imageUrl.isNotEmpty) {
      return NetworkImage(imageUrl);
    }
    return const AssetImage('assets/images/profile.jpg');
  }

  bool _shouldShowDefaultIcon(String? imageUrl) {
    return imageUrl == null || imageUrl.isEmpty;
  }

  Widget _buildProfileOptions() {
    return Column(
      children: [
        ProfileCard(
          iconName: Img.personIcon,
          name: "Account Details",
          ontap: () => Get.toNamed(Routes.CUSTOMER_ACCOUNT_DETAILS),
        ),
        gapHeight(size: 30),
        ProfileCard(
          iconName: Img.notificationIcon,
          name: "Notification",
          ontap: () {
            Get.toNamed(Routes.CUSTOMER_NOTIFICATION);
          },
        ),
        gapHeight(size: 30),
        ProfileCard(
          iconName: Img.languageIcon,
          name: "Language",
          ontap: () {
            Get.toNamed(Routes.LANGUAGE);
          },
        ),
        gapHeight(size: 30),
        ProfileCard(
          iconName: Img.aboutIcon,
          name: "About Us",
          ontap: () {
            Get.toNamed(Routes.ABOUT_US);
          },
        ),
        gapHeight(size: 30),
        Obx(() {
          if (controller.isProvider.value) {
            return Column(
              children: [
                ProfileCard(
                  iconName: Img.proposalIcon,
                  name: "My proposals",
                  ontap: () {
                    Get.toNamed(Routes.PROPOSALS);
                  },
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        }),
        gapHeight(size: 30),
        ProfileCard(
          iconName: Img.termsIcon,
          name: "Terms & Condition ",
          ontap: () {
            Get.toNamed(Routes.CUSTOMER_TERMS_AND_CONDITION);
          },
        ),
        gapHeight(size: 30),
        ProfileCard(
          iconName: Img.privacyIcon,
          name: "Privacy and policy",
          ontap: () {
            Get.toNamed(Routes.CUSTOMER_PRIVACY_AND_POLICY);
          },
        ),
        gapHeight(size: 30),
        ProfileCard(
          iconName: Img.logeoutIcon,
          name: "Logout",
          ontap: () => _showLogoutDialog(),
        ),
      ],
    );
  }

  void _showLogoutDialog() {
    Get.dialog(
      BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
        child: AlertDialog(
          backgroundColor: LightThemeColors.secounderyColor,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              gapHeight(size: 15),
              Row(
                children: [
                  Image.asset(
                    Img.deleteIcon,
                    scale: 1.r,
                  ),
                  gapWidth(size: 10),
                  Expanded(
                    child: Text(
                      "Are you Sure to logout your account?",
                      textAlign: TextAlign.start,
                      style: kTitleTextstyle.copyWith(
                        color: LightThemeColors.redColor,
                        fontSize: 17.0.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              gapHeight(size: 30),
              Row(
                children: [
                  Expanded(
                    child: SmallCustomButton(
                      border: Border.all(color: LightThemeColors.whiteColor),
                      color: LightThemeColors.secounderyColor,
                      widget: Text(
                        "No",
                        style: kSubtitleStyle.copyWith(
                            color: LightThemeColors.whiteColor),
                      ),
                      ontap: () => Get.back(),
                    ),
                  ),
                  gapWidth(size: 5),
                  Expanded(
                    child: SmallCustomButton(
                      color: LightThemeColors.primaryColor,
                      widget: Text(
                        "Yes",
                        style: kSubtitleStyle.copyWith(
                            color: LightThemeColors.whiteColor),
                      ),
                      ontap: () => controller.customerLogout(),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:dirham_uae/app/components/custom_button.dart';
import 'package:dirham_uae/app/components/custom_text_field.dart';
import 'package:dirham_uae/app/routes/app_pages.dart';
import 'package:dirham_uae/config/theme/light_theme_colors.dart';
import 'package:dirham_uae/config/theme/my_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../components/custom_appBar.dart';
import '../../../../../components/custom_snackbar.dart';
import '../../account_details/controllers/account_details_controller.dart';
import '../components/show_bottom_sheet.dart';
import '../controllers/update_profile_details_controller.dart';

class CustomerUpdateDetailsView
    extends GetView<CustomerUpdateDetailsController> {
  const CustomerUpdateDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.sizeOf(context).height,
        padding: EdgeInsets.only(
          top: 0,
          left: 15.r,
          right: 15.r,
        ),
        decoration: BoxDecoration(
          gradient: buildCustomGradient(),
        ),
        child: Obx(() => _buildContent(context)),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    final customerInfo =
        Get.find<CustomerAccountDetailsController>().customerInfo.value;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          CustomHeaderBar(title: 'Update Profile'),
          gapHeight(size: 20),

          // Profile Image Section
          _buildProfileImageSection(context, customerInfo?.profile?.image),
          gapHeight(size: 30),

          // Form Fields
          _buildFormFields(),
          gapHeight(size: 20),

          // Change Password Button
          _buildChangePasswordButton(),
          gapHeight(size: 40.h),

          // Save Button
          _buildSaveButton(context),
          gapHeight(size: 20),
        ],
      ),
    );
  }

  Widget _buildProfileImageSection(
      BuildContext context, String? currentImageUrl) {
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: 60.r,
            backgroundImage: controller.imageFile != null
                ? FileImage(controller.imageFile!)
                : (currentImageUrl != null && currentImageUrl.isNotEmpty
                        ? NetworkImage(currentImageUrl)
                        : const AssetImage('assets/images/profile.jpg'))
                    as ImageProvider,
            backgroundColor: LightThemeColors.secounderyColor,
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                color: LightThemeColors.primaryColor,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                onPressed: () => showMyBottomSheet(
                  context: context,
                  controller: controller,
                ),
                icon: Icon(
                  Icons.camera_alt,
                  color: LightThemeColors.whiteColor,
                  size: 20.r,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Full Name Field
        _buildFormField(
          label: "Full Name",
          hintText: "Enter Your Name",
          controller: controller.nameController.value,
        ),
        gapHeight(size: 15),

        // Phone Number Field
        _buildFormField(
          label: "Little Bio",
          hintText: "Write something",
          controller: controller.bioController.value,
          keyboardType: TextInputType.text,
          maxLines: 3,
        ),
        gapHeight(size: 15),
        // Phone Number Field
        _buildFormField(
          label: "Phone Number",
          hintText: "+971",
          controller: controller.phoneController.value,
          keyboardType: TextInputType.phone,
        ),

        gapHeight(size: 15),

        // Email Field
        _buildFormField(
          label: "Email",
          hintText: "Enter Your Email",
          controller: controller.emailController.value,
          keyboardType: TextInputType.emailAddress,
        ),
      ],
    );
  }

  Widget _buildFormField({
    required String label,
    required String hintText,
    required TextEditingController controller,
    TextInputType? keyboardType,
    int? maxLines, // Add this parameter
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: kSubtitleStyle.copyWith(fontWeight: FontWeight.bold),
        ),
        gapHeight(size: 5),
        CustomTextField(
          hintText: hintText,
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines ?? 1, // Use the parameter
        ),
      ],
    );
  }

  Widget _buildChangePasswordButton() {
    return CustomButton(
      bgColor: LightThemeColors.secounderyColor,
      ontap: () => Get.toNamed(Routes.CUSTOMER_CHANGE_PASSWORD),
      widget: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Change Password",
            style: kSubtitleStyle.copyWith(
              color: LightThemeColors.secounderyTextColor,
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: LightThemeColors.whiteColor,
            size: 16.r,
          ),
        ],
      ),
    );
  }

  Widget _buildSaveButton(BuildContext context) {
    return Obx(() => CustomButton(
          bgColor: LightThemeColors.primaryColor,
          ontap: () {
            if (!controller.isCustomerUpdateLoading.value) {
              _handleSave(context);
            }
          },
          widget: controller.isCustomerUpdateLoading.value
              ? SizedBox(
                  height: 20.r,
                  width: 20.r,
                  child: CircularProgressIndicator(
                    color: LightThemeColors.whiteColor,
                    strokeWidth: 2,
                  ),
                )
              : Text(
                  "Save Changes",
                  style: kTitleTextstyle.copyWith(
                    color: LightThemeColors.whiteColor,
                  ),
                ),
        ));
  }

  void _handleSave(BuildContext context) {
    // Basic validation
    if (controller.bioController.value.text.trim().length > 500) {
      // example length
      CustomSnackBar.showCustomErrorToast(
          message: "Bio is too long. Maximum 500 characters allowed");
      return;
    }

    if (controller.nameController.value.text.trim().isEmpty) {
      CustomSnackBar.showCustomErrorToast(message: "Name is required");
      return;
    }

    if (controller.emailController.value.text.trim().isEmpty ||
        !GetUtils.isEmail(controller.emailController.value.text.trim())) {
      CustomSnackBar.showCustomErrorToast(message: "Valid email is required");
      return;
    }

    if (controller.phoneController.value.text.trim().isEmpty) {
      CustomSnackBar.showCustomErrorToast(message: "Phone number is required");
      return;
    }

    // If validation passes, proceed with update
    controller.customerUpdateProfile(context);
  }
}

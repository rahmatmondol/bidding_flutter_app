import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:dirham_uae/app/components/custom_button.dart';
import 'package:dirham_uae/app/components/custom_text_field.dart';
import 'package:dirham_uae/app/modules/customer/customer_account_details/controllers/customer_account_details_controller.dart';
import 'package:dirham_uae/app/modules/customer/customer_update_details/components/show_bottom_sheet.dart';
import 'package:dirham_uae/app/routes/app_pages.dart';
import 'package:dirham_uae/config/theme/light_theme_colors.dart';
import 'package:dirham_uae/config/theme/my_styles.dart';
import '../controllers/customer_update_details_controller.dart';

class CustomerUpdateDetailsView
    extends GetView<CustomerUpdateDetailsController> {
  const CustomerUpdateDetailsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    CustomerAccountDetailsController accountDetailsAccount =
        Get.put(CustomerAccountDetailsController());
    return Scaffold(
      body: Container(
        height: MediaQuery.sizeOf(context).height,
        padding: EdgeInsets.only(
          top: MediaQuery.paddingOf(context).top + 20.r,
          left: 15.r,
          right: 15.r,
        ),
        decoration: BoxDecoration(
          gradient: buildCustomGradient(),
        ),
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
                Center(
                    child: controller.imageFile != null
                        ? CircleAvatar(
                            radius: 60.r,
                            backgroundImage: FileImage(
                              controller.imageFile!,
                            ),
                            child: Center(
                              child: IconButton(
                                onPressed: () {
                                  showMyBottomSheet(
                                      context: context, controller: controller);
                                },
                                icon: Icon(
                                  Icons.add_a_photo,
                                  color: LightThemeColors.whiteColor,
                                ),
                              ),
                            ),
                          )
                        : CircleAvatar(
                            radius: 60.r,
                            backgroundImage: NetworkImage(accountDetailsAccount
                                .getCutomerInfoModel.value.data!.info!.image
                                .toString()),
                            child: Center(
                              child: IconButton(
                                onPressed: () {
                                  showMyBottomSheet(
                                      context: context, controller: controller);
                                },
                                icon: Icon(
                                  Icons.add_a_photo,
                                  color: LightThemeColors.whiteColor,
                                ),
                              ),
                            ),
                          )),

                gapHeight(size: 30),
                Text(
                  "Full Name",
                  style: kSubtitleStyle.copyWith(fontWeight: FontWeight.bold),
                ),
                gapHeight(size: 5),
                CustomTextField(
                  hintText: "Enter Your Name",
                  controller: controller.nameController.value,
                ),
                // gapHeight(size: 10),
                // Text(
                //   "Last Name",
                //   style: kSubtitleStyle.copyWith(fontWeight: FontWeight.bold),
                // ),
                // gapHeight(size: 5),
                // CustomTextField(
                //   hintText: "Enter Your Last Name",
                //   controller: null,
                // ),
                gapHeight(size: 10),
                Text(
                  "Email",
                  style: kSubtitleStyle.copyWith(fontWeight: FontWeight.bold),
                ),
                gapHeight(size: 5),
                CustomTextField(
                  hintText: "Enter Your Email",
                  controller: controller.emailController.value,
                ),
                gapHeight(size: 10),
                Text(
                  "Phone Number",
                  style: kSubtitleStyle.copyWith(fontWeight: FontWeight.bold),
                ),
                gapHeight(size: 5),
                CustomTextField(
                  hintText: "+971",
                  controller: controller.phoneController.value,
                ),
                gapHeight(size: 20),
                // Text(
                //   "Bio",
                //   style: kSubtitleStyle.copyWith(fontWeight: FontWeight.bold),
                // ),
                // gapHeight(size: 5),
                // SizedBox(
                //   height: 200,
                //   child: CustomTextField(
                //     hintText: "Type here...",
                //     controller: controller.bioController.value,
                //   ),
                // ),

                // gapHeight(size: 20),

                CustomButton(
                  bgColor: LightThemeColors.secounderyColor,
                  ontap: () {
                    Get.toNamed(Routes.CUSTOMER_CHANGE_PASSWORD);
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
                gapHeight(size: 135.h),

                CustomButton(
                  bgColor: LightThemeColors.primaryColor,
                  ontap: () {
                    controller.customerUpdateProfile(context);
                  },
                  widget: Text("Save"),
                ),
                gapHeight(size: 20)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

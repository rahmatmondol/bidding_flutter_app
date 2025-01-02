import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:dirham_uae/app/components/custom_button.dart';
import 'package:dirham_uae/app/components/custom_pass_field.dart';
import 'package:dirham_uae/app/components/custom_snackbar.dart';
import 'package:dirham_uae/app/components/custom_text_field.dart';
import 'package:dirham_uae/config/theme/light_theme_colors.dart';
import 'package:dirham_uae/config/theme/my_images.dart';
import 'package:dirham_uae/config/theme/my_styles.dart';
import '../../../../../utils/global_variable/divider.dart';
import '../controllers/provider_tab_controller.dart';

class ProviderTabView extends GetView<ProviderTabController> {
  const ProviderTabView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    ProviderTabController controller = Get.put(ProviderTabController());
    // Choose Zone
    final zone = (controller.getZoneIDModel.value.data?.zones ?? [])
        .firstWhereOrNull((element) => element.id == element.id);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff4C5B7D),
              Color(0xff303030),
              Color(0xff5A5D63),
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          child: Obx(
            () => Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  divider,
                  Center(
                    child: Container(
                      height: Get.height / 20,
                      width: Get.width / 1.5,
                      decoration: BoxDecoration(
                        color: LightThemeColors.secounderyColor,
                        borderRadius: BorderRadius.circular(10.0.r),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            Img.providerIcon,
                            scale: 5,
                          ),
                          gapWidth(size: 8.0.w),
                          Text(
                            "Personal Information",
                            style: kTitleTextstyle,
                          ),
                        ],
                      ),
                    ),
                  ),

                  // ***********Textfield**************
                  Text(
                    "Name",
                    style: kTitleTextstyle,
                  ),
                  gapHeight(size: 5),
                  CustomTextField(
                    fillColor: Colors.white,
                    hintText: "Enter your name",
                    controller: controller.nameController.value,
                  ),
                  gapHeight(size: 10.0.h),
                  //***********Textfield**************
                  Text(
                    "Email",
                    style: kTitleTextstyle,
                  ),
                  gapHeight(size: 5),
                  CustomTextField(
                    fillColor: Colors.white,
                    hintText: "Enter your email",
                    controller: controller.emailController.value,
                  ),
                  divider,
                  //***************** */

                  Text(
                    "Country",
                    style: kTitleTextstyle,
                  ),
                  gapHeight(size: 5),

                  CountryListPick(
                    theme: CountryTheme(
                      isShowFlag: true,
                      isShowTitle: true,
                      isShowCode: true,
                      isDownIcon: true,
                      showEnglishName: false,
                      labelColor: Colors.white,
                    ),
                    appBar: AppBar(
                      title: Text('Select a Country'),
                    ),

                    //  useSafeArea: true,
                    onChanged: (country) {
                      controller.selectedCountry = country;
                      print("Show :: ${controller.selectedCountry!.name} ");
                    },
                  ),

                  // *************seleced zone******************

                  Text(
                    "Zone",
                    style: kTitleTextstyle,
                  ),
                  gapHeight(size: 5),
                  // ********Drop down zone id***********
                  // Container(
                  //   padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  //   decoration: BoxDecoration(
                  //     color: LightThemeColors.secounderyColor,
                  //     borderRadius: BorderRadius.circular(8.r),
                  //   ),
                  //   child: CustomDropdown(
                  //     hintText:
                  //         'Select County', // Displayed when no option is selected
                  //     items: controller.zoneIds.isNotEmpty
                  //         ? controller.zoneIds
                  //         : [],
                  //     value: controller.selectedZoon,
                  //     onChanged: (newValue) {
                  //       controller.selectedZoon.value = newValue.toString();
                  //     },
                  //   ),
                  // ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: LightThemeColors.secounderyColor,
                      borderRadius: BorderRadius.circular(8.r),
                      boxShadow: [
                        BoxShadow(
                          color: LightThemeColors.shadowColor,
                          offset: Offset(1, 1),
                          blurRadius: 5,
                        )
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.0),
                      child: Center(
                        child: DropdownButton(
                            dropdownColor:
                                LightThemeColors.primaryColor.withOpacity(.5),
                            alignment: Alignment.centerLeft,
                            value: controller.zoneIds.value.isEmpty
                                ? null
                                : controller.zoneIds.value,
                            isExpanded: true,
                            underline: SizedBox(),
                            hint: const Text("Choose Zone"),
                            items:
                                (controller.getZoneIDModel.value.data?.zones ??
                                        [])
                                    .map((mapValue) {
                              return DropdownMenuItem(
                                value: mapValue.name.toString(),
                                child: Text(
                                  mapValue.name.toString(),
                                  style: TextStyle(
                                      color: LightThemeColors.whiteColor),
                                ),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              final selectedZone = (controller
                                          .getZoneIDModel.value.data?.zones ??
                                      [])
                                  .firstWhere((zone) =>
                                      zone.name.toString() == newValue);

                              // Check if the selected zone is not null and has an ID
                              // ignore: unnecessary_null_comparison
                              if (selectedZone != null &&
                                  selectedZone.id != null) {
                                controller.zoneIds.value = newValue.toString();
                              }
                            }),
                      ),
                    ),
                  ),

                  gapHeight(size: 10.0.h),
                  //*********************************** Phone Number Section ********************************** */
                  Text("Phone Number",
                      style: kTitleTextstyle.copyWith(
                          fontWeight: FontWeight.w500)),
                  gapHeight(size: 5),
                  CustomTextField(
                    fillColor: Colors.white,
                    textInputType: TextInputType.number,
                    hintText: "+971",
                    controller: controller.phoneController.value,
                    isIcon: true,
                    icon: Img.uaeIcon,
                    prefixIconScale: 3,
                  ),
                  gapHeight(size: 20),
                  Center(
                    child: Container(
                      height: Get.height / 20,
                      width: Get.width / 1.5,
                      decoration: BoxDecoration(
                        color: LightThemeColors.secounderyColor,
                        borderRadius: BorderRadius.circular(10.0.r),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            Img.providerIcon,
                            scale: 5,
                          ),
                          gapWidth(size: 8.0.w),
                          Text(
                            "Account Information",
                            style: kTitleTextstyle,
                          ),
                        ],
                      ),
                    ),
                  ),
                  gapHeight(size: 15.0.h),
                  //************************* */
                  Text(
                    "Password",
                    style: kTitleTextstyle,
                  ),
                  gapHeight(size: 5.0.h),
                  CustomPassField(
                    fillColor: Colors.white,
                    hintText: "Password",
                    controller: controller.passController.value,
                  ),
                  gapHeight(size: 15.0.h),
                  Text(
                    "Confirm Password",
                    style: kTitleTextstyle,
                  ),
                  gapHeight(size: 5.0.h),
                  CustomPassField(
                    fillColor: Colors.white,
                    hintText: "Confiram Password",
                    controller: controller.confirmPassController.value,
                  ),

                  //********************* */
                  divider,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                    child: CustomButton(
                      bgColor: LightThemeColors.primaryColor,
                      ontap: () {
                        // Check if password and confirm password match

                        if (controller.passController.value.text ==
                            controller.confirmPassController.value.text) {
                          controller.signUpProvider(context, zone!.id!.toInt());
                        } else {
                          CustomSnackBar.showCustomToast(
                              message:
                                  "Password & Confirm Password do not match",
                              color: LightThemeColors.redColor);
                        }
                      },
                      widget: Text(
                        "Create Account",
                        style: kTitleTextstyle,
                      ),
                    ),
                  ),
                  divider,
                  divider,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

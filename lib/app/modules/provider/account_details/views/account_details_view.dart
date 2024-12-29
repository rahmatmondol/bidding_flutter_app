import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:dirham_uae/app/components/custom_button.dart';
import 'package:dirham_uae/app/routes/app_pages.dart';
import 'package:dirham_uae/config/theme/light_theme_colors.dart';
import 'package:dirham_uae/config/theme/my_images.dart';
import 'package:dirham_uae/config/theme/my_styles.dart';
import '../controllers/account_details_controller.dart';

class AccountDetailsView extends GetView<AccountDetailsController> {
  const AccountDetailsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // var data = controller.getProviderInfoModel.value.data!.provider!;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
          top: MediaQuery.paddingOf(context).top + 20.r,
          left: 15.r,
          right: 15.r,
        ),
        decoration: BoxDecoration(gradient: buildCustomGradient()),
        child: Obx(
          () => controller.isProviderInfoloading.value == true
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: [
                    Center(
                      child: Text(
                        'Account Details',
                        style: kTitleTextstyle.copyWith(
                            fontWeight: FontWeight.bold, fontSize: 16.sp),
                      ),
                    ),
                    gapHeight(size: 20),
                    // **********image **************
                    controller.getProviderInfoModel.value.data!.provider!.image!
                            .isEmpty
                        ? CircleAvatar(
                            radius: 60.r,
                            backgroundImage: AssetImage(Img.userIcon),
                          )
                        : CircleAvatar(
                            radius: 60.r,
                            backgroundImage: NetworkImage(controller
                                .getProviderInfoModel
                                .value
                                .data!
                                .provider!
                                .image!
                                .toString()),
                          ),
                    gapHeight(size: 30),
                    AccountDetailsCard(
                      title: "Full Name :",
                      subtitle:
                          "${controller.getProviderInfoModel.value.data!.provider!.name.toString()}",
                    ),
                    gapHeight(size: 20),
                    // AccountDetailsCard(
                    //   title: "Last Name :",
                    //   subtitle: " 0123",
                    // ),
                    // gapHeight(size: 20),
                    AccountDetailsCard(
                      title: "Email :",
                      subtitle: controller
                          .getProviderInfoModel.value.data!.provider!.email
                          .toString(),
                    ),
                    gapHeight(size: 20),
                    AccountDetailsCard(
                      title: "Number :",
                      subtitle: controller
                          .getProviderInfoModel.value.data!.provider!.phone
                          .toString(),
                    ),
                    gapHeight(size: 20),
                    AccountDetailsCard(
                        title: "Bio :",
                        subtitle: controller.getProviderInfoModel.value.data!
                                    .provider!.bio ==
                                null
                            ? "Please update your Bio"
                            : controller
                                .getProviderInfoModel.value.data!.provider!.bio
                                .toString()),
                    Spacer(),
                    CustomButton(
                      bgColor: LightThemeColors.primaryColor,
                      ontap: () {
                        Get.toNamed(Routes.ACCOUNT_UPDATE_DETAILS);
                      },
                      widget: Text(
                        "Update Information",
                        style: kTitleTextstyle,
                      ),
                    ),
                    gapHeight(size: 20)
                  ],
                ),
        ),
      ),
    );
  }
}

class AccountDetailsCard extends StatelessWidget {
  final String title;
  final String subtitle;
  const AccountDetailsCard({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Text(
                title,
                style: kSubtitleStyle,
              ),
            ),
            Expanded(
                flex: 2,
                child: Text(
                  subtitle,
                  style: kTitleTextstyle,
                ))
          ],
        ),
        Divider(color: LightThemeColors.dividerColor)
      ],
    );
  }
}

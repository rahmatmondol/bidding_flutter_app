import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProfileController controller = Get.put(ProfileController());

    // AccountDetailsController accountDetailsController =
    //     Get.put(AccountDetailsController());
    return Scaffold(
      resizeToAvoidBottomInset: true,
      // body: Container(
      //   padding: EdgeInsets.only(
      //     top: MediaQuery.paddingOf(context).top + 20.r,
      //     left: 15.r,
      //     right: 15.r,
      //   ),
      //   decoration: BoxDecoration(gradient: buildCustomGradient()),
      //   child: Obx(
      //     () => Column(
      //       children: [
      //         Center(
      //           child: Text(
      //             'Profile',
      //             style: kTitleTextstyle.copyWith(
      //                 fontWeight: FontWeight.bold, fontSize: 16.sp),
      //           ),
      //         ),
      //         gapHeight(size: 20),
      //
      //         // *********Profile pic*************
      //
      //         accountDetailsController.getProviderInfoModel.value.data?.provider
      //                     ?.image?.isEmpty ??
      //                 true
      //             ? CircleAvatar(
      //                 radius: 60.r,
      //                 backgroundImage: AssetImage(Img.userIcon),
      //               )
      //             : CircleAvatar(
      //                 radius: 60.r,
      //                 backgroundImage: NetworkImage(accountDetailsController
      //                     .getProviderInfoModel.value.data!.provider!.image!
      //                     .toString()),
      //               ),
      //
      //         // CircleAvatar(
      //         //   radius: 60.r,
      //         //   backgroundImage: providerInfo!.image!.isNotEmpty == true
      //         //       ? NetworkImage(providerInfo.image.toString())
      //         //       : AssetImage(Images.userIcon),
      //         // ),
      //
      //         gapHeight(size: 10),
      //         Text(
      //           accountDetailsController
      //                   .getProviderInfoModel.value.data?.provider!.name
      //                   .toString() ??
      //               "user",
      //           style: kTitleTextstyle.copyWith(fontWeight: FontWeight.bold),
      //         ),
      //         gapHeight(size: 30),
      //         ProfileCard(
      //           iconName: Img.personIcon,
      //           name: "Account Details",
      //           ontap: () {
      //             Get.toNamed(Routes.ACCOUNT_DETAILS);
      //           },
      //         ),
      //         gapHeight(size: 30),
      //         ProfileCard(
      //           iconName: Img.languageIcon,
      //           name: "Language",
      //           ontap: () {
      //             Get.toNamed(Routes.LANGUAGE);
      //           },
      //         ),
      //         gapHeight(size: 30),
      //         ProfileCard(
      //           iconName: Img.aboutIcon,
      //           name: "About Us",
      //           ontap: () {
      //             Get.toNamed(Routes.ABOUT_US);
      //           },
      //         ),
      //         gapHeight(size: 30),
      //         ProfileCard(
      //           iconName: Img.proposalIcon,
      //           name: "My proposalss",
      //           ontap: () {
      //             Get.toNamed(Routes.PROPOSALS);
      //           },
      //         ),
      //         gapHeight(size: 30),
      //         ProfileCard(
      //           iconName: Img.termsIcon,
      //           name: "Terms & Condition ",
      //           ontap: () {
      //             // Get.toNamed(Routes.TERMS_AND_CONDITION);
      //           },
      //         ),
      //         gapHeight(size: 30),
      //         ProfileCard(
      //           iconName: Img.privacyIcon,
      //           name: "Privacy and policy",
      //           ontap: () {
      //             Get.toNamed(Routes.PRIVACY_AND_POLICY);
      //           },
      //         ),
      //         gapHeight(size: 30),
      //         ProfileCard(
      //           iconName: Img.logeoutIcon,
      //           name: "Logout",
      //           ontap: () {
      //             showDialog(
      //               context: context,
      //               builder: (c) {
      //                 return BackdropFilter(
      //                   filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
      //                   child: AlertDialog(
      //                     backgroundColor: LightThemeColors.secounderyColor,
      //                     key: key,
      //                     content: Column(
      //                       mainAxisSize: MainAxisSize.min,
      //                       children: [
      //                         gapHeight(size: 15),
      //                         Row(
      //                           children: [
      //                             Image.asset(
      //                               Img.deleteIcon,
      //                               scale: 1.r,
      //                             ),
      //                             gapWidth(size: 10),
      //                             Expanded(
      //                               child: Text(
      //                                 "Are you Sure to logeOut your account?",
      //                                 textAlign: TextAlign.start,
      //                                 style: kTitleTextstyle.copyWith(
      //                                   color: LightThemeColors.redColor,
      //                                   fontSize: 17.0.sp,
      //                                   fontWeight: FontWeight.bold,
      //                                 ),
      //                               ),
      //                             ),
      //                           ],
      //                         ),
      //                         gapHeight(size: 30),
      //                         Row(
      //                           children: [
      //                             Expanded(
      //                               child: SmallCustomButton(
      //                                 border: Border.all(
      //                                     color: LightThemeColors.whiteColor),
      //                                 color: LightThemeColors.secounderyColor,
      //                                 widget: Text(
      //                                   "No",
      //                                   style: kSubtitleStyle.copyWith(
      //                                       color: LightThemeColors.whiteColor),
      //                                 ),
      //                                 ontap: () {
      //                                   Get.back();
      //                                 },
      //                               ),
      //                             ),
      //                             gapWidth(size: 5),
      //                             Expanded(
      //                               child: SmallCustomButton(
      //                                 color: LightThemeColors.primaryColor,
      //                                 widget: Text(
      //                                   "Yes",
      //                                   style: kSubtitleStyle.copyWith(
      //                                       color: LightThemeColors.whiteColor),
      //                                 ),
      //                                 ontap: () {
      //                                   controller.providerLogout();
      //                                 },
      //                               ),
      //                             ),
      //                           ],
      //                         )
      //                       ],
      //                     ),
      //                   ),
      //                 );
      //               },
      //             );
      //           },
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:dirham_uae/app/components/custom_button.dart';
// import 'package:dirham_uae/app/routes/app_pages.dart';
// import 'package:dirham_uae/config/theme/light_theme_colors.dart';
// import 'package:dirham_uae/config/theme/my_images.dart';
// import 'package:dirham_uae/config/theme/my_styles.dart';
// import '../controllers/location_controller.dart';

// class LocationView extends GetView<LocationController> {
//   const LocationView({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: LightThemeColors.scaffoldBackgroundColor,
//       body: SafeArea(
//         child: Container(
//           padding: EdgeInsets.all(20.r),
//           decoration: BoxDecoration(gradient: buildCustomGradient()),
//           child: Column(
//             children: [
//               Text(
//                 "Location",
//                 style: kTitleTextstyle.copyWith(
//                     fontWeight: FontWeight.bold, fontSize: 16.sp),
//               ),
//               Spacer(),
//               Image.asset(
//                 Images.mapImg,
//                 height: 150.h,
//               ),
//               gapHeight(size: 10),
//               Text(
//                 'Allow your Location',
//                 style: kTitleTextstyle.copyWith(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 16.sp,
//                 ),
//               ),
//               gapHeight(size: 5),
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 20),
//                 child: Text(
//                   "We Will need your location to give you better experience.",
//                   textAlign: TextAlign.center,
//                   style: kTitleTextstyle.copyWith(
//                     color: LightThemeColors.secounderyTextColor,
//                   ),
//                 ),
//               ),
//               Spacer(),

//               //*************************************** Button Section *************************** */
//               CustomButton(
//                 widget: Text("Use Current locatiion"),
//                 bgColor: LightThemeColors.primaryColor,
//                 ontap: () {},
//               ),
//               gapHeight(size: 10),
//               CustomButton(
//                 ontap: () {
//                   Get.toNamed(Routes.PICK_LOCATION);
//                 },
//                 widget: Text("Set From Map"),
//                 bgColor: LightThemeColors.secounderyButtonColor,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
  
//   }
// }

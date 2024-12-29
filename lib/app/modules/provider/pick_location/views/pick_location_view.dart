
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:dirham_uae/app/components/custom_button.dart';
// import 'package:dirham_uae/app/components/custom_drop_down_button.dart';
// import 'package:dirham_uae/app/routes/app_pages.dart';
// import 'package:dirham_uae/config/theme/light_theme_colors.dart';
// import 'package:dirham_uae/utils/global_variable/divider.dart';
// import 'package:dirham_uae/utils/global_variable/my_scaffold_background.dart';
// import '../controllers/pick_location_controller.dart';

// class PickLocationView extends GetView<PickLocationController> {
//   const PickLocationView({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.sizeOf(context);
//     return Scaffold(
//       body: MyScaffoldBackground(
//         size: size,
//         child: SafeArea(
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 15.0.w),
//             child: Column(
//               children: [
//                 divider,
//                 divider,
//                 Container(
//                   padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//                   decoration: BoxDecoration(
//                     color: LightThemeColors.secounderyColor,
//                     borderRadius: BorderRadius.circular(8.r),
//                   ),
//                   child: CustomDropdown(
//                     hintText: 'Select County',
//                     items: controller.location,
//                     value: controller.selectedZoon,
//                     onChanged: (newValue) {
//                       // controller.updateZoon(newValue!);
//                     },
//                   ),
//                 ),
//                 Spacer(),
//                 CustomButton(
//                   bgColor: LightThemeColors.primaryColor,
//                   ontap: () => Get.toNamed(Routes.LOGIN),
//                   widget: Text("Pick Location"),
//                 ),
//                 divider,
//                 divider,
                
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
  
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../config/theme/light_theme_colors.dart';
import '../../../../../config/theme/my_images.dart';
import '../../../../../config/theme/my_styles.dart';
import '../../../../components/custom_button.dart';
import '../../../../routes/app_pages.dart';
import '../../../global/customer_pick_location/controllers/customer_pick_location_controller.dart';

class CustomerLocationView extends GetView<CustomerPickLocationController> {
  CustomerLocationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CustomerPickLocationController>(
      init: CustomerPickLocationController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: LightThemeColors.scaffoldBackgroundColor,
          body: SafeArea(
            child: Container(
              padding: EdgeInsets.all(20.r),
              decoration: BoxDecoration(gradient: buildCustomGradient()),
              child: Column(
                children: [
                  Text(
                    "Location",
                    style: kTitleTextstyle.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                    ),
                  ),
                  Spacer(),
                  Image.asset(
                    Img.mapImg,
                    height: 150.h,
                  ),
                  gapHeight(size: 10),
                  Text(
                    'Allow your Location',
                    style: kTitleTextstyle.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                    ),
                  ),
                  gapHeight(size: 5),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "We will need your location to give you better experience.",
                      textAlign: TextAlign.center,
                      style: kTitleTextstyle.copyWith(
                        color: LightThemeColors.secounderyTextColor,
                      ),
                    ),
                  ),
                  Spacer(),
                  Obx(() => controller.isLoading.value
                      ? CircularProgressIndicator()
                      : Column(
                          children: [
                            CustomButton(
                              widget: Text("Use Current Location"),
                              bgColor: LightThemeColors.primaryColor,
                              ontap: () async {
                                await controller.getCurrentLocation();
                                Get.toNamed(Routes.CUSTOMER_NAV_BAR);

                                print(
                                    'Curent Location: ${controller.getCurrentLocation()}');
                              },
                            ),
                            gapHeight(size: 10),
                            CustomButton(
                              ontap: () {
                                Get.toNamed(Routes.CUSTOMER_PICK_LOCATION);
                              },
                              widget: Text("Set From Map"),
                              bgColor: LightThemeColors.secounderyButtonColor,
                            ),
                          ],
                        )),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

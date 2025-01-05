// ignore_for_file: unnecessary_null_comparison

import 'package:dirham_uae/app/components/popular_service_card.dart';
import 'package:dirham_uae/app/components/row_text.dart';
import 'package:dirham_uae/app/components/search_button.dart';
import 'package:dirham_uae/app/components/small_custom_button.dart';
import 'package:dirham_uae/app/modules/customer/customer_service_details/views/customer_service_details_view.dart';
import 'package:dirham_uae/app/routes/app_pages.dart';
import 'package:dirham_uae/config/theme/light_theme_colors.dart';
import 'package:dirham_uae/config/theme/my_images.dart';
import 'package:dirham_uae/config/theme/my_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/customer_home_controller.dart';
import '../widgets/carousol_slider.dart';

class CustomerHomeView extends GetView<CustomerHomeController> {
  CustomerHomeView({Key? key}) : super(key: key);
  final CustomerHomeController customerHomeController =
      Get.put(CustomerHomeController());

  @override
  Widget build(BuildContext context) {
    controller.getCustomeService();
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(gradient: buildCustomGradient()),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.r)
                      .copyWith(top: 30.r),
                  child: Column(
                    children: [
                      _buildHeaderRow(),
                      gapHeight(size: 20),
                      _buildSearchSection(),
                      gapHeight(size: 20),

// Banner Carousel Section
                      CarouselSlider(controller: controller),
                    ],
                  ),
                ),
                gapHeight(size: 20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.r),
                  child: RowText(
                    title: "My posted service",
                    buttonName: "",
                    ontap: () {},
                  ),
                ),
                gapHeight(size: 20),
                // Obx(
                //   () => SizedBox(
                //     // height: size.height * 0.2.h,
                //     child: ListView.builder(
                //         shrinkWrap: true,
                //         physics: NeverScrollableScrollPhysics(),
                //         itemCount: controller
                //             .getCustomerModel.value.data?.data?.length,
                //         itemBuilder: (context, index) {
                //           var customeData = controller
                //               .getCustomerModel.value.data?.data?[index];
                //
                //           return Container(
                //             margin: EdgeInsets.symmetric(horizontal: 16.r)
                //                 .copyWith(bottom: 10.r),
                //             height: size.height * 0.2.h,
                //             child: PopularServiceCard(
                //               size: size,
                //               name: customeData?.name.toString() ?? "",
                //               location: customeData?.address.toString() ?? "",
                //               description:
                //                   customeData?.description.toString() ?? "",
                //               priceLevel:
                //                   "${customeData?.priceType} Price- ${customeData?.level} level",
                //               price: "\$${customeData?.price}",
                //               onTap: () {
                //                 Get.toNamed(Routes.CUSTOMER_SERVICE_DETAILS);
                //               },
                //             ),
                //           );
                //         }),
                //   ),
                // ),
                SizedBox(
                  height: size.height * 0.2.h,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemCount:
                        controller.getCustomerModel.value.data?.data?.length,
                    itemBuilder: (context, index) {
                      final customeData =
                          controller.getCustomerModel.value.data?.data?[index];

                      if (customeData != null) {
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 16.r)
                              .copyWith(bottom: 10.r),
                          height: size.height * 0.2.h,
                          child: PopularServiceCard(
                            size: size,
                            name: customeData.name?.toString() ?? '',
                            location: customeData.address?.toString() ?? '',
                            priceLevel:
                                "${customeData.priceType} Price- ${customeData.level} level",
                            price:
                                "${customeData.price} ${customeData.currency!.toUpperCase()} ",
                            skill: customeData.skill?.toString() ?? '',
                            description: "",
                            onTap: () {
                              Get.to(
                                  CustomerServiceDetailsView(customeData.id));
                              print(customeData.id);
                            },
                          ),
                        );
                      } else {
                        // Handle error
                        return null; // or a different error handling widget
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row _buildSearchSection() {
    return Row(
      children: [
        Expanded(
          child: SearchButton(
            hintsText: "Search Your Service",
            ontap: () {
              Get.toNamed(Routes.CUSTOMER_SEARCH);
            },
          ),
        ),
        gapWidth(size: 10),
        // Container(
        //   padding: EdgeInsets.all(16.r),
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(8.r),
        //     gradient: LinearGradient(
        //       colors: [
        //         Color(0xff3BAAF3),
        //         Color(0xff2481F4),
        //       ],
        //       begin: Alignment.topLeft,
        //       end: Alignment.bottomRight,
        //     ),
        //   ),
        //   child: Image.asset(
        //     Images.filterIcon,
        //     scale: 1.5,
        //   ),
        // ),
      ],
    );
  }

  Row _buildHeaderRow() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Good Morning",
                style: kTitleTextstyle.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "User 1234",
                style: kSubtitleStyle,
              )
            ],
          ),
        ),
        SmallCustomButton(
          color: LightThemeColors.secounderyColor,
          ontap: () {
            Get.toNamed(Routes.CUSTOMER_PICK_LOCATION);
          },
          widget: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.r),
            child: Row(
              children: [
                Image.asset(Img.locationIcon),
                gapWidth(size: 4),
                Text(
                  "UAE, Dubai",
                  style: kSubtitleStyle,
                ),
                Icon(
                  Icons.arrow_drop_down,
                  color: LightThemeColors.whiteColor,
                )
              ],
            ),
          ),
        ),
        gapWidth(size: 5),
        SmallCustomButton(
            color: LightThemeColors.secounderyColor,
            ontap: () {
              Get.toNamed(Routes.CUSTOMER_NOTIFICATION);
            },
            widget: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Image.asset(Img.notificationIcon),
            ))
      ],
    );
  }
}

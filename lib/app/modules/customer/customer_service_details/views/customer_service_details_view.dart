import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dirham_uae/app/components/custom_button.dart';
import 'package:dirham_uae/app/modules/customer/customer_work_people_list/views/customer_work_people_list_view.dart';
import 'package:dirham_uae/config/theme/light_theme_colors.dart';
import 'package:dirham_uae/config/theme/my_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/customer_service_details_controller.dart';

class CustomerServiceDetailsView
    extends GetView<CustomerServiceDetailsController> {
  final int id;

  CustomerServiceDetailsView(this.id, {Key? key}) : super(key: key) {
    Get.put(CustomerServiceDetailsController(id));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final serviceData = controller.customerServiceDetailsModel.value.data;
        if (serviceData == null) {
          return Center(
            child: Text(
              'No data available',
              style: kTitleTextstyle.copyWith(fontSize: 16.sp),
            ),
          );
        }

        return Container(
          height: size.height,
          width: size.width,
          decoration: BoxDecoration(gradient: buildCustomGradient()),
          child: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image Slider Section
                  if (serviceData.images != null &&
                      serviceData.images!.isNotEmpty)
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 15.0.w),
                      child: CarouselSlider(
                        options: CarouselOptions(
                          height: 200.h,
                          viewportFraction: 1.0,
                          enlargeCenterPage: false,
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 3),
                        ),
                        items: serviceData.images!.map((image) {
                          return Builder(
                            builder: (BuildContext context) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(30.r),
                                child: Container(
                                  width: size.width,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                  ),
                                  child: CachedNetworkImage(
                                    imageUrl: image.path ?? '',
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => Center(
                                      child: CircularProgressIndicator(
                                        color: LightThemeColors.primaryColor,
                                      ),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Container(
                                      color: Colors.grey[300],
                                      child: Icon(
                                        Icons.error_outline,
                                        color: Colors.red,
                                        size: 32.sp,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        }).toList(),
                      ),
                    ),

                  gapHeight(size: 20.0.h),

                  // Title Section
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                    child: Text(
                      serviceData.title ?? 'No Title',
                      style: kTitleTextstyle.copyWith(fontSize: 16.sp),
                    ),
                  ),

                  gapHeight(size: 10),

                  // Location Section
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: LightThemeColors.whiteColor,
                          size: 15,
                        ),
                        gapWidth(size: 2.0.w),
                        Expanded(
                          child: Text(
                            serviceData.location ?? 'Location not available',
                            style: kSubtitleStyle,
                          ),
                        ),
                      ],
                    ),
                  ),

                  gapHeight(size: 10.0.h),
                  Divider(color: LightThemeColors.grayColor),

                  // Price Section
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${serviceData.priceType ?? 'N/A'} Price",
                            style: TextStyle(
                              color: LightThemeColors.whiteColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Text(
                          '${serviceData.price?.toStringAsFixed(2) ?? 'N/A'} ${serviceData.currency?.toUpperCase() ?? 'AED'}',
                          style: TextStyle(
                            color: LightThemeColors.whiteColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),

                  gapHeight(size: 20.0.h),

                  // Description Section
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      "Description",
                      style: TextStyle(
                        color: LightThemeColors.whiteColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  gapHeight(size: 10.0.h),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                    child: Text(
                      serviceData.description ?? 'No description available',
                      style: kSubtitleStyle,
                    ),
                  ),

                  gapHeight(size: 20),

                  // Skills Section
                  if (serviceData.skills != null &&
                      serviceData.skills!.isNotEmpty) ...[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                      child: Text(
                        "Skills and Expertise",
                        style: kTitleTextstyle.copyWith(fontSize: 16.0.sp),
                      ),
                    ),
                    gapHeight(size: 10.0.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                      child: Wrap(
                        spacing: 8.0,
                        runSpacing: 8.0,
                        children: serviceData.skills!.map((skill) {
                          return Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.0.w,
                              vertical: 6.0.h,
                            ),
                            decoration: BoxDecoration(
                              color: LightThemeColors.grayColor,
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Text(
                              skill,
                              style: TextStyle(
                                color: LightThemeColors.whiteColor,
                                fontSize: 12.sp,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ] else ...[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.0.w,
                          vertical: 6.0.h,
                        ),
                        decoration: BoxDecoration(
                          color: LightThemeColors.grayColor,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Text(
                          'Skill Not Found',
                          style: TextStyle(
                            color: LightThemeColors.whiteColor,
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                    ),
                  ],

                  gapHeight(size: 20),

                  // Action Button
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.r),
                    child: CustomButton(
                      bgColor: LightThemeColors.primaryColor,
                      ontap: () {
                        if (serviceData.id != null) {
                          Get.to(() =>
                              CustomerWorkPeopleListView(serviceData.id!));
                        } else {
                          Get.snackbar('Error', 'Invalid service ID');
                        }
                      },
                      widget: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.account_box,
                            color: LightThemeColors.whiteColor,
                          ),
                          gapWidth(size: 5),
                          Text(
                            "Willing to work",
                            style: kTitleTextstyle.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  gapHeight(size: 20),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

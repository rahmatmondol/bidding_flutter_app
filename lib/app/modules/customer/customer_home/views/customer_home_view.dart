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

import '../../customer_service_details/bindings/customer_service_details_binding.dart';
import '../controllers/customer_home_controller.dart';

class CustomerHomeView extends GetView<CustomerHomeController> {
  CustomerHomeView({Key? key}) : super(key: key);

  final CustomerHomeController customerHomeController =
      Get.put(CustomerHomeController());

  @override
  Widget build(BuildContext context) {
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
                Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  final services = controller.getCustomerModel.value.data;

                  if (services == null || services.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.all(16.r),
                        child: Text(
                          'No services found',
                          style: kSubtitleStyle,
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: services.length,
                    itemBuilder: (context, index) {
                      final serviceData = services[index];
                      print(
                          "Building item $index with id: ${serviceData.id}"); // Debug print

                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 16.r)
                            .copyWith(bottom: 10.r),
                        height: size.height * 0.24,
                        child: PopularServiceCard(
                          size: size,
                          name: serviceData.title ?? 'N/A',
                          location: serviceData.location ?? 'N/A',
                          description: serviceData.description ?? 'N/A',
                          priceLevel:
                              "${serviceData.priceType ?? 'Standard'} Price - ${serviceData.level ?? 'Basic'} level",
                          price:
                              "${serviceData.price.toStringAsFixed(2)} ${serviceData.currency?.toUpperCase() ?? 'AED'}",
                          skill: serviceData.skills?.join(", "),
                          onTap: () {
                            final id = serviceData.id;
                            if (id != null) {
                              Get.to(
                                () => CustomerServiceDetailsView(id),
                                binding: CustomerServiceDetailsBinding(id),
                                preventDuplicates: false,
                              );
                            } else {
                              Get.snackbar('Error', 'Invalid service ID');
                            }
                          },
                        ),
                      );
                    },
                  );
                }),
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
          ),
        )
      ],
    );
  }
}

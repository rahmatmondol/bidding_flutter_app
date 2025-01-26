// ignore_for_file: unnecessary_null_comparison

import 'package:dirham_uae/app/components/popular_service_card.dart';
import 'package:dirham_uae/app/components/row_text.dart';
import 'package:dirham_uae/app/components/small_custom_button.dart';
import 'package:dirham_uae/app/modules/customer/customer_service_details/views/customer_service_details_view.dart';
import 'package:dirham_uae/app/routes/app_pages.dart';
import 'package:dirham_uae/config/theme/light_theme_colors.dart';
import 'package:dirham_uae/config/theme/my_images.dart';
import 'package:dirham_uae/config/theme/my_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../global/profile/account_details/controllers/account_details_controller.dart';
import '../../customer_service_details/bindings/customer_service_details_binding.dart';
import '../controllers/customer_home_controller.dart';

class CustomerHomeView extends GetView<CustomerHomeController> {
  CustomerHomeView({Key? key}) : super(key: key);

  final CustomerHomeController customerHomeController =
      Get.put(CustomerHomeController());

  final CustomerAccountDetailsController customerAccountDetailsController =
      Get.put(CustomerAccountDetailsController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return RefreshIndicator(
      onRefresh: () async {
        controller.isRefreshing.value = true;
        await controller.getCustomeService();
        await controller.loadSavedLocation();
        controller.isRefreshing.value = false;
      },
      child: Scaffold(
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
                            showFavorite: false,
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
      ),
    );
  }

  Widget _buildSearchSection() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: TextField(
                  controller: controller.searchController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Search Your Service",
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16.r, vertical: 12.r),
                  ),
                  onChanged: (value) {
                    controller.filterServices(value);
                  },
                ),
              ),
            ),
            SizedBox(width: 8.r), // Gap between search field and filter button
            Container(
              width: 46.r, // Fixed width for square button
              height: 46.r, // Same height as search field
              decoration: BoxDecoration(
                color: Colors.blue, // Using blue color as shown in UI
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: InkWell(
                onTap: () {
                  controller.toggleFilterOptions();
                },
                child: Padding(
                  padding: EdgeInsets.all(12.r),
                  child: Image.asset(
                    Img.filterIcon,
                    // Make sure to add this image to your assets
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
        // Filter options dropdown
        Obx(() => controller.showFilterOptions.value
            ? Container(
                margin: EdgeInsets.only(top: 8.r),
                padding: EdgeInsets.all(16.r),
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Filters:',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                    SizedBox(height: 16.r),

                    // Status Filters
                    Text('Status:', style: TextStyle(color: Colors.white)),
                    SizedBox(height: 8.r),
                    Wrap(
                      spacing: 8.r,
                      children: controller.availableStatuses
                          .map(
                            (status) => Obx(() => FilterChip(
                                  label: Text(status),
                                  selected: controller.selectedStatuses
                                      .contains(status),
                                  onSelected: (bool selected) {
                                    controller.toggleFilter(
                                        status, controller.selectedStatuses);
                                  },
                                )),
                          )
                          .toList(),
                    ),

                    SizedBox(height: 16.r),

                    // Currency Filters
                    Text('Currency:', style: TextStyle(color: Colors.white)),
                    SizedBox(height: 8.r),
                    Wrap(
                      spacing: 8.r,
                      children: controller.availableCurrencies
                          .map(
                            (currency) => Obx(() => FilterChip(
                                  label: Text(currency),
                                  selected: controller.selectedCurrencies
                                      .contains(currency),
                                  onSelected: (bool selected) {
                                    controller.toggleFilter(currency,
                                        controller.selectedCurrencies);
                                  },
                                )),
                          )
                          .toList(),
                    ),

                    SizedBox(height: 16.r),

                    // Level Filters
                    Text('Level:', style: TextStyle(color: Colors.white)),
                    SizedBox(height: 8.r),
                    Wrap(
                      spacing: 8.r,
                      children: controller.availableLevels
                          .map(
                            (level) => Obx(() => FilterChip(
                                  label: Text(level),
                                  selected:
                                      controller.selectedLevels.contains(level),
                                  onSelected: (bool selected) {
                                    controller.toggleFilter(
                                        level, controller.selectedLevels);
                                  },
                                )),
                          )
                          .toList(),
                    ),

                    SizedBox(height: 16.r),

                    // Price Type Filters
                    Text('Price Type:', style: TextStyle(color: Colors.white)),
                    SizedBox(height: 8.r),
                    Wrap(
                      spacing: 8.r,
                      children: controller.availablePriceTypes
                          .map(
                            (priceType) => Obx(() => FilterChip(
                                  label: Text(priceType),
                                  selected: controller.selectedPriceTypes
                                      .contains(priceType),
                                  onSelected: (bool selected) {
                                    controller.toggleFilter(priceType,
                                        controller.selectedPriceTypes);
                                  },
                                )),
                          )
                          .toList(),
                    ),
                  ],
                ),
              )
            : SizedBox.shrink()),

        // Search results dropdown
        Obx(() => controller.searchResults.isNotEmpty
            ? Container(
                margin: EdgeInsets.only(top: 8.r),
                constraints: BoxConstraints(maxHeight: 300.h),
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.searchResults.length,
                  itemBuilder: (context, index) {
                    final service = controller.searchResults[index];
                    return ListTile(
                      title: Text(
                        service.title ?? 'N/A',
                        style: TextStyle(color: Colors.white),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            service.description ?? 'N/A',
                            style: TextStyle(color: Colors.grey[400]),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            '${service.status ?? 'N/A'} | ${service.currency ?? 'N/A'} | ${service.level ?? 'N/A'} | ${service.priceType ?? 'N/A'}',
                            style: TextStyle(
                                color: Colors.grey[400], fontSize: 12),
                          ),
                        ],
                      ),
                      onTap: () {
                        if (service.id != null) {
                          Get.to(
                            () => CustomerServiceDetailsView(service.id!),
                            binding: CustomerServiceDetailsBinding(service.id!),
                            preventDuplicates: false,
                          );
                        }
                      },
                    );
                  },
                ),
              )
            : SizedBox.shrink()),
      ],
    );
  }

  Row _buildHeaderRow() {
    final customerInfo = customerAccountDetailsController.customerInfo.value;
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
                // customerInfo?.profile?.lastName ?? 'User',
                customerInfo?.name ?? 'User',
                style: kSubtitleStyle,
              )
            ],
          ),
        ),
        gapWidth(size: 2.r),
        SmallCustomButton(
          color: LightThemeColors.secounderyColor,
          ontap: () async {
            await Get.toNamed(Routes.CUSTOMER_PICK_LOCATION);
            customerHomeController.currentLocation;
          },
          widget: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.r),
            child: Row(
              children: [
                Image.asset(Img.locationIcon),
                gapWidth(size: 4),
                Obx(() {
                  final location = customerHomeController.currentLocation.value;
                  return Text(
                    location != null
                        ? "${location.locality}, ${location.country}"
                        : "UAE, Dubai",
                    style: kSubtitleStyle,
                  );
                }),
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

// ignore_for_file: unused_label

import 'dart:math';

import 'package:dirham_uae/app/components/row_text.dart';
import 'package:dirham_uae/app/components/small_custom_button.dart';
import 'package:dirham_uae/app/components/small_service_card.dart';
import 'package:dirham_uae/app/modules/provider/description/views/description_view.dart';
import 'package:dirham_uae/app/routes/app_pages.dart';
import 'package:dirham_uae/config/theme/light_theme_colors.dart';
import 'package:dirham_uae/config/theme/my_images.dart';
import 'package:dirham_uae/config/theme/my_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../global/profile/account_details/controllers/account_details_controller.dart';
import '../../favorite_service/controllers/favorite_service_controller.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final HomeController homeController = Get.put(HomeController());
    final CustomerAccountDetailsController accountDetailsController =
        Get.put(CustomerAccountDetailsController());
    final FavoriteServiceController favoriteController =
        Get.put(FavoriteServiceController());

    final accountDetails = accountDetailsController.customerInfo.value;

    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff4C5B7D),
              Color(0xff303030),
              Color(0xff5A5D63),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: RefreshIndicator(
            onRefresh: () => homeController.refreshData(),
            child: SingleChildScrollView(
              child: Obx(
                () => homeController.isGetCategoriesloading.value
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.r)
                                .copyWith(top: 30.r),
                            child: Column(
                              children: [
                                //*********** header section ************ */
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Good Morning",
                                            style: kTitleTextstyle.copyWith(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            accountDetails?.name ?? 'User',
                                            style: kSubtitleStyle,
                                          )
                                        ],
                                      ),
                                    ),
                                    // In your existing header section, replace or modify the location button:
                                    SmallCustomButton(
                                      color: LightThemeColors.secounderyColor,
                                      ontap: () async {
                                        await Get.toNamed(Routes
                                            .CUSTOMER_PICK_LOCATION); // Make sure this route is available
                                        homeController
                                            .currentLocation; // This is good
                                      },
                                      widget: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 5.r),
                                        child: Row(
                                          children: [
                                            Image.asset(Img.locationIcon),
                                            gapWidth(size: 4),
                                            Obx(() {
                                              final location = homeController
                                                  .currentLocation.value;
                                              return Text(
                                                location != null
                                                    ? "${location.locality}, ${location.country}"
                                                    : "UAE, Dubai",
                                                style: kSubtitleStyle,
                                              );
                                            }),
                                            Icon(
                                              Icons.arrow_drop_down,
                                              color:
                                                  LightThemeColors.whiteColor,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    gapWidth(size: 5),
                                    SmallCustomButton(
                                        color: LightThemeColors.secounderyColor,
                                        ontap: () {
                                          Get.toNamed(Routes.NOTIFICATION);
                                        },
                                        widget: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          child:
                                              Image.asset(Img.notificationIcon),
                                        ))
                                  ],
                                ),
                                gapHeight(size: 20),

                                //****************************************** Search section ****************************** */

                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16.r),
                                  child: _buildProviderSearchSection(),
                                ),
                              ],
                            ),
                          ),
                          gapHeight(size: 20),

                          //****************************************** banner section ****************************** */

                          SizedBox(
                            height: size.height * 0.2,
                            child: ListView.builder(
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: 4,
                              itemBuilder: (context, index) {
                                return Container(
                                  width: size.width * 0.8,
                                  margin: EdgeInsets.only(left: 14.r),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.r),
                                    color: LightThemeColors.secounderyColor,
                                    image: DecorationImage(
                                        image: AssetImage(Img.bannerImg),
                                        fit: BoxFit.cover),
                                  ),
                                );
                              },
                            ),
                          ),
                          gapHeight(size: 20),

                          //****************************************** Category section ****************************** */

                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.r),
                            child: Column(
                              children: [
                                RowText(
                                  title: "Category",
                                  buttonName: "See all",
                                  ontap: () {
                                    Get.toNamed(Routes.ALL_CATEGORY);
                                  },
                                ),
                                gapHeight(size: 10),
                                GridView.builder(
                                  shrinkWrap: true,
                                  physics: const BouncingScrollPhysics(),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 3.r,
                                    crossAxisSpacing: 8.r,
                                    mainAxisSpacing: 8.r,
                                  ),
                                  itemCount: min(
                                      4,
                                      homeController.getCategoriesDataModel
                                              .value.data?.length ??
                                          0),
                                  itemBuilder: (context, index) {
                                    final category = homeController
                                        .getCategoriesDataModel
                                        .value
                                        .data?[index];

                                    return GestureDetector(
                                      onTap: () {
                                        Get.toNamed(Routes.ALL_SUB_CATEGORY,
                                            arguments: category?.id);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.r),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8.r),
                                          color:
                                              LightThemeColors.secounderyColor,
                                        ),
                                        child: Row(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.symmetric(
                                                  vertical: 6.r),
                                              width: 40.r,
                                              // Added fixed width
                                              height: 40.r,
                                              // Added fixed height
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8.r),
                                                color:
                                                    LightThemeColors.whiteColor,
                                              ),
                                              padding: EdgeInsets.all(5.r),
                                              child: Image(
                                                image: NetworkImage(category
                                                        ?.image
                                                        ?.toString() ??
                                                    ""),
                                                fit: BoxFit.cover,
                                                errorBuilder: (context, error,
                                                    stackTrace) {
                                                  return Icon(
                                                      Icons.image_not_supported,
                                                      color: LightThemeColors
                                                          .grayColor,
                                                      size: 20.r);
                                                },
                                                loadingBuilder: (context, child,
                                                    loadingProgress) {
                                                  if (loadingProgress == null)
                                                    return child;
                                                  return Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                      value: loadingProgress
                                                                  .expectedTotalBytes !=
                                                              null
                                                          ? loadingProgress
                                                                  .cumulativeBytesLoaded /
                                                              loadingProgress
                                                                  .expectedTotalBytes!
                                                          : null,
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                            SizedBox(width: 5.r),
                                            Expanded(
                                              child: Text(
                                                category?.name.toString() ?? '',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: kSubtitleStyle.copyWith(
                                                  color: LightThemeColors
                                                      .whiteColor,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                )
                              ],
                            ),
                          ),
                          gapHeight(size: 20),

                          // //****************************************** Popular section ****************************** */

                          // Padding(
                          //   padding: EdgeInsets.symmetric(horizontal: 16.r),
                          //   child: RowText(
                          //     title: "Popular Service",
                          //     buttonName: "See all",
                          //     ontap: () => Get.toNamed(Routes.DESCRIPTION),
                          //   ),
                          // ),
                          // gapHeight(size: 20),
                          // SizedBox(
                          //   height: size.height * 0.2.h,
                          //   child: ListView.builder(
                          //     physics: BouncingScrollPhysics(),
                          //     scrollDirection: Axis.horizontal,
                          //     itemCount: 4,
                          //     itemBuilder: (context, index) {
                          //       return Container(
                          //         margin: EdgeInsets.only(left: 14.r),
                          //         width: size.width * 0.8.h,
                          //         child: PopularServiceCard(
                          //           size: size,
                          //           name:
                          //               "Electronics & Gadgets Repair sjdf sldjfls fsdlfj",
                          //           location: "Cambodia",
                          //           description:
                          //               "Marketplace offers solution to all your desktop hardware and software related problems without you needing to get out of your ",
                          //           priceLevel: "Fixed Price- Entry level",
                          //           price: "200",
                          //           onTap: () => Get.toNamed(Routes.DESCRIPTION),
                          //         ),
                          //       );
                          //     },
                          //   ),
                          // ),

                          //****************************************** Recommended section ****************************** */

                          gapHeight(size: 20),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.r),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RowText(
                                    title: "Recommended services",
                                    buttonName: "",
                                    ontap: () {},
                                  ),
                                  gapHeight(size: 10),
                                  GridView.builder(
                                    itemCount: homeController
                                            .getProviderServiceModel
                                            .value
                                            .data
                                            ?.length ??
                                        0,
                                    shrinkWrap: true,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 0.7.r,
                                      crossAxisSpacing: 6,
                                      mainAxisSpacing: 6,
                                    ),
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (ctx, index) {
                                      // New way
                                      final service = homeController
                                          .getProviderServiceModel
                                          .value
                                          .data?[index];
                                      if (service == null) return SizedBox();

                                      print(
                                          'Building ServiceCard for service ${service.id}');
                                      print(
                                          'Current wishlist state for service: ${favoriteController.wishlistedItems[service.id.toString()]}');
                                      return ServiceCard(
                                        onTap: () {
                                          Get.to(
                                              () => DescriptionView(service));
                                        },
                                        serviceId: service.id.toString(),
                                        // Add this
                                        onWishlistTap: () {
                                          if (service.id != null) {
                                            print(
                                                'Wishlist button tapped for service ${service.id}');

                                            // Find if this service is already in wishlist
                                            final wishlistItem =
                                                favoriteController
                                                    .favoriteServices
                                                    .firstWhereOrNull((item) =>
                                                        item.service?.id ==
                                                        service.id);

                                            if (wishlistItem != null) {
                                              // If it exists in wishlist, delete it
                                              print(
                                                  'Service found in wishlist. Deleting wishlist item ${wishlistItem.id}');
                                              favoriteController.deleteWishlist(
                                                  wishlistItem.id!,
                                                  service.id.toString());
                                            } else {
                                              // If it doesn't exist in wishlist, create it
                                              print(
                                                  'Service not in wishlist. Creating new wishlist item');
                                              favoriteController.createWishlist(
                                                service.id.toString(),
                                                3, // Your provider ID
                                              );
                                            }
                                          }
                                        },
                                        // onWishlistTap: () {
                                        //   if (service.id != null) {
                                        //     print(
                                        //         'Attempting to toggle wishlist');
                                        //     favoriteController.createWishlist(
                                        //       service.id.toString(),
                                        //       3, // Your provider ID
                                        //     );
                                        //   }
                                        // },
                                        imgPath:
                                            service.images?.isNotEmpty == true
                                                ? service.images!.first.path
                                                        ?.toString() ??
                                                    Img.message
                                                : Img.message,
                                        placeName:
                                            service.location?.toString() ??
                                                'N/A',
                                        title:
                                            service.title?.toString() ?? 'N/A',
                                        reviewsPoint: "4.9/5",
                                        reviewsText: "(306 Reviews)",
                                        size: size,
                                        price: service.price?.toString() ?? '0',
                                      );
                                    },
                                  ),
                                ]),
                          )
                        ],
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProviderSearchSection() {
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
                    hintText: "Search Services",
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
            SizedBox(width: 8.r),
            Container(
              width: 46.r,
              height: 46.r,
              decoration: BoxDecoration(
                color: Colors.blue,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Filters:',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        TextButton(
                          onPressed: () => controller.clearFilters(),
                          child: Text(
                            'Clear All',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
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

        // Search results with loading and no results states
        Obx(() {
          // Only show anything if there's an active search or filters
          if (controller.searchController.text.isEmpty &&
              controller.selectedStatuses.isEmpty &&
              controller.selectedCurrencies.isEmpty &&
              controller.selectedLevels.isEmpty &&
              controller.selectedPriceTypes.isEmpty) {
            return SizedBox.shrink();
          }

          if (controller.isSearching.value) {
            return Container(
              margin: EdgeInsets.only(top: 8.r),
              child: Center(child: CircularProgressIndicator()),
            );
          }

          if (controller.showNoResults.value) {
            return Container(
              margin: EdgeInsets.only(top: 8.r),
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Center(
                child: Text(
                  'No results found',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            );
          }

          return controller.searchResults.isNotEmpty
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
                            Get.to(() => DescriptionView(service));
                          }
                        },
                      );
                    },
                  ),
                )
              : SizedBox.shrink();
        }),
      ],
    );
  }
}

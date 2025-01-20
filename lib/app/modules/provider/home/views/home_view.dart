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

import '../controllers/home_controller.dart';
import '../widgets/search_bar.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final HomeController homeController = Get.put(HomeController());

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
                                          "User 1234",
                                          style: kSubtitleStyle,
                                        )
                                      ],
                                    ),
                                  ),
                                  SmallCustomButton(
                                    color: LightThemeColors.secounderyColor,
                                    ontap: () {
                                      Get.toNamed(Routes.PICK_LOCATION);
                                    },
                                    widget: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 5.r),
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
                                padding: EdgeInsets.symmetric(horizontal: 16.r),
                                child: ServiceSearchWidget(),
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
                                    homeController.getCategoriesDataModel.value
                                            .data?.length ??
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
                                        color: LightThemeColors.secounderyColor,
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
                                              image: NetworkImage(
                                                  category?.image?.toString() ??
                                                      ""),
                                              fit: BoxFit.cover,
                                              errorBuilder:
                                                  (context, error, stackTrace) {
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
                                                color:
                                                    LightThemeColors.whiteColor,
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

                                    return ServiceCard(
                                      onTap: () {
                                        Get.to(() => DescriptionView(service));
                                      },
                                      // imgPath: Img.message,
                                      imgPath:
                                          service.images?.isNotEmpty == true
                                              ? service.images!.first.path
                                                      ?.toString() ??
                                                  Img.message
                                              : Img.message,
                                      placeName:
                                          service.location?.toString() ?? 'N/A',
                                      title: service.title?.toString() ?? 'N/A',
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
    );
  }

// Widget _buildSearchSection() {
//   return Column(
//     children: [
//       // Search bar with filter button
//       Row(
//         children: [
//           Expanded(
//             child: Container(
//               decoration: BoxDecoration(
//                 color: Colors.grey[800],
//                 borderRadius: BorderRadius.circular(8.r),
//               ),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: TextField(
//                       controller: controller.searchController,
//                       style: TextStyle(color: Colors.white),
//                       decoration: InputDecoration(
//                         hintText: "Search Your Service",
//                         hintStyle: TextStyle(color: Colors.grey[400]),
//                         prefixIcon:
//                             Icon(Icons.search, color: Colors.grey[400]),
//                         border: InputBorder.none,
//                         contentPadding: EdgeInsets.symmetric(
//                             horizontal: 16.r, vertical: 12.r),
//                       ),
//                     ),
//                   ),
//                   // Container(
//                   //   decoration: BoxDecoration(
//                   //     color: LightThemeColors.primaryColor,
//                   //     borderRadius: BorderRadius.horizontal(
//                   //         right: Radius.circular(8.r)),
//                   //   ),
//                   //   child: IconButton(
//                   //     icon: Icon(Icons.filter_list, color: Colors.white),
//                   //     onPressed: () {
//                   //       controller.toggleFilterOptions();
//                   //     },
//                   //   ),
//                   // ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//
//       // Filter options dropdown
//       Obx(() => controller.showFilterOptions.value
//           ? Container(
//               margin: EdgeInsets.only(top: 8.r),
//               padding: EdgeInsets.all(16.r),
//               decoration: BoxDecoration(
//                 color: Colors.grey[800],
//                 borderRadius: BorderRadius.circular(8.r),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'Filters:',
//                         style: TextStyle(
//                             color: Colors.white, fontWeight: FontWeight.bold),
//                       ),
//                       TextButton(
//                         onPressed: () => controller.clearFilters(),
//                         child: Text(
//                           'Clear All',
//                           style: TextStyle(color: Colors.blue),
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 8.r),
//
//                   // Status Filters
//                   Text('Status:', style: TextStyle(color: Colors.white)),
//                   SizedBox(height: 8.r),
//                   Wrap(
//                     spacing: 8.r,
//                     children: controller.availableStatuses
//                         .map((status) => Obx(() => FilterChip(
//                               label: Text(status),
//                               selected: controller.selectedStatuses
//                                   .contains(status),
//                               onSelected: (bool selected) {
//                                 controller.toggleFilter(
//                                     status, controller.selectedStatuses);
//                               },
//                             )))
//                         .toList(),
//                   ),
//
//                   SizedBox(height: 16.r),
//
//                   // Currency Filters
//                   Text('Currency:', style: TextStyle(color: Colors.white)),
//                   SizedBox(height: 8.r),
//                   Wrap(
//                     spacing: 8.r,
//                     children: controller.availableCurrencies
//                         .map((currency) => Obx(() => FilterChip(
//                               label: Text(currency),
//                               selected: controller.selectedCurrencies
//                                   .contains(currency),
//                               onSelected: (bool selected) {
//                                 controller.toggleFilter(
//                                     currency, controller.selectedCurrencies);
//                               },
//                             )))
//                         .toList(),
//                   ),
//
//                   SizedBox(height: 16.r),
//
//                   // Level Filters
//                   Text('Level:', style: TextStyle(color: Colors.white)),
//                   SizedBox(height: 8.r),
//                   Wrap(
//                     spacing: 8.r,
//                     children: controller.availableLevels
//                         .map((level) => Obx(() => FilterChip(
//                               label: Text(level),
//                               selected:
//                                   controller.selectedLevels.contains(level),
//                               onSelected: (bool selected) {
//                                 controller.toggleFilter(
//                                     level, controller.selectedLevels);
//                               },
//                             )))
//                         .toList(),
//                   ),
//
//                   SizedBox(height: 16.r),
//
//                   // Price Type Filters
//                   Text('Price Type:', style: TextStyle(color: Colors.white)),
//                   SizedBox(height: 8.r),
//                   Wrap(
//                     spacing: 8.r,
//                     children: controller.availablePriceTypes
//                         .map((priceType) => Obx(() => FilterChip(
//                               label: Text(priceType),
//                               selected: controller.selectedPriceTypes
//                                   .contains(priceType),
//                               onSelected: (bool selected) {
//                                 controller.toggleFilter(
//                                     priceType, controller.selectedPriceTypes);
//                               },
//                             )))
//                         .toList(),
//                   ),
//                 ],
//               ),
//             )
//           : SizedBox.shrink()),
//
//       // Search results - only show when search text exists
//       Obx(() => controller.searchController.text.isNotEmpty
//               ? Column(
//                   children: [
//                     // Loading indicator
//                     if (controller.isSearching.value)
//                       Padding(
//                         padding: EdgeInsets.all(8.r),
//                         child: CircularProgressIndicator(),
//                       ),
//
//                     // No results message
//                     if (!controller.isSearching.value &&
//                         controller.searchResults.isEmpty)
//                       Container(
//                         margin: EdgeInsets.only(top: 8.r),
//                         padding: EdgeInsets.all(16.r),
//                         decoration: BoxDecoration(
//                           color: Colors.grey[800],
//                           borderRadius: BorderRadius.circular(8.r),
//                         ),
//                         child: Center(
//                           child: Text(
//                             'No results found',
//                             style: TextStyle(color: Colors.white),
//                           ),
//                         ),
//                       ),
//
//                     // Search results list
//                     if (!controller.isSearching.value &&
//                         controller.searchResults.isNotEmpty)
//                       Container(
//                         margin: EdgeInsets.only(top: 8.r),
//                         constraints: BoxConstraints(maxHeight: 300.h),
//                         decoration: BoxDecoration(
//                           color: Colors.grey[800],
//                           borderRadius: BorderRadius.circular(8.r),
//                         ),
//                         child: ListView.builder(
//                           shrinkWrap: true,
//                           itemCount: controller.searchResults.length,
//                           itemBuilder: (context, index) {
//                             final service = controller.searchResults[index];
//                             return ListTile(
//                               title: Text(
//                                 service.title ?? 'N/A',
//                                 style: TextStyle(color: Colors.white),
//                               ),
//                               subtitle: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     service.description ?? 'N/A',
//                                     style: TextStyle(color: Colors.grey[400]),
//                                     maxLines: 1,
//                                     overflow: TextOverflow.ellipsis,
//                                   ),
//                                   Text(
//                                     '${service.location ?? 'N/A'} | ${service.currency ?? ''} ${service.price?.toString() ?? 'N/A'}',
//                                     style: TextStyle(
//                                         color: Colors.grey[400],
//                                         fontSize: 12),
//                                   ),
//                                 ],
//                               ),
//                               onTap: () {
//                                 Get.to(() => DescriptionView(service));
//                               },
//                             );
//                           },
//                         ),
//                       ),
//                   ],
//                 )
//               : SizedBox.shrink() // Show nothing when search is empty
//           ),
//     ],
//   );
// }
}

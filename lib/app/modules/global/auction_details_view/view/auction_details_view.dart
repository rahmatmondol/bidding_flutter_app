import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';

import '../../../../../config/theme/light_theme_colors.dart';
import '../../../../../config/theme/my_styles.dart';
import '../../../../../utils/global_variable/divider.dart';
import '../../../../../utils/global_variable/my_scaffold_background.dart';
import '../../../../components/custom_appBar.dart';
import '../../../../components/custom_button.dart';
import '../../../../routes/app_pages.dart';
import '../../auction/model/auction_booking_model.dart';
import '../controllers/auction_details_controller.dart';

class AuctionDetailsView extends GetView<AuctionDetailsController> {
  final AuctionModel auction;

  AuctionDetailsView({required this.auction, Key? key}) : super(key: key) {
    print('AuctionDetailsView created with auction: ${auction.title}');
  }

  @override
  Widget build(BuildContext context) {
    print('Building AuctionDetailsView for auction: ${auction.title}');

    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      body: MyScaffoldBackground(
        size: size,
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomHeaderBar(title: 'Auction Details'),
                gapHeight(size: 20.0.h),
                // Title
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                  child: Text(
                    auction.title,
                    style: kTitleTextstyle.copyWith(fontSize: 22.0.sp),
                  ),
                ),
                // Location

                // Padding(
                //   padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                //   child: Row(
                //     children: [
                //       Icon(
                //         Icons.location_on,
                //         color: LightThemeColors.whiteColor,
                //         size: 15,
                //       ),
                //       gapWidth(size: 2.0.w),
                //       Container(
                //         width: 200,
                //         child: Text(
                //           auction.location,
                //           style: TextStyle(color: Colors.grey[400]),
                //           maxLines: 1,
                //           overflow: TextOverflow.ellipsis,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // Posted Date
                gapHeight(size: 10.0.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                  child: Row(
                    children: [
                      Text(
                        'Posted at: ',
                        style: TextStyle(color: Colors.grey[400]),
                      ),
                      Text(
                        DateFormat('MMM dd, yyyy')
                            .format(DateTime.parse(auction.createdAt)),
                        style: TextStyle(color: Colors.grey[400]),
                      ),
                    ],
                  ),
                ),
                gapHeight(size: 10.0.h),

                // Image Slider Section
                Container(
                  height: 280.0,
                  color: LightThemeColors.secounderyColor,
                  width: size.width,
                  child: Stack(
                    children: [
                      Obx(() {
                        return SizedBox(
                          width: size.width,
                          height: 280.0,
                          child: controller.images.isNotEmpty
                              ? Image.network(
                                  controller
                                      .images[controller.currenIndex.value],
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Icon(Icons.error, size: 50);
                                  },
                                )
                              : Center(child: const Text("No image available")),
                        );
                      }),
                      Positioned(
                        top: 190,
                        left: 150.0,
                        child: SizedBox(
                          height: 80.0,
                          width: size.width,
                          child: ListView.builder(
                            itemCount: auction.images.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              final imageData = auction.images[index];
                              return Padding(
                                padding: EdgeInsets.only(right: 5.0),
                                child: InkWell(
                                  onTap: () =>
                                      controller.currenIndex.value = index,
                                  child: Container(
                                    height: 40.0,
                                    width: 60.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.0),
                                      color: LightThemeColors.grayColor
                                          .withOpacity(.5),
                                      border: Border.all(
                                        color: LightThemeColors.primaryColor,
                                      ),
                                    ),
                                    child: Image.network(
                                      imageData.path,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return const Icon(Icons.error,
                                            size: 20);
                                      },
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Description
                gapHeight(size: 10.0.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                  child: ReadMoreText(
                    auction.description,
                    trimLines: 7,
                    colorClickableText: Colors.pink,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: ' Show more',
                    trimExpandedText: ' Show less',
                    lessStyle: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: LightThemeColors.primaryColor,
                    ),
                    moreStyle: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: LightThemeColors.primaryColor,
                    ),
                  ),
                ),

                divider,
                // Price and Level Section
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Price Details",
                        style: kTitleTextstyle.copyWith(fontSize: 15.0.sp),
                      ),
                      gapHeight(size: 10.0.h),
                      Row(
                        children: [
                          Text(
                            "${auction.currency} ${auction.price}",
                            style: kTitleTextstyle.copyWith(
                              fontSize: 18.0.sp,
                              color: LightThemeColors.primaryColor,
                            ),
                          ),
                          Text(
                            " (${auction.priceType})",
                            style: TextStyle(color: Colors.grey[400]),
                          ),
                        ],
                      ),
                      Text(
                        "Level: ${auction.level}",
                        style: TextStyle(color: Colors.grey[400]),
                      ),
                    ],
                  ),
                ),
                divider,

                // Skills Section
                // if (auction.skills != null) ...[
                //   Padding(
                //     padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                //     child: Text(
                //       "Skills Required",
                //       style: kTitleTextstyle.copyWith(fontSize: 15.0.sp),
                //     ),
                //   ),
                //   gapHeight(size: 10.0.h),
                //   Padding(
                //     padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                //     child: Wrap(
                //       spacing: 8.0.w,
                //       runSpacing: 8.0.h,
                //       children: _buildSkillContainers(auction.skills),
                //     ),
                //   ),
                //   divider,
                // ],

                // Map Section
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                  child: Column(
                    children: [
                      // Container(
                      //   height: size.height / 5.7,
                      //   child: ClipRRect(
                      //     borderRadius: BorderRadius.circular(15),
                      //     child: GoogleMap(
                      //       initialCameraPosition: CameraPosition(
                      //         target: LatLng(
                      //           double.tryParse(auction.latitude) ?? 0.0,
                      //           double.tryParse(auction.longitude) ?? 0.0,
                      //         ),
                      //         zoom: 10.5,
                      //       ),
                      //       markers: {
                      //         Marker(
                      //           markerId: MarkerId("auction_location"),
                      //           position: LatLng(
                      //             double.tryParse(auction.latitude) ?? 0.0,
                      //             double.tryParse(auction.longitude) ?? 0.0,
                      //           ),
                      //         )
                      //       },
                      //     ),
                      //   ),
                      // ),
                      //
                      // // View Map Button
                      // gapHeight(size: 12.0.h),
                      // GestureDetector(
                      //   onTap: () {
                      //     Get.to(() => FullMapView(
                      //           latitude:
                      //               double.tryParse(auction.latitude) ?? 0.0,
                      //           longitude:
                      //               double.tryParse(auction.longitude) ?? 0.0,
                      //           location: auction.location,
                      //         ));
                      //   },
                      //   child: Padding(
                      //     padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                      //     child: Container(
                      //       height: size.height / 14,
                      //       decoration: BoxDecoration(
                      //         border: Border.all(
                      //           color: LightThemeColors.whiteColor,
                      //         ),
                      //         borderRadius: BorderRadius.circular(15.0.r),
                      //       ),
                      //       child: Padding(
                      //         padding:
                      //             EdgeInsets.symmetric(horizontal: 12.0.w),
                      //         child: Row(
                      //           mainAxisAlignment:
                      //               MainAxisAlignment.spaceBetween,
                      //           children: [
                      //             Text(
                      //               'View Map',
                      //               style: kTitleTextstyle,
                      //             ),
                      //             Text(
                      //               'Find auction location',
                      //               style: kSubtitleStyle.copyWith(
                      //                   fontSize: 11.2.sp),
                      //             ),
                      //             Image.asset(
                      //               Img.arrowIcon,
                      //               scale: 3.8,
                      //             )
                      //           ],
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),

                      // Bid Button
                      // Padding(
                      //   padding: EdgeInsets.symmetric(horizontal: 7.0),
                      //   child: CustomButton(
                      //     bgColor: LightThemeColors.primaryColor,
                      //     ontap: () => Get.toNamed(
                      //       Routes.APPLY,
                      //       arguments: {
                      //         'currency': auction.currency,
                      //         'price': auction.price,
                      //         'priceType': auction.priceType,
                      //         'serviceId': auction.id,
                      //         'title': auction.title,
                      //         'description': auction.description,
                      //         'createdAt': auction.createdAt,
                      //         'skills': auction.skills != null
                      //             ? (auction.skills is String
                      //                 ? List<String>.from(
                      //                     json.decode(auction.skills!))
                      //                 : auction.skills as List<String>)
                      //             : <String>[],
                      //       },
                      //     ),
                      //     widget: Text(
                      //       "Bid now",
                      //       style: kTitleTextstyle,
                      //     ),
                      //   ),
                      // ),
                      // Add this near the top of the view, after the price details section
                      // Remove the timer section from inside the map container and place it before it
                      // After the price and level section and before the map section
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Time Remaining",
                              style:
                                  kTitleTextstyle.copyWith(fontSize: 15.0.sp),
                            ),
                            gapHeight(size: 5.0.h),
                            Obx(() => Text(
                                  controller.remainingTime.value,
                                  style: TextStyle(
                                    color: controller.isAuctionEnded.value
                                        ? Colors.red
                                        : LightThemeColors.primaryColor,
                                    fontSize: 18.0.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                          ],
                        ),
                      ),
                      divider,

                      // And modify the Bid Button implementation
                      // Padding(
                      //   padding: EdgeInsets.symmetric(horizontal: 7.0),
                      //   child: Obx(() => CustomButton(
                      //         bgColor: controller.isAuctionEnded.value
                      //             ? LightThemeColors.grayColor
                      //             : LightThemeColors.primaryColor,
                      //         ontap: () => controller.isAuctionEnded.value
                      //             ? null // If auction ended, button is disabled
                      //             : () {
                      //                 // If auction is still active, navigate to APPLY route
                      //                 print('Clicked');
                      //                 Get.toNamed(
                      //                   Routes.APPLY,
                      //                   arguments: {
                      //                     'currency': auction.currency,
                      //                     'price': auction.price,
                      //                     'priceType': auction.priceType,
                      //                     'serviceId': auction.id,
                      //                     'title': auction.title,
                      //                     'description': auction.description,
                      //                     'createdAt': auction.createdAt,
                      //                     'skills': auction.skills != null
                      //                         ? (auction.skills is String
                      //                             ? List<String>.from(json
                      //                                 .decode(auction.skills!))
                      //                             : auction.skills
                      //                                 as List<String>)
                      //                         : <String>[],
                      //                   },
                      //                 );
                      //               },
                      //         widget: Text(
                      //           controller.isAuctionEnded.value
                      //               ? "Auction Ended"
                      //               : "Bid now",
                      //           style: kTitleTextstyle.copyWith(
                      //             color: controller.isAuctionEnded.value
                      //                 ? Colors.grey
                      //                 : LightThemeColors.whiteColor,
                      //           ),
                      //         ),
                      //       )),
                      // ),
                      // Padding(
                      //   padding: EdgeInsets.symmetric(horizontal: 7.0),
                      //   child: CustomButton(
                      //     bgColor: LightThemeColors.primaryColor,
                      //     ontap: () => Get.toNamed(
                      //       Routes.APPLY,
                      //       arguments: {
                      //         'currency': auction.currency,
                      //         'price': auction.price,
                      //         'priceType': auction.priceType,
                      //         'serviceId': auction.id,
                      //         'title': auction.title,
                      //         'description': auction.description,
                      //         'createdAt': auction.createdAt,
                      //         'skills': auction.skills != null
                      //             ? (auction.skills is String
                      //                 ? List<String>.from(
                      //                     json.decode(auction.skills!))
                      //                 : auction.skills as List<String>)
                      //             : <String>[],
                      //       },
                      //     ),
                      //     widget: Text(
                      //       "Bid now",
                      //       style: kTitleTextstyle,
                      //     ),
                      //   ),
                      // ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 7.0),
                        child: Obx(() => CustomButton(
                              bgColor: controller.isAuctionEnded.value
                                  ? LightThemeColors.grayColor
                                  : LightThemeColors.primaryColor,
                              ontap: controller.isAuctionEnded.value
                                  ? null
                                  : () => Get.toNamed(
                                        Routes.APPLY,
                                        arguments: {
                                          'currency': auction.currency,
                                          'price': auction.price,
                                          'priceType': auction.priceType,
                                          'serviceId': auction.id,
                                          'title': auction.title,
                                          'description': auction.description,
                                          'createdAt': auction.createdAt,
                                          'skills': auction.skills != null
                                              ? (auction.skills is String
                                                  ? List<String>.from(json
                                                      .decode(auction.skills!))
                                                  : auction.skills
                                                      as List<String>)
                                              : <String>[],
                                        },
                                      ),
                              widget: Text(
                                controller.isAuctionEnded.value
                                    ? "Auction Ended"
                                    : "Bid now",
                                style: kTitleTextstyle.copyWith(
                                  color: controller.isAuctionEnded.value
                                      ? Colors.grey
                                      : LightThemeColors.whiteColor,
                                ),
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildSkillContainers(dynamic skills) {
    if (skills == null) return [];

    List<String> skillsList;
    if (skills is String) {
      try {
        skillsList = List<String>.from(json.decode(skills));
      } catch (e) {
        return [_buildSkillContainer("Invalid skills format")];
      }
    } else if (skills is List) {
      skillsList = List<String>.from(skills);
    } else {
      return [_buildSkillContainer("Invalid skills format")];
    }

    return skillsList.map((skill) => _buildSkillContainer(skill)).toList();
  }

  Widget _buildSkillContainer(String skill) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 3.0.h),
      decoration: BoxDecoration(
        color: LightThemeColors.grayColor,
        borderRadius: BorderRadius.circular(10.0.r),
      ),
      child: Text(skill.trim()),
    );
  }
}

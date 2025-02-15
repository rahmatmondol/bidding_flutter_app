import 'dart:convert';

import 'package:dirham_uae/app/components/booking_card.dart';
import 'package:dirham_uae/config/theme/my_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';

import '../../../../../config/theme/light_theme_colors.dart';
import '../../../../../utils/global_variable/divider.dart';
import '../../../../components/custom_button.dart';
import '../../../../routes/app_pages.dart';
import '../controllers/auction_booking_controller.dart';
import '../model/auction_bid_model.dart';
import 'bids_in_my_auction.dart';

class MyAuctionsTab extends StatelessWidget {
  MyAuctionsTab({super.key});

  final CustomerAuctionController controller =
      Get.put(CustomerAuctionController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() {
            return Text(
              "My Auction's (${controller.myAuctions.length})",
              style: kSubtitleStyle.copyWith(fontWeight: FontWeight.bold),
            );
          }),
          gapHeight(size: 10),
          Expanded(
            child: Obx(() {
              if (controller.isMyAuctionsLoading.value &&
                  controller.myAuctions.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.error.isNotEmpty &&
                  controller.myAuctions.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(controller.error.value),
                      ElevatedButton(
                        onPressed: controller.refreshAll,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                );
              }

              return RefreshIndicator(
                onRefresh: controller.refreshAll,
                child: controller.myAuctions.isEmpty
                    ? ListView(
                        children: const [
                          Center(
                            child: Text("No auctions found"),
                          ),
                        ],
                      )
                    : ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemCount: controller.myAuctions.length,
                        itemBuilder: (context, index) {
                          final auction = controller.myAuctions[index];
                          return Padding(
                              padding: EdgeInsets.only(bottom: 10.r),
                              child: BookingCard(
                                size: size,
                                name: auction.service.title,
                                description: auction.service.description,
                                priceLevel:
                                    "${auction.service.priceType}- ${auction.service.level}",
                                price: auction.service.price.toString(),
                                showFavorite: false,
                                isButton: auction.status?.toLowerCase() !=
                                    'completed',
                                // Hide button if completed
                                buttonText: getButtonText(auction.status),
                                onTap: () {
                                  final status = auction.status?.toLowerCase();

                                  if (status == 'accepted') {
                                    controller.completeBid(auction.id);
                                  } else if (status == 'pending') {
                                    Get.to(() => BidsInMyAuctionView(),
                                        arguments: auction);
                                  }
                                  // Do nothing for rejected status
                                },
                                onBodyClick: () => showAuctionDetails(auction),
                                // onBodyClick: () {
                                //   Get.to(
                                //     () => AuctionDetailsView(
                                //         auction: auction.service),
                                //     binding: AuctionDetailsBinding(),
                                //     preventDuplicates: false,
                                //   );
                                // },
                              )

                              // BookingCard(
                              //   size: size,
                              //   name: auction.title,
                              //   description: auction.description,
                              //   priceLevel:
                              //       "${auction.priceType}- ${auction.level}",
                              //   price: auction.price.toString(),
                              //   showFavorite: false,
                              //   isButton:
                              //       auction.status?.toLowerCase() != 'completed',
                              //   // Hide button if completed
                              //   buttonText: auction.status?.toLowerCase() ==
                              //           'pending'
                              //       ? 'Accept'
                              //       : auction.status?.toLowerCase() == 'accepted'
                              //           ? 'Complete'
                              //           : 'Rejected',
                              //   // For rejected status
                              //   onTap: () {
                              //     if (auction.status?.toLowerCase() ==
                              //         'pending') {
                              //       Get.to(() => BidsInMyAuctionView(),
                              //           arguments: auction);
                              //     } else if (auction.status?.toLowerCase() ==
                              //         'accepted') {
                              //       controller.completeBid(auction
                              //           .id); // Call complete API for accepted status
                              //     }
                              //     // No action for rejected or completed status
                              //   },
                              //   onBodyClick: () {
                              //     Get.to(
                              //       () => AuctionDetailsView(auction: auction),
                              //       binding: AuctionDetailsBinding(),
                              //       arguments: auction,
                              //       preventDuplicates: false,
                              //     );
                              //   },
                              // ),
                              );
                        },
                      ),
              );
            }),
          )
        ],
      ),
    );
  }

  String getButtonText(String? status) {
    final statusLower = status?.toLowerCase() ?? '';
    switch (statusLower) {
      case 'accepted':
        return 'Complete';
      case 'rejected':
        return 'Rejected';
      case 'pending':
        return 'Pending';
      case 'completed':
        return '';
      default:
        return 'Pending';
    }
  }

  void showAuctionDetails(AuctionBidModel auction) {
    Get.bottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      Container(
        height: Get.height * 0.9,
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
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: Column(
          children: [
            // Handle bar at top
            Container(
              margin: EdgeInsets.symmetric(vertical: 10.r),
              height: 5.h,
              width: 50.w,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),

            // Scrollable content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 15.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      auction.service.title,
                      style: kTitleTextstyle.copyWith(fontSize: 22.sp),
                    ),
                    gapHeight(size: 10.h),

                    // Posted date
                    Row(
                      children: [
                        Text(
                          'Posted at: ',
                          style: TextStyle(color: Colors.grey[400]),
                        ),
                        Text(
                          DateFormat('MMM dd, yyyy').format(
                            DateTime.parse(auction.service.createdAt),
                          ),
                          style: TextStyle(color: Colors.grey[400]),
                        ),
                      ],
                    ),
                    gapHeight(size: 15.h),

                    // Images Section with PageView and Indicators
                    if (auction.service.images.isNotEmpty) ...[
                      Container(
                        height: 200.h,
                        width: double.infinity,
                        child: Column(
                          children: [
                            Expanded(
                              child: PageView.builder(
                                itemCount: auction.service.images.length,
                                onPageChanged: (index) {
                                  controller.currenIndex.value = index;
                                },
                                itemBuilder: (context, index) {
                                  final imageUrl =
                                      auction.service.images[index].path;
                                  return Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.r),
                                      color: LightThemeColors.secounderyColor,
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10.r),
                                      child: Image.network(
                                        imageUrl,
                                        fit: BoxFit.cover,
                                        loadingBuilder:
                                            (context, child, loadingProgress) {
                                          if (loadingProgress == null)
                                            return child;
                                          return Center(
                                            child: CircularProgressIndicator(
                                              color:
                                                  LightThemeColors.primaryColor,
                                            ),
                                          );
                                        },
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.error,
                                                  size: 40,
                                                  color: LightThemeColors
                                                      .whiteColor,
                                                ),
                                                Text(
                                                  'Failed to load image',
                                                  style: TextStyle(
                                                    color: LightThemeColors
                                                        .whiteColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            // Image indicators
                            Obx(() => Container(
                                  padding: EdgeInsets.symmetric(vertical: 10.h),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: List.generate(
                                      auction.service.images.length,
                                      (index) => Container(
                                        margin:
                                            EdgeInsets.symmetric(horizontal: 4),
                                        width: 8,
                                        height: 8,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: controller.currenIndex.value ==
                                                  index
                                              ? LightThemeColors.primaryColor
                                              : LightThemeColors.grayColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                )),
                          ],
                        ),
                      ),
                      gapHeight(size: 15.h),
                    ],

                    // Description
                    ReadMoreText(
                      auction.service.description,
                      trimLines: 7,
                      colorClickableText: LightThemeColors.primaryColor,
                      trimMode: TrimMode.Line,
                      trimCollapsedText: ' Show more',
                      trimExpandedText: ' Show less',
                      style: TextStyle(color: Colors.grey[300]),
                      moreStyle: TextStyle(
                        color: LightThemeColors.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                      lessStyle: TextStyle(
                        color: LightThemeColors.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    divider,

                    // Price Details
                    Text(
                      "Price Details",
                      style: kTitleTextstyle.copyWith(fontSize: 15.sp),
                    ),
                    gapHeight(size: 10.h),
                    Row(
                      children: [
                        Text(
                          "${auction.service.currency} ${auction.service.price}",
                          style: kTitleTextstyle.copyWith(
                            fontSize: 18.sp,
                            color: LightThemeColors.primaryColor,
                          ),
                        ),
                        Text(
                          " (${auction.service.priceType})",
                          style: TextStyle(color: Colors.grey[400]),
                        ),
                      ],
                    ),
                    Text(
                      "Level: ${auction.service.level}",
                      style: TextStyle(color: Colors.grey[400]),
                    ),
                    gapHeight(size: 15.h),

                    // Time Remaining Section
                    Text(
                      "Time Remaining",
                      style: kTitleTextstyle.copyWith(fontSize: 15.sp),
                    ),
                    gapHeight(size: 5.h),
                    Obx(() => Text(
                          controller.remainingTime.value,
                          style: TextStyle(
                            color: controller.isAuctionEnded.value
                                ? Colors.red
                                : LightThemeColors.primaryColor,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                    gapHeight(size: 20.h),

                    // Skills Section
                    if (auction.service.skills != null) ...[
                      Text(
                        "Skills Required",
                        style: kTitleTextstyle.copyWith(fontSize: 15.sp),
                      ),
                      gapHeight(size: 10.h),
                      Wrap(
                        spacing: 8.w,
                        runSpacing: 8.h,
                        children: _buildSkillContainers(auction.service.skills),
                      ),
                      gapHeight(size: 15.h),
                    ],

                    // Bid Now Button
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 7.0),
                      child: Obx(() => CustomButton(
                            bgColor: controller.isAuctionEnded.value ||
                                    auction.status == 'rejected'
                                ? LightThemeColors.grayColor
                                : LightThemeColors.primaryColor,
                            ontap: controller.isAuctionEnded.value ||
                                    auction.status == 'rejected'
                                ? null
                                : () {
                                    Get.back(); // Close bottom sheet
                                    Get.toNamed(
                                      Routes.APPLY,
                                      arguments: {
                                        'currency': auction.service.currency,
                                        'price': auction.service.price,
                                        'priceType': auction.service.priceType,
                                        'serviceId': auction.service.id,
                                        'title': auction.service.title,
                                        'description':
                                            auction.service.description,
                                        'createdAt': auction.service.createdAt,
                                        'skills': auction.service.skills != null
                                            ? (auction.service.skills is String
                                                ? List<String>.from(json.decode(
                                                    auction.service.skills!))
                                                : auction.service.skills
                                                    as List<String>)
                                            : <String>[],
                                      },
                                    );
                                  },
                            widget: Text(
                              controller.isAuctionEnded.value
                                  ? "Auction Ended"
                                  : auction.status == 'rejected'
                                      ? "Bid Rejected"
                                      : "Bid now",
                              style: kTitleTextstyle.copyWith(
                                color: controller.isAuctionEnded.value ||
                                        auction.status == 'rejected'
                                    ? Colors.grey
                                    : LightThemeColors.whiteColor,
                              ),
                            ),
                          )),
                    ),
                    gapHeight(size: 20.h),
                  ],
                ),
              ),
            ),
          ],
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
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: LightThemeColors.grayColor,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Text(
        skill.trim(),
        style: TextStyle(color: Colors.grey[300]),
      ),
    );
  }
}

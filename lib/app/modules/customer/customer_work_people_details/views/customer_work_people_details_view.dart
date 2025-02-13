// import 'package:dirham_uae/app/components/animated_progress_indicator.dart';
// import 'package:dirham_uae/app/components/custom_appBar.dart';
// import 'package:dirham_uae/app/components/custom_button.dart';
// import 'package:dirham_uae/app/modules/customer/customer_work_people_details/controllers/customer_work_people_details_controller.dart';
// import 'package:dirham_uae/app/modules/customer/customer_work_people_details/model/get_customer_betting_details_model.dart';
// import 'package:dirham_uae/app/routes/app_pages.dart';
// import 'package:dirham_uae/config/theme/light_theme_colors.dart';
// import 'package:dirham_uae/config/theme/my_styles.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
//
// class CustomerWorkPeopleDetailsView
//     extends GetView<CustomerWorkPeopleDetailsController> {
//   final int id;
//   final int bettingId;
//
//   CustomerWorkPeopleDetailsView(this.id, this.bettingId, {Key? key})
//       : super(key: key) {
//     Get.put(CustomerWorkPeopleDetailsController());
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     controller.getBidDetails(id, bettingId);
//     final size = MediaQuery.sizeOf(context);
//
//     return Scaffold(
//       body: Obx(() {
//         if (controller.isLoading.value) {
//           return const Center(child: CircularProgressIndicator());
//         }
//
//         final bidData = controller.bettingDetails.value.data;
//
//         if (bidData == null) {
//           return const Center(child: Text('No data available'));
//         }
//
//         return Container(
//           height: size.height,
//           width: size.width,
//           padding: EdgeInsets.only(
//             top: 0,
//             left: 15.r,
//             right: 15.r,
//           ),
//           decoration: BoxDecoration(gradient: buildCustomGradient()),
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 CustomHeaderBar(title: 'Bidders Details'),
//                 gapHeight(size: 20),
//
//                 // Provider Info Section
//                 _buildProviderInfo(bidData),
//                 gapHeight(size: 20),
//
//                 // Fixed Amount Section
//                 _buildFixedAmount(bidData),
//                 gapHeight(size: 20),
//
//                 // Bid Section
//                 _buildBidSection(bidData),
//                 gapHeight(size: 20),
//
//                 // Service Fee
//                 Text(
//                   "10% Service fee",
//                   style: kSubtitleStyle.copyWith(fontWeight: FontWeight.bold),
//                 ),
//                 gapHeight(size: 20),
//
//                 // Additional Details Section
//                 _buildAdditionalDetails(bidData),
//                 gapHeight(size: 20),
//
//                 // About Provider Section
//                 if (bidData.provider?.profile?.bio != null)
//                   _buildAboutProvider(bidData),
//
//                 // Reviews Section
//                 _buildReviewsSection(bidData),
//                 gapHeight(size: 20),
//
//                 // Action Buttons
//                 _buildActionButtons(bidData),
//                 gapHeight(size: 20),
//               ],
//             ),
//           ),
//         );
//       }),
//     );
//   }
//
//   Widget _buildProviderInfo(BidData bidData) {
//     final provider = bidData.provider;
//     if (provider == null) return const SizedBox.shrink();
//
//     return Row(
//       children: [
//         CircleAvatar(
//           radius: 30.r,
//           backgroundImage: NetworkImage(provider.profile?.image ?? ''),
//           onBackgroundImageError: (_, __) {},
//         ),
//         gapWidth(size: 10),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 provider.name ?? 'Unknown Provider',
//                 style: kTitleTextstyle,
//               ),
//               Row(
//                 children: [
//                   Icon(
//                     Icons.location_on,
//                     size: 14.sp,
//                     color: LightThemeColors.primaryColor,
//                   ),
//                   gapWidth(size: 5),
//                   Text(
//                     provider.profile?.location ?? 'Location not available',
//                     style: kSubtitleStyle.copyWith(
//                       color: LightThemeColors.secounderyTextColor,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//         InkWell(
//           onTap: () {
//             // Implement chat functionality
//           },
//           child: Container(
//             padding: EdgeInsets.all(8.r),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10.r),
//               color: LightThemeColors.primaryColor,
//             ),
//             child: const Icon(
//               Icons.chat,
//               color: Colors.white,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildFixedAmount(BidData bidData) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Expanded(
//           child: Text(
//             "For this task you have fixed the amount",
//             style: kTitleTextstyle,
//           ),
//         ),
//         Text(
//           "\$${bidData.service?.price ?? 0}",
//           style: kTitleTextstyle.copyWith(
//             color: LightThemeColors.primaryColor,
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildBidSection(BidData bidData) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           "Bid",
//           style: kTitleTextstyle.copyWith(fontWeight: FontWeight.bold),
//         ),
//         gapHeight(size: 10),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Expanded(
//               child: Text(
//                 "This client is scheduled to complete the task",
//                 style: kSubtitleStyle,
//               ),
//             ),
//             Container(
//               padding: EdgeInsets.symmetric(
//                 horizontal: 20.r,
//                 vertical: 10.r,
//               ),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(8.r),
//                 color: LightThemeColors.secounderyColor,
//               ),
//               child: Text(
//                 "\$${bidData.amount ?? 0}",
//                 style: kSubtitleStyle.copyWith(
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
//
//   Widget _buildAdditionalDetails(BidData bidData) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           "Additional details",
//           style: kTitleTextstyle.copyWith(fontWeight: FontWeight.bold),
//         ),
//         gapHeight(size: 10),
//         Container(
//           padding: EdgeInsets.all(10.r),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(8.r),
//             color: LightThemeColors.secounderyColor,
//           ),
//           child: Text(
//             bidData.service?.description ?? 'No additional details available',
//             style: kSubtitleStyle.copyWith(color: Colors.white),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildAboutProvider(BidData bidData) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           "About the provider",
//           style: kTitleTextstyle.copyWith(fontWeight: FontWeight.bold),
//         ),
//         gapHeight(size: 10),
//         Text(
//           bidData.provider?.profile?.bio ?? '',
//           style: kSubtitleStyle,
//         ),
//         gapHeight(size: 20),
//       ],
//     );
//   }
//
//   Widget _buildReviewsSection(BidData bidData) {
//     final reviews = bidData.provider?.reviews;
//     final averageRating = controller.calculateAverageRating(reviews);
//     final totalReviews = reviews?.length ?? 0;
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           "Review",
//           style: kTitleTextstyle.copyWith(fontWeight: FontWeight.bold),
//         ),
//         gapHeight(size: 10),
//
//         Row(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // Average Rating Display
//             Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Text(
//                   averageRating.toStringAsFixed(1),
//                   style: kTitleTextstyle.copyWith(
//                     fontSize: 36.sp,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Text(
//                   "Out of 5",
//                   style: kTitleTextstyle.copyWith(
//                     color: LightThemeColors.secounderyTextColor,
//                   ),
//                 ),
//                 gapHeight(size: 5),
//                 Text(
//                   "$totalReviews Reviews",
//                   style: kSubtitleStyle.copyWith(
//                     color: LightThemeColors.secounderyTextColor,
//                   ),
//                 ),
//               ],
//             ),
//
//             // Star Ratings
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: List.generate(5, (index) {
//                   final starCount = 5 - index;
//                   return StarBox(item: starCount);
//                 }),
//               ),
//             ),
//
//             gapWidth(size: 5),
//
//             // Progress Indicators
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: List.generate(5, (index) {
//                   final starCount = 5 - index;
//                   return AnimatedLinearProgressIndicator(
//                     percentage: controller.calculateRatingPercentage(
//                       reviews,
//                       starCount,
//                     ),
//                   );
//                 }),
//               ),
//             )
//           ],
//         ),
//
//         // Show actual reviews if available
//         if (reviews != null && reviews.isNotEmpty) ...[
//           gapHeight(size: 20),
//           Text(
//             "Recent Reviews",
//             style: kTitleTextstyle.copyWith(fontWeight: FontWeight.bold),
//           ),
//           gapHeight(size: 10),
//           ...reviews.map((review) => _buildReviewItem(review)).toList(),
//         ],
//       ],
//     );
//   }
//
//   Widget _buildReviewItem(dynamic review) {
//     return Container(
//       margin: EdgeInsets.only(bottom: 10.r),
//       padding: EdgeInsets.all(10.r),
//       decoration: BoxDecoration(
//         color: LightThemeColors.secounderyColor.withOpacity(0.1),
//         borderRadius: BorderRadius.circular(8.r),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               StarBox(item: review['rating'] ?? 0),
//               Spacer(),
//               Text(
//                 review['created_at'] != null
//                     ? DateFormat('MMM dd, yyyy')
//                         .format(DateTime.parse(review['created_at']))
//                     : '',
//                 style: kSubtitleStyle,
//               ),
//             ],
//           ),
//           if (review['comment'] != null) ...[
//             gapHeight(size: 5),
//             Text(
//               review['comment'],
//               style: kSubtitleStyle,
//             ),
//           ],
//         ],
//       ),
//     );
//   }
//
//   Widget _buildActionButtons(BidData bidData) {
//     if (bidData.status == 'accepted') {
//       return const SizedBox.shrink();
//     }
//
//     return Row(
//       children: [
//         Expanded(
//           child: CustomButton(
//             bgColor: LightThemeColors.redColor,
//             ontap: () => Get.back(),
//             widget: Text(
//               "Decline",
//               style: kTitleTextstyle.copyWith(
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//         ),
//         gapWidth(size: 20),
//         Expanded(
//           child: CustomButton(
//             bgColor: LightThemeColors.primaryColor,
//             ontap: () => controller.acceptBid(bidData.id ?? 0).then((_) {
//               Get.toNamed(Routes.CUSTOMER_BOOKING);
//             }),
//             widget: Text(
//               "Accept",
//               style: kTitleTextstyle.copyWith(
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// class StarBox extends StatelessWidget {
//   final int item;
//
//   const StarBox({
//     super.key,
//     required this.item,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 20,
//       child: ListView.builder(
//         shrinkWrap: true,
//         physics: const NeverScrollableScrollPhysics(),
//         scrollDirection: Axis.horizontal,
//         itemCount: item,
//         itemBuilder: (context, index) => Icon(
//           Icons.star,
//           color: LightThemeColors.primaryColor,
//           size: 16.sp,
//         ),
//       ),
//     );
//   }
// }

import 'package:dirham_uae/app/components/animated_progress_indicator.dart';
import 'package:dirham_uae/app/components/custom_appBar.dart';
import 'package:dirham_uae/app/components/custom_button.dart';
import 'package:dirham_uae/app/modules/customer/customer_work_people_details/controllers/customer_work_people_details_controller.dart';
import 'package:dirham_uae/app/modules/customer/customer_work_people_details/model/get_customer_betting_details_model.dart';
import 'package:dirham_uae/app/routes/app_pages.dart';
import 'package:dirham_uae/config/theme/light_theme_colors.dart';
import 'package:dirham_uae/config/theme/my_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CustomerWorkPeopleDetailsView
    extends GetView<CustomerWorkPeopleDetailsController> {
  final int id;
  final int bettingId;

  CustomerWorkPeopleDetailsView(this.id, this.bettingId, {Key? key})
      : super(key: key) {
    final controller = Get.put(CustomerWorkPeopleDetailsController());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getBidDetails(id, bettingId);
    });
  }

  @override
  Widget build(BuildContext context) {
    // controller.getBidDetails(id, bettingId);
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final bidData = controller.bettingDetails.value.data;

        if (bidData == null) {
          return const Center(child: Text('No data available'));
        }

        return Container(
          height: size.height,
          width: size.width,
          padding: EdgeInsets.only(
            top: 0,
            left: 15.r,
            right: 15.r,
          ),
          decoration: BoxDecoration(gradient: buildCustomGradient()),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomHeaderBar(title: 'Bidders Details'),
                gapHeight(size: 20),

                // Provider Info Section
                _buildProviderInfo(bidData),
                gapHeight(size: 20),

                // Fixed Amount Section
                _buildFixedAmount(bidData),
                gapHeight(size: 20),

                // Bid Section
                _buildBidSection(bidData),
                gapHeight(size: 20),

                // Service Fee
                Text(
                  "10% Service fee",
                  style: kSubtitleStyle.copyWith(fontWeight: FontWeight.bold),
                ),
                gapHeight(size: 20),

                // Additional Details Section
                _buildAdditionalDetails(bidData),
                gapHeight(size: 20),

                // About Provider Section
                if (bidData.provider?.profile?.bio != null)
                  _buildAboutProvider(bidData),

                // Reviews Section
                _buildReviewsSection(bidData),
                gapHeight(size: 20),

                // Action Buttons
                _buildActionButtons(bidData),
                gapHeight(size: 20),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildProviderInfo(BidData bidData) {
    final provider = bidData.provider;
    if (provider == null) return const SizedBox.shrink();

    return Row(
      children: [
        CircleAvatar(
          radius: 30.r,
          backgroundColor: LightThemeColors.secounderyColor,
          child: provider.profile?.image != null &&
                  provider.profile!.image!.isNotEmpty
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(30.r),
                  child: Image.network(
                    provider.profile!.image!,
                    fit: BoxFit.cover,
                    width: 60.r,
                    height: 60.r,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 30.r,
                      );
                    },
                  ),
                )
              : Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 30.r,
                ),
        ),
        gapWidth(size: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                provider.name ?? 'Unknown Provider',
                style: kTitleTextstyle,
              ),
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    size: 14.sp,
                    color: LightThemeColors.primaryColor,
                  ),
                  gapWidth(size: 5),
                  Text(
                    provider.profile?.location ?? 'Location not available',
                    style: kSubtitleStyle.copyWith(
                      color: LightThemeColors.secounderyTextColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        InkWell(
          onTap: () {
            // Implement chat functionality
          },
          child: Container(
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: LightThemeColors.primaryColor,
            ),
            child: const Icon(
              Icons.chat,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFixedAmount(BidData bidData) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            "For this task you have fixed the amount",
            style: kTitleTextstyle,
          ),
        ),
        Text(
          "\$${bidData.service?.price ?? 0}",
          style: kTitleTextstyle.copyWith(
            color: LightThemeColors.primaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildBidSection(BidData bidData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Bid",
          style: kTitleTextstyle.copyWith(fontWeight: FontWeight.bold),
        ),
        gapHeight(size: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                "This client is scheduled to complete the task",
                style: kSubtitleStyle,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 20.r,
                vertical: 10.r,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                color: LightThemeColors.secounderyColor,
              ),
              child: Text(
                "\$${bidData.amount ?? 0}",
                style: kSubtitleStyle.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAdditionalDetails(BidData bidData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Additional details",
          style: kTitleTextstyle.copyWith(fontWeight: FontWeight.bold),
        ),
        gapHeight(size: 10),
        Container(
          padding: EdgeInsets.all(10.r),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            color: LightThemeColors.secounderyColor,
          ),
          child: Text(
            bidData.service?.description ?? 'No additional details available',
            style: kSubtitleStyle.copyWith(color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _buildAboutProvider(BidData bidData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "About the provider",
          style: kTitleTextstyle.copyWith(fontWeight: FontWeight.bold),
        ),
        gapHeight(size: 10),
        Text(
          bidData.provider?.profile?.bio ?? '',
          style: kSubtitleStyle,
        ),
        gapHeight(size: 20),
      ],
    );
  }

  Widget _buildReviewsSection(BidData bidData) {
    final reviews = bidData.provider?.reviews;
    final averageRating = controller.calculateAverageRating(reviews);
    final totalReviews = reviews?.length ?? 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Review",
          style: kTitleTextstyle.copyWith(fontWeight: FontWeight.bold),
        ),
        gapHeight(size: 10),

        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Average Rating Display
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  averageRating.toStringAsFixed(1),
                  style: kTitleTextstyle.copyWith(
                    fontSize: 36.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Out of 5",
                  style: kTitleTextstyle.copyWith(
                    color: LightThemeColors.secounderyTextColor,
                  ),
                ),
                gapHeight(size: 5),
                Text(
                  "$totalReviews Reviews",
                  style: kSubtitleStyle.copyWith(
                    color: LightThemeColors.secounderyTextColor,
                  ),
                ),
              ],
            ),

            // Star Ratings
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: List.generate(5, (index) {
                  final starCount = 5 - index;
                  return StarBox(item: starCount);
                }),
              ),
            ),

            gapWidth(size: 5),

            // Progress Indicators
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: List.generate(5, (index) {
                  final starCount = 5 - index;
                  return AnimatedLinearProgressIndicator(
                    percentage: controller.calculateRatingPercentage(
                      reviews,
                      starCount,
                    ),
                  );
                }),
              ),
            )
          ],
        ),

        // Show actual reviews if available
        if (reviews != null && reviews.isNotEmpty) ...[
          gapHeight(size: 20),
          Text(
            "Recent Reviews",
            style: kTitleTextstyle.copyWith(fontWeight: FontWeight.bold),
          ),
          gapHeight(size: 10),
          ...reviews.map((review) => _buildReviewItem(review)).toList(),
        ],
      ],
    );
  }

  Widget _buildReviewItem(dynamic review) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.r),
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
        color: LightThemeColors.secounderyColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              StarBox(item: review['rating'] ?? 0),
              Spacer(),
              Text(
                review['created_at'] != null
                    ? DateFormat('MMM dd, yyyy')
                        .format(DateTime.parse(review['created_at']))
                    : '',
                style: kSubtitleStyle,
              ),
            ],
          ),
          if (review['comment'] != null) ...[
            gapHeight(size: 5),
            Text(
              review['comment'],
              style: kSubtitleStyle,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildActionButtons(BidData bidData) {
    if (bidData.status == 'accepted') {
      return const SizedBox.shrink();
    }

    return Row(
      children: [
        Expanded(
          child: CustomButton(
            bgColor: LightThemeColors.redColor,
            ontap: () => Get.back(),
            widget: Text(
              "Decline",
              style: kTitleTextstyle.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        gapWidth(size: 20),
        Expanded(
          child: CustomButton(
            bgColor: LightThemeColors.primaryColor,
            ontap: () => controller.acceptBid(bidData.id ?? 0).then((_) {
              Get.toNamed(Routes.CUSTOMER_BOOKING);
            }),
            widget: Text(
              "Accept",
              style: kTitleTextstyle.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class StarBox extends StatelessWidget {
  final int item;

  const StarBox({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: item,
        itemBuilder: (context, index) => Icon(
          Icons.star,
          color: LightThemeColors.primaryColor,
          size: 16.sp,
        ),
      ),
    );
  }
}

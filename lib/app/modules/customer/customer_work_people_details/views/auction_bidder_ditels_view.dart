import 'package:dirham_uae/app/modules/global/auction/model/auction_bid_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../config/theme/light_theme_colors.dart';
import '../../../../../config/theme/my_styles.dart';
import '../../../../components/custom_appBar.dart';
import '../../../../components/custom_button.dart';
import '../../../global/auction/controllers/auction_booking_controller.dart';

class AuctionBidderDetailsView extends GetView<CustomerAuctionController> {
  final int bidId;
  final int providerId;

  AuctionBidderDetailsView(this.providerId, this.bidId, {Key? key})
      : super(key: key) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getBidDetails(bidId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      body: Obx(() {
        if (controller.isBidDetailsLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final bidData = controller.bidDetails.value;

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
                CustomHeaderBar(title: 'Auction Bidder Details'),
                gapHeight(size: 20),

                // Provider Info Section
                _buildProviderInfo(bidData),
                gapHeight(size: 20),

                // Bid Amount Section
                _buildBidAmount(bidData),
                gapHeight(size: 20),

                // Message Section
                _buildMessageSection(bidData),
                gapHeight(size: 20),

                // Service Details Section
                _buildServiceDetails(bidData),
                gapHeight(size: 20),

                // Provider Profile Section
                if (bidData.provider?.profile?.bio != null)
                  _buildProviderProfile(bidData),
                gapHeight(size: 20),

                // Reviews Section
                // _buildReviewsSection(bidData),
                gapHeight(size: 20),

                // Action Buttons
                if (bidData.status != 'accepted') _buildActionButtons(bidData),
                gapHeight(size: 20),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildProviderInfo(AuctionBidModel bidData) {
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
                  Expanded(
                    child: Text(
                      provider.profile?.location ?? 'Location not available',
                      style: kSubtitleStyle.copyWith(
                        color: LightThemeColors.secounderyTextColor,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
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

  Widget _buildBidAmount(AuctionBidModel bidData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Bid Amount",
          style: kTitleTextstyle.copyWith(fontWeight: FontWeight.bold),
        ),
        gapHeight(size: 10),
        Container(
          padding: EdgeInsets.all(15.r),
          decoration: BoxDecoration(
            color: LightThemeColors.secounderyColor,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Offered Price",
                style: kSubtitleStyle.copyWith(color: Colors.white),
              ),
              Text(
                "\$${bidData.amount ?? 0}",
                style: kTitleTextstyle.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMessageSection(AuctionBidModel bidData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Message",
          style: kTitleTextstyle.copyWith(fontWeight: FontWeight.bold),
        ),
        gapHeight(size: 10),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(15.r),
          decoration: BoxDecoration(
            color: LightThemeColors.secounderyColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Text(
            bidData.message ?? 'No message provided',
            style: kSubtitleStyle,
          ),
        ),
      ],
    );
  }

  Widget _buildServiceDetails(AuctionBidModel bidData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Service Details",
          style: kTitleTextstyle.copyWith(fontWeight: FontWeight.bold),
        ),
        gapHeight(size: 10),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(15.r),
          decoration: BoxDecoration(
            color: LightThemeColors.secounderyColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Text(
            bidData.service?.description ?? 'No service details available',
            style: kSubtitleStyle,
          ),
        ),
      ],
    );
  }

  Widget _buildProviderProfile(AuctionBidModel bidData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "About Provider",
          style: kTitleTextstyle.copyWith(fontWeight: FontWeight.bold),
        ),
        gapHeight(size: 10),
        Text(
          bidData.provider?.profile?.bio ?? '',
          style: kSubtitleStyle,
        ),
      ],
    );
  }

  // Widget _buildReviewsSection(AuctionBidModel bidData) {
  //   final reviews = bidData.provider;
  //   if (reviews == null || reviews.isEmpty) return const SizedBox.shrink();
  //
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Text(
  //         "Reviews",
  //         style: kTitleTextstyle.copyWith(fontWeight: FontWeight.bold),
  //       ),
  //       gapHeight(size: 10),
  //       ...reviews.map((review) => Container(
  //         margin: EdgeInsets.only(bottom: 10.r),
  //         padding: EdgeInsets.all(10.r),
  //         decoration: BoxDecoration(
  //           color: LightThemeColors.secounderyColor.withOpacity(0.1),
  //           borderRadius: BorderRadius.circular(8.r),
  //         ),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Row(
  //               children: [
  //                 StarBox(item: review['rating'] ?? 0),
  //                 Spacer(),
  //                 Text(
  //                   review['created_at'] != null
  //                       ? DateFormat('MMM dd, yyyy')
  //                       .format(DateTime.parse(review['created_at']))
  //                       : '',
  //                   style: kSubtitleStyle,
  //                 ),
  //               ],
  //             ),
  //             if (review['comment'] != null) ...[
  //               gapHeight(size: 5),
  //               Text(
  //                 review['comment'],
  //                 style: kSubtitleStyle,
  //               ),
  //             ],
  //           ],
  //         ),
  //       )).toList(),
  //     ],
  //   );
  // }

  Widget _buildActionButtons(AuctionBidModel bidData) {
    return Row(
      children: [
        Expanded(
          child: CustomButton(
            bgColor: LightThemeColors.redColor,
            ontap: () => controller.rejectBid(bidData.id ?? 0),
            widget: Text(
              "Reject",
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
            ontap: () => controller.acceptBid(bidData.id ?? 0),
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

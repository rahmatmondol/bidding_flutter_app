import 'package:dirham_uae/app/components/custom_appBar.dart';
import 'package:dirham_uae/config/theme/my_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../components/proposal_card.dart';
import '../controllers/my_auction_bidding_to_others_proposals_controller.dart';

// proposals_view.dart
class MyAuctionBidsToOtherProposalsView
    extends GetView<MyAuctionBiddingToOthersProposalsController> {
  const MyAuctionBidsToOtherProposalsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
          top: 0,
          left: 15.r,
          right: 15.r,
        ),
        decoration: BoxDecoration(gradient: buildCustomGradient()),
        child: Column(
          children: [
            CustomHeaderBar(title: 'My Proposals'),
            gapHeight(size: 20),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.bids.isEmpty) {
                  return const Center(child: Text('No proposals found'));
                }

                return RefreshIndicator(
                  onRefresh: () => controller.fetchBids(),
                  child: ListView.builder(
                    itemCount: controller.bids.length,
                    itemBuilder: (context, index) {
                      final bid = controller.bids[index];
                      return Container(
                        margin: EdgeInsets.only(bottom: 20.r),
                        child: ProposalCard(
                          name: bid.service.title.toString(),
                          date: bid.createdAt.toFormattedDate(),
                          // Shows as "26 Jan 24"

                          duration: bid.updatedAt.getDurationFromNow(),
                          status: bid.status.capitalizeFirst ?? 'Unknown',
                          ontap: () {
                            // Handle tap
                          },
                        ),
                      );
                    },
                  ),
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}

extension DateTimeExtension on DateTime {
  String toFormattedDate() {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];

    return '${day.toString().padLeft(2, '0')} ${months[month - 1]} ${year.toString().substring(2)}';
  }

  String getDurationFromNow() {
    final now = DateTime.now();
    final difference = now.difference(this);

    // Convert to days
    final days = difference.inDays;

    if (days >= 30) {
      final months = (days / 30).floor();
      return months == 1 ? '1 month ago' : '$months months ago';
    } else {
      return days == 1 ? '1 day ago' : '$days days ago';
    }
  }
}

// Usage example:
// String date = bid.createdAt.toFormattedDate();     // "26 Jan 24"
// String duration = bid.updatedAt.getDurationFromNow(); // "15 days ago" or "2 months ago"

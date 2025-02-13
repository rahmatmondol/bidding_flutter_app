import 'package:dirham_uae/utils/global_variable/my_scaffold_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../components/auction_bid_card.dart';
import '../../../customer/customer_work_people_details/views/auction_bidder_ditels_view.dart';
import '../controllers/auction_booking_controller.dart';

// class BidsInMyAuctionView extends GetView<CustomerAuctionController> {
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.sizeOf(context);
//
//     return Scaffold(
//       body: MyScaffoldBackground(
//         size: size,
//         child: SafeArea(
//           child: Column(
//             children: [
//               Expanded(
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 15.w),
//                   child: Obx(() {
//                     if (controller.isBidsLoading.value) {
//                       return Center(child: CircularProgressIndicator());
//                     }
//
//                     if (controller.error.isNotEmpty) {
//                       return Center(
//                         child: Text(
//                           controller.error.value,
//                           style: TextStyle(color: Colors.white),
//                           maxLines: 2,
//                           overflow: TextOverflow.ellipsis,
//                           textAlign: TextAlign.center,
//                         ),
//                       );
//                     }
//
//                     if (controller.auctionBids.isEmpty) {
//                       return Center(
//                         child: Text(
//                           'No bids found',
//                           style: TextStyle(color: Colors.white),
//                         ),
//                       );
//                     }
//
//                     return RefreshIndicator(
//                       onRefresh: () => controller.fetchAuctionBids(),
//                       child: ListView.builder(
//                         itemCount: controller.auctionBids.length,
//                         itemBuilder: (context, index) {
//                           final bid = controller.auctionBids[index];
//                           return AuctionBidCard(
//                             profileImage: bid.provider.profile?.image ?? '',
//                             bidderName: bid.provider.name,
//                             message: bid.message,
//                             amount: bid.amount.toString(),
//                             currency: bid.service.currency,
//                             createdAt: DateTime.parse(bid.createdAt),
//                             onMessageTap: () {
//                               print('Message tapped for bid ${bid.id}');
//                             },
//                             onAccept: () {
//                               // Handle accept bid
//                               print('Accept bid ${bid.id}');
//                             },
//                             onReject: () {
//                               // Handle reject bid
//                               print('Reject bid ${bid.id}');
//                             },
//                             onCardTap: () {
//                               // Navigate to bid details page
//                               Get.toNamed('/bid-details', arguments: bid);
//                             },
//                           );
//                         },
//                       ),
//                     );
//                   }),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class BidsInMyAuctionView extends GetView<CustomerAuctionController> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      body: MyScaffoldBackground(
        size: size,
        child: SafeArea(
          child: Column(
            children: [
              // CustomHeaderBar(title: 'Auction Bids'),
              // gapHeight(size: 20),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: Obx(() {
                    if (controller.isBidsLoading.value) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (controller.error.isNotEmpty) {
                      return Center(
                        child: Text(
                          controller.error.value,
                          style: TextStyle(color: Colors.white),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      );
                    }

                    if (controller.auctionBids.isEmpty) {
                      return Center(
                        child: Text(
                          'No bids found',
                          style: TextStyle(color: Colors.white),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      );
                    }

                    return RefreshIndicator(
                      onRefresh: () => controller.fetchAuctionBids(),
                      child: ListView.builder(
                        itemCount: controller.auctionBids.length,
                        itemBuilder: (context, index) {
                          final bid = controller.auctionBids[index];
                          return AuctionBidCard(
                            profileImage: bid.provider.profile?.image ?? '',
                            bidderName: bid.provider.name,
                            message: bid.message,
                            amount: bid.amount.toString(),
                            currency: bid.service.currency,
                            createdAt: DateTime.parse(bid.createdAt),
                            onMessageTap: () {
                              print('Message tapped for bid ${bid.id}');
                            },
                            onAccept: () => controller.acceptBid(bid.id),
                            onReject: () => controller.rejectBid(bid.id),
                            onCardTap: () {
                              Get.to(() => AuctionBidderDetailsView(
                                  bid.provider.id, bid.id));
                            },
                            status: bid.status,
                            location: bid.provider.profile?.location ?? 'N/A',
                          );
                        },
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

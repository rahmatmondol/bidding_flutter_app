// import 'package:dirham_uae/app/components/booking_card.dart';
// import 'package:dirham_uae/config/theme/my_styles.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
//
// import '../../auction_details_view/bindings/auction_details_binding.dart';
// import '../../auction_details_view/view/auction_details_view.dart';
// import '../controllers/auction_booking_controller.dart';
//
// class CustomerAllAuctionTab extends StatelessWidget {
//   CustomerAllAuctionTab({super.key});
//
//   final CustomerAuctionController controller =
//       Get.put(CustomerAuctionController());
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.sizeOf(context);
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 15.r),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Obx(() {
//             return Text(
//               "All Auction's (${controller.allBookings.length})",
//               style: kSubtitleStyle.copyWith(fontWeight: FontWeight.bold),
//             );
//           }),
//           gapHeight(size: 10),
//           Expanded(
//             child: Obx(() {
//               if (controller.isAllLoading.value &&
//                   controller.allBookings.isEmpty) {
//                 return const Center(child: CircularProgressIndicator());
//               }
//
//               if (controller.error.isNotEmpty &&
//                   controller.allBookings.isEmpty) {
//                 return Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(controller.error.value),
//                       ElevatedButton(
//                         onPressed: controller.refreshAll,
//                         child: const Text('Retry'),
//                       ),
//                     ],
//                   ),
//                 );
//               }
//
//               return RefreshIndicator(
//                 onRefresh: controller.refreshAll,
//                 child: controller.allBookings.isEmpty
//                     ? ListView(
//                         children: const [
//                           Center(
//                             child: Text("No auctions found"),
//                           ),
//                         ],
//                       )
//                     : ListView.builder(
//                         physics: const AlwaysScrollableScrollPhysics(),
//                         padding: EdgeInsets.zero,
//                         itemCount: controller.allBookings.length,
//                         itemBuilder: (context, index) {
//                           final booking = controller.allBookings[index];
//                           return Padding(
//                             padding: EdgeInsets.only(bottom: 10.r),
//                             child: BookingCard(
//                               size: size,
//                               name: booking.title,
//                               location: booking.location,
//                               description: booking.description,
//                               priceLevel:
//                                   "${booking.priceType}- ${booking.level}",
//                               price: booking.price.toString(),
//                               showFavorite: false,
//                               isButton: false,
//                               onBodyClick: () {
//                                 print(
//                                     "Card tapped for auction: ${booking.title}"); // Debug print
//
//                                 final auction = booking;
//                                 Get.to(
//                                   () => AuctionDetailsView(auction: auction),
//                                   binding: AuctionDetailsBinding(),
//                                   arguments: auction,
//                                   preventDuplicates: false,
//                                 );
//                               },
//                             ),
//                           );
//                         },
//                       ),
//               );
//             }),
//           )
//         ],
//       ),
//     );
//   }
// }
import 'package:dirham_uae/app/components/booking_card.dart';
import 'package:dirham_uae/config/theme/my_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../global/auction/controllers/auction_booking_controller.dart';
import '../../../global/auction_details_view/bindings/auction_details_binding.dart';
import '../../../global/auction_details_view/view/auction_details_view.dart';
import '../controllers/customer_home_controller.dart';

class CustomerAllAuctionTab extends StatelessWidget {
  CustomerAllAuctionTab({super.key});

  final CustomerAuctionController controller =
      Get.put(CustomerAuctionController());
  final CustomerHomeController homeController =
      Get.find<CustomerHomeController>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() {
            final displayList = homeController.searchController.text.isEmpty
                ? controller.allBookings
                : controller.searchResults;
            return Text(
              "All Auction's (${displayList.length})",
              style: kSubtitleStyle.copyWith(fontWeight: FontWeight.bold),
            );
          }),
          gapHeight(size: 10),
          Expanded(
            child: Obx(() {
              if (controller.isAllLoading.value &&
                  controller.allBookings.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }

              final displayList = homeController.searchController.text.isEmpty
                  ? controller.allBookings
                  : controller.searchResults;

              if (displayList.isEmpty) {
                return Center(
                  child: Text(
                    homeController.searchController.text.isEmpty
                        ? "No auctions found"
                        : "No matching auctions found",
                    style: kSubtitleStyle,
                  ),
                );
              }

              return RefreshIndicator(
                onRefresh: controller.refreshAll,
                child: ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: displayList.length,
                  itemBuilder: (context, index) {
                    final auction = displayList[index];
                    return Padding(
                      padding: EdgeInsets.only(bottom: 10.r),
                      child: BookingCard(
                        size: size,
                        name: auction.title,
                        location: auction.location,
                        description: auction.description,
                        priceLevel: "${auction.priceType}- ${auction.level}",
                        price: auction.price.toString(),
                        showFavorite: false,
                        isButton: false,
                        onBodyClick: () {
                          print("Card tapped for auction: ${auction.title}");

                          Get.to(
                            () => AuctionDetailsView(auction: auction),
                            binding: AuctionDetailsBinding(),
                            arguments: auction,
                            preventDuplicates: false,
                          );
                        },
                      ),
                    );
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

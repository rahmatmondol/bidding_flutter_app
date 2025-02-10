import 'package:dirham_uae/config/theme/my_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../components/small_service_card.dart';
import '../../../global/auction/controllers/auction_booking_controller.dart';
import '../../../global/auction_details_view/bindings/auction_details_binding.dart';
import '../../../global/auction_details_view/view/auction_details_view.dart';

class ProviderAllAuctionTab extends StatelessWidget {
  ProviderAllAuctionTab({super.key});

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
              "All Auction's (${controller.allBookings.length})",
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

              if (controller.error.isNotEmpty &&
                  controller.allBookings.isEmpty) {
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
                child: controller.allBookings.isEmpty
                    ? ListView(
                        children: const [
                          Center(
                            child: Text("No auctions found"),
                          ),
                        ],
                      )
                    : GridView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.7.r,
                          crossAxisSpacing: 6,
                          mainAxisSpacing: 6,
                        ),
                        itemCount: controller.allBookings.length,
                        itemBuilder: (context, index) {
                          final booking = controller.allBookings[index];
                          return ServiceCard(
                            showWishlistButton: false,
                            onTap: () {
                              print(
                                  "Card tapped for auction: ${booking.title}");
                              Get.to(
                                () => AuctionDetailsView(auction: booking),
                                binding: AuctionDetailsBinding(),
                                arguments: booking,
                                preventDuplicates: false,
                              );
                            },
                            serviceId: booking.id.toString(),
                            onWishlistTap: () {},
                            // Empty function since we don't need wishlist for auctions
                            imgPath: booking.images.isNotEmpty == true &&
                                    (booking.images.first.path
                                            .startsWith('http') ||
                                        booking.images.first.path
                                            .startsWith('https'))
                                ? booking.images.first.path
                                : 'assets/images/noimage.jpg',
                            placeName: booking.location,
                            title: booking.title,
                            reviewsPoint: "",
                            reviewsText: "",
                            size: size,
                            price: booking.price?.toString() ?? '0',
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
}
// import 'package:dirham_uae/config/theme/my_styles.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
//
// import '../../../../components/small_service_card.dart';
// import '../../../global/auction/controllers/auction_booking_controller.dart';
// import '../../../global/auction_details_view/bindings/auction_details_binding.dart';
// import '../../../global/auction_details_view/view/auction_details_view.dart';
// import '../../favorite_service/controllers/favorite_service_controller.dart';
//
// class ProviderAllAuctionTab extends StatelessWidget {
//   ProviderAllAuctionTab({super.key});
//
//   final CustomerAuctionController controller =
//       Get.put(CustomerAuctionController());
//   final FavoriteServiceController favoriteController =
//       Get.put(FavoriteServiceController());
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
//                     : GridView.builder(
//                         physics: const AlwaysScrollableScrollPhysics(),
//                         padding: EdgeInsets.zero,
//                         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                           crossAxisCount: 2,
//                           childAspectRatio: 0.7.r,
//                           crossAxisSpacing: 6,
//                           mainAxisSpacing: 6,
//                         ),
//                         itemCount: controller.allBookings.length,
//                         itemBuilder: (context, index) {
//                           final auction = controller.allBookings[index];
//
//                           return ServiceCard(
//                             onTap: () {
//                               print(
//                                   "Card tapped for auction: ${auction.title}");
//                               Get.to(
//                                 () => AuctionDetailsView(auction: auction),
//                                 binding: AuctionDetailsBinding(),
//                                 arguments: auction,
//                                 preventDuplicates: false,
//                               );
//                             },
//                             serviceId: auction.id.toString(),
//                             onWishlistTap: () {
//                               if (auction.id != null) {
//                                 print(
//                                     'Wishlist button tapped for auction ${auction.id}');
//
//                                 final wishlistItem = favoriteController
//                                     .favoriteServices
//                                     .firstWhereOrNull((item) =>
//                                         item.service?.id == auction.id);
//
//                                 if (wishlistItem != null) {
//                                   print(
//                                       'Auction found in wishlist. Deleting wishlist item ${wishlistItem.id}');
//                                   favoriteController.deleteWishlist(
//                                       wishlistItem.id!, auction.id.toString());
//                                 } else {
//                                   print(
//                                       'Auction not in wishlist. Creating new wishlist item');
//                                   favoriteController.createWishlist(
//                                     auction.id.toString(),
//                                     3, // Provider ID
//                                   );
//                                 }
//                               }
//                             },
//                             imgPath: auction.images.isNotEmpty &&
//                                     auction.images.first.path.isNotEmpty &&
//                                     (auction.images.first.path
//                                             .startsWith('http') ||
//                                         auction.images.first.path
//                                             .startsWith('https'))
//                                 ? auction.images.first.path
//                                 : 'assets/images/noimage.jpg',
//                             placeName: auction.location,
//                             title: auction.title,
//                             reviewsPoint: "",
//                             reviewsText: "",
//                             size: size,
//                             price: auction.price?.toString() ?? '0',
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

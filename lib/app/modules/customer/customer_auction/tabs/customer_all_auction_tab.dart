import 'package:dirham_uae/app/components/booking_card.dart';
import 'package:dirham_uae/config/theme/my_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../auction_details_view/bindings/auction_details_binding.dart';
import '../../auction_details_view/view/auction_details_view.dart';
import '../controllers/customer_auction_booking_controller.dart';

class CustomerAllAuctionTab extends StatelessWidget {
  CustomerAllAuctionTab({super.key});

  final CustomerAuctionController controller =
      Get.put(CustomerAuctionController());

  String getButtonText(String status) {
    switch (status.toLowerCase()) {
      case "accepted":
        return "Complete";
      case "completed":
        return "Review";
      case "cancelled":
        return "Cancelled";
      default:
        return "";
    }
  }

  bool shouldShowButton(String status) {
    return ["accepted", "completed", "cancelled"]
        .contains(status.toLowerCase());
  }

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
                    : ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemCount: controller.allBookings.length,
                        itemBuilder: (context, index) {
                          final booking = controller.allBookings[index];
                          return Padding(
                            padding: EdgeInsets.only(bottom: 10.r),
                            child: BookingCard(
                              size: size,
                              name: booking.title,
                              location: booking.location,
                              description: booking.description,
                              priceLevel:
                                  "${booking.priceType}- ${booking.level}",
                              price: booking.price.toString(),
                              showFavorite: false,
                              isButton: false,
                              buttonText: getButtonText(booking.status),
                              onBodyClick: () {
                                print(
                                    "Card tapped for auction: ${booking.title}"); // Debug print

                                final auction = booking;
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
          )
        ],
      ),
    );
  }
}

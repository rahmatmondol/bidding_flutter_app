import 'package:dirham_uae/app/components/booking_card.dart';
import 'package:dirham_uae/config/theme/my_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../auction_details_view/bindings/auction_details_binding.dart';
import '../../auction_details_view/view/auction_details_view.dart';
import '../controllers/auction_booking_controller.dart';

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
                              name: auction.title,
                              description: auction.description,
                              priceLevel:
                                  "${auction.priceType}- ${auction.level}",
                              price: auction.price.toString(),
                              showFavorite: false,
                              isButton: false,
                              onBodyClick: () {
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

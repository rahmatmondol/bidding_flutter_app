import 'package:dirham_uae/app/components/booking_card.dart';
import 'package:dirham_uae/app/modules/customer/customer_booking/controllers/customer_booking_controller.dart';
import 'package:dirham_uae/config/theme/my_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomerAllServiceTab extends StatelessWidget {
  CustomerAllServiceTab({super.key});

  final CustomerBookingController controller =
      Get.put(CustomerBookingController());

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
              "All Service's (${controller.allBookings.length})",
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
                            child: Text("No bookings found"),
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
                              name: booking.service.title,
                              location: booking.service.location,
                              description: booking.service.description,
                              priceLevel:
                                  "${booking.service.priceType}- ${booking.service.level}",
                              price: booking.bid.amount.toString(),
                              isButton: shouldShowButton(booking.status),
                              buttonText: getButtonText(booking.status),
                              onTap: () {
                                if (booking.status.toLowerCase() ==
                                    "accepted") {
                                  if (getButtonText(booking.status) ==
                                      "Complete") {
                                    controller.completeBooking(booking.id);
                                  } else {
                                    controller.cancelBooking(booking.id);
                                  }
                                } else if (booking.status.toLowerCase() ==
                                    "completed") {
                                  controller.handleReview(booking.id);
                                }
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

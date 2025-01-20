import 'package:dirham_uae/app/components/booking_card.dart';
import 'package:dirham_uae/app/modules/customer/customer_booking/controllers/customer_booking_controller.dart';
import 'package:dirham_uae/config/theme/my_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomerCompleteServiceTab extends StatelessWidget {
  CustomerCompleteServiceTab({super.key});

  final CustomerBookingController controller =
      Get.put(CustomerBookingController());

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
              "Completed Service's (${controller.completedBookings.length})",
              style: kSubtitleStyle.copyWith(fontWeight: FontWeight.bold),
            );
          }),
          gapHeight(size: 10),
          Expanded(
            child: Obx(() {
              if (controller.isCompletedLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.error.isNotEmpty) {
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

              if (controller.completedBookings.isEmpty) {
                return const Center(child: Text("No completed bookings found"));
              }

              return RefreshIndicator(
                onRefresh: controller.refreshAll,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: controller.completedBookings.length,
                  itemBuilder: (context, index) {
                    final booking = controller.completedBookings[index];
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
                        isButton: true,
                        buttonText: 'Review Now',
                        onTap: () => controller.handleReview(booking.id),
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

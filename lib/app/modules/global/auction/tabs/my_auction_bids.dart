import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../utils/global_variable/my_scaffold_background.dart';
import '../../../../components/booking_card.dart';
import '../controllers/auction_booking_controller.dart';
import '../model/auction_bid_model.dart';

class MyAuctionBidsView extends GetView<CustomerAuctionController> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      body: MyScaffoldBackground(
        size: size,
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Obx(() {
                  if (controller.isBidsLoading.value) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (controller.error.isNotEmpty) {
                    return Center(child: Text(controller.error.value));
                  }

                  if (controller.auctionBids.isEmpty) {
                    return Center(child: Text('No bids found'));
                  }

                  return ListView.separated(
                    padding: EdgeInsets.all(15.0.w),
                    itemCount: controller.auctionBids.length,
                    separatorBuilder: (context, index) =>
                        SizedBox(height: 10.h),
                    itemBuilder: (context, index) {
                      final bid = controller.auctionBids[index];
                      return BookingCard(
                        size: size,
                        name: bid.service.title,
                        location: bid.service.location,
                        description: bid.message,
                        priceLevel:
                            'Bid Amount: ${bid.service.currency} ${bid.amount}',
                        price: bid.service.price.toString(),
                        skills: bid.service.skills != null
                            ? List<String>.from(
                                json.decode(bid.service.skills!))
                            : [],
                        showFavorite: false,
                        isButton: true,
                        buttonText: _getButtonText(bid.status),
                        onTap: () => _handleButtonAction(bid),
                        onBodyClick: () {
                          // Navigate to bid details if needed
                        },
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getButtonText(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return 'Accept Bid';
      case 'accepted':
        return 'Mark Complete';
      case 'completed':
        return 'Completed';
      default:
        return '';
    }
  }

  void _handleButtonAction(AuctionBidModel bid) {
    switch (bid.status.toLowerCase()) {
      case 'pending':
        controller.acceptBid(bid.id);
        break;
      case 'accepted':
        controller.completeBid(bid.id);
        break;
      case 'completed':
        // Maybe navigate to review page or do nothing
        break;
    }
  }
}

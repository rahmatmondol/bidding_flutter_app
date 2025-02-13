import 'dart:async';

import 'package:get/get.dart';

import '../../auction/model/auction_booking_model.dart';

class AuctionDetailsController extends GetxController {
  RxList<String> images = <String>[].obs;
  RxInt currenIndex = 0.obs;
  late final AuctionModel auction;

  // Add these variables for the timer
  RxBool isAuctionEnded = false.obs;
  RxString remainingTime = ''.obs;
  Timer? countdownTimer;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null && Get.arguments is AuctionModel) {
      auction = Get.arguments;
      setImages(auction);
      startTimer();
    } else {
      print('No auction data received in arguments');
    }
  }

  @override
  void onClose() {
    countdownTimer?.cancel();
    super.onClose();
  }

  void startTimer() {
    try {
      final deadline = DateTime.parse(auction.deadline ?? '00.00');
      print('Deadline: $deadline');
      print('Current time: ${DateTime.now()}');

      countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
        final now = DateTime.now();
        final difference = deadline.difference(now);

        print('Time difference: $difference');

        if (difference.isNegative) {
          print('Auction ended');
          timer.cancel();
          isAuctionEnded.value = true;
          remainingTime.value = 'Auction Ended';
        } else {
          final days = difference.inDays;
          final hours = difference.inHours % 24;
          final minutes = difference.inMinutes % 60;
          final seconds = difference.inSeconds % 60;

          remainingTime.value = '${days}d ${hours}h ${minutes}m ${seconds}s';
          print('Updated remaining time: ${remainingTime.value}');
        }
      });
    } catch (e) {
      print('Error in startTimer: $e');
    }
  }

  void setImages(AuctionModel auction) {
    try {
      if (auction.images.isNotEmpty) {
        images.clear();
        images.addAll(
          auction.images
              .where((image) => image.path.isNotEmpty)
              .map((image) => image.path)
              .toList(),
        );
        currenIndex.value = 0;
        print('Set ${images.length} images: ${images.value}');
      }
    } catch (e) {
      print('Error setting images: $e');
    }
  }
}

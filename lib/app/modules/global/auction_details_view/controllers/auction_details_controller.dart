import 'package:get/get.dart';

import '../../auction/model/auction_booking_model.dart';

class AuctionDetailsController extends GetxController {
  RxList<String> images = <String>[].obs;
  RxInt currenIndex = 0.obs;

  late final AuctionModel auction;

  @override
  void onInit() {
    super.onInit();
    // Get the auction data from arguments
    if (Get.arguments != null && Get.arguments is AuctionModel) {
      auction = Get.arguments;
      setImages(auction);
    } else {
      print('No auction data received in arguments');
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

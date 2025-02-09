import 'package:get/get.dart';

import '../controllers/auction_booking_controller.dart';

class CustomerBookingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomerAuctionController>(
      () => CustomerAuctionController(),
    );
  }
}

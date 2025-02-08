import 'package:get/get.dart';

import '../controllers/customer_auction_booking_controller.dart';

class CustomerBookingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomerAuctionController>(
      () => CustomerAuctionController(),
    );
  }
}

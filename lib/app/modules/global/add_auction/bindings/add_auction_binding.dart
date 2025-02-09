import 'package:get/get.dart';

import '../controllers/add_auction_controller.dart';

class CustomerAddServiceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomerAddAuctionController>(
      () => CustomerAddAuctionController(),
    );
  }
}

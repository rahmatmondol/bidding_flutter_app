import 'package:get/get.dart';

import '../controllers/auction_details_controller.dart';

class AuctionDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuctionDetailsController>(() => AuctionDetailsController());
  }
}

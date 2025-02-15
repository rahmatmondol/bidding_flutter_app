import 'package:get/get.dart';

import '../controllers/my_auction_bidding_to_others_proposals_controller.dart';

class MyAuctionBiddingToOthersProposalsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyAuctionBiddingToOthersProposalsController>(
      () => MyAuctionBiddingToOthersProposalsController(),
    );
  }
}

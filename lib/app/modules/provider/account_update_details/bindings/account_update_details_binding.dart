import 'package:get/get.dart';

import '../controllers/account_update_details_controller.dart';

class AccountUpdateDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AccountUpdateDetailsController>(
      () => AccountUpdateDetailsController(),
    );
  }
}

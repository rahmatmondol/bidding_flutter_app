import 'package:get/get.dart';

import '../controllers/customer_account_details_controller.dart';

class CustomerAccountDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomerAccountDetailsController>(
      () => CustomerAccountDetailsController(),
    );
  }
}

import 'package:get/get.dart';

import '../controllers/account_details_controller.dart';

class CustomerAccountDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomerAccountDetailsController>(
      () => CustomerAccountDetailsController(),
      fenix: true,
    );
  }
}

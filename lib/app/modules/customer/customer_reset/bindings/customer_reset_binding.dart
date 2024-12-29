import 'package:get/get.dart';

import '../controllers/customer_reset_controller.dart';

class CustomerResetBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomerResetController>(
      () => CustomerResetController(),
    );
  }
}

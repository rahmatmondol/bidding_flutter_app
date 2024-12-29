import 'package:get/get.dart';

import '../controllers/customer_nav_bar_controller.dart';

class CustomerNavBarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomerNavBarController>(
      () => CustomerNavBarController(),
    );
  }
}

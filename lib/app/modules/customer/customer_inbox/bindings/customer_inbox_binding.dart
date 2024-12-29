import 'package:get/get.dart';

import '../controllers/customer_inbox_controller.dart';

class CustomerInboxBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomerInboxController>(
      () => CustomerInboxController(),
    );
  }
}

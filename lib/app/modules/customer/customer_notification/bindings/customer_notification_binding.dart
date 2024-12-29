import 'package:get/get.dart';

import '../controllers/customer_notification_controller.dart';

class CustomerNotificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomerNotificationController>(
      () => CustomerNotificationController(),
    );
  }
}

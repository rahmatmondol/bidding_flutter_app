import 'package:get/get.dart';

import '../controllers/customer_change_password_controller.dart';

class CustomerChangePasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomerChangePasswordController>(
      () =>CustomerChangePasswordController(),
    );
  }
}

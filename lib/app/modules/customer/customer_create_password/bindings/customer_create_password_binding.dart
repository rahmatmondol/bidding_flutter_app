import 'package:get/get.dart';

import '../controllers/customer_create_password_controller.dart';

class CustomerCreatePasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomerCreatePasswordController>(
      () => CustomerCreatePasswordController(),
    );
  }
}

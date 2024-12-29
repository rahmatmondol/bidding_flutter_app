import 'package:get/get.dart';

import '../controllers/customer_otp_controller.dart';

class CustomerOtpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomerOtpController>(
      () => CustomerOtpController(),
    );
  }
}

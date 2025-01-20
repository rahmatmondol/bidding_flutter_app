import 'package:get/get.dart';

import '../controllers/profile_data_controller.dart';

class CustomerProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomerProfileController>(
      () => CustomerProfileController(),
    );
  }
}

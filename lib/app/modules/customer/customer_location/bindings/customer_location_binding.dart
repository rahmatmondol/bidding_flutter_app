import 'package:get/get.dart';

import '../controllers/customer_location_controller.dart';

class CustomerLocationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomerLocationController>(
      () => CustomerLocationController(),
    );
  }
}

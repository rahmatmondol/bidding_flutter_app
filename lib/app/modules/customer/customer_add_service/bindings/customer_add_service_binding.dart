import 'package:get/get.dart';

import '../controllers/customer_add_service_controller.dart';

class CustomerAddServiceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomerAddServiceController>(
      () => CustomerAddServiceController(),
    );
  }
}

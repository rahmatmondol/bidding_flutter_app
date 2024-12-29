import 'package:get/get.dart';

import '../controllers/customer_update_details_controller.dart';

class CustomerUpdateDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomerUpdateDetailsController>(
      () => CustomerUpdateDetailsController(),
    );
  }
}

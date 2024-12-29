import 'package:get/get.dart';

import '../controllers/customer_search_controller.dart';

class CustomerSearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomerSearchController>(
      () => CustomerSearchController(),
    );
  }
}

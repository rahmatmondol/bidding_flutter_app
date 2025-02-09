import 'package:get/get.dart';

import '../controllers/pick_location_controller.dart';

class CustomerPickLocationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomerPickLocationController>(
      () => CustomerPickLocationController(),
    );
  }
}

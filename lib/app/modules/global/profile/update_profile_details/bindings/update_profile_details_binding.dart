import 'package:get/get.dart';

import '../controllers/update_profile_details_controller.dart';

class CustomerUpdateDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomerUpdateDetailsController>(
      () => CustomerUpdateDetailsController(),
    );
  }
}
